`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:47 12/13/2017 
// Design Name: 
// Module Name:    hmc833 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////





module hmc830(
	output 	wire 					sck_spi,
	output 	wire 					sdi_spi,
	output 	reg 					sen_spi,
	output 	reg 					done,
	input 							start,
	input								clock,
	input 							reset,
	input					[14:0]	FREQ_DATA
    );
/*****************************************************************
Ϊ�������N��Ƶ����������С�����֣��ڳ���������ѡ��ı������С�����ı䱻������С
��������ΪFREQ_DATA
�����Ƶ��Ϊ3000~6000ʱ��vcoƵ��Ϊ1500~3000������Ϊ3000~6000 ����ΪFpd*2 {Fpd[4:0],1'b0}
�����Ƶ��Ϊ1500~3000ʱ��vcoƵ��Ϊ1500~3000������Ϊ1500~3000 ����ΪFpd
�����Ƶ��Ϊ750~1500ʱ��vcoƵ��Ϊ1500~3000������Ϊ750~1500 ����ΪFpd/2  {1'b0,Fpd[5:1]};
******************************************************************/

	reg			[6:0]				Fpd_Divisor;   				//����N��Ƶ��ֵ�ĳ���  
	reg								Fout_Double_fundament;    	//���Ƶ�ʱ�Ƶ��   0����Ƶ    1��ֱͨ   	Vco_Reg03h[0]
	reg			[5:0]				Fout_div	;						//���Ƶ�ʷ�Ƶ��								Vco_Reg02h[5:0]
	wire			[14:0]			Nint;								//N��Ƶ����������ֵ							Reg_03h    ��19λ����λ��0
	
	wire			[6:0]				Nint_Remainder	;				//N��Ƶ������������
	wire			[30:0]			Nfarcdividend;					//N��Ƶ��С�����ֱ�����
	wire			[30:0]			Nfarc;							//N��Ƶ��С������ֵ							Reg_04h	ֻȡ24λ Nfarc[23:0]
	reg								reckon_done;
	reg			[6:0]				reckonTime_cnt;
	

//	assign	Nfarcdividend	= {Nint_Remainder,24'h000000}	;	
	
	// DIVI_Nfarc DIVI_Nfarc (
		// .clk(clock), // input clk
		// .dividend(Nfarcdividend), // input [30 : 0] dividend
		// .divisor(Fpd_Divisor), // input [6 : 0] divisor
		// .quotient(Nfarc) // output [30 : 0] quotient

		// );


	// DIVI_NINT DIVI_NINT (
		// .clk(clock), // input clk
		// .dividend(FREQ_DATA), // input [14 : 0] dividend
		// .divisor(Fpd_Divisor), // input [6 : 0] divisor
		// .quotient(Nint), // output [14 : 0] quotient
		// .fractional(Nint_Remainder)); // output [6 : 0] fractional	
	
//	parameter	Fpd		= 6'd50;			//����Ƶ��50MHz
//	parameter	Fpd		= 6'd125;			//����Ƶ��75MHz
		
	//	Fout_Double_fundament
	// always@(negedge clock or negedge reset)begin
		// if(!reset)Fout_Double_fundament <= 1'b1;
		// else if(FREQ_DATA > 15'd3000) Fout_Double_fundament <= 1'b0;
		// else Fout_Double_fundament <= 1'b1;
	// end
	
	//	Fout_div
	// always@(negedge clock or negedge reset)begin
		// if(!reset) Fout_div <= 6'b00_0001;
		// else if(FREQ_DATA<=15'd1500) Fout_div <= 6'b00_0010;
		// else	Fout_div <= 6'b00_0001;
	// end
	
	// Fpd_Divisor	
	// always@(negedge clock or negedge reset)begin
		// if(!reset) Fpd_Divisor <= {1'b0,Fpd};
		// else if((FREQ_DATA <= 15'd6000)&&(FREQ_DATA > 15'd3000)) Fpd_Divisor <= {Fpd,1'b0};
		// else if((FREQ_DATA <= 15'd3000)&&(FREQ_DATA > 15'd1500)) Fpd_Divisor <= {1'b0,Fpd};
		// else if((FREQ_DATA <= 15'd1500)&&(FREQ_DATA > 15'd750)) Fpd_Divisor <= {2'b00,Fpd[5:1]};
	// end
	
	parameter	S_start		= 3'h0,
					S_reckon		= 3'h1,
					S_idle		= 3'h2,
					S_wr			= 3'h3,
					S_ini			= 3'h4,
					S_done		= 3'h5;
					
	reg [2:0] state,next_state;
	reg [4:0] bit_cnt;
	reg [4:0] reg_cnt;
	
	reg wr_en,load,wr_end,shift,clr_reg_cnt,reckon;
	
	reg [31:0] shift_reg;
	reg [31:0] reg_init;
	
	assign sck_spi = (sen_spi == 1'b1)?clock:1'b0;
	
	assign sdi_spi = shift_reg[31];
	
	always@(negedge clock or negedge reset)
		if(!reset)state <= S_start;
		else state <= next_state;
		
	always@(state or start or bit_cnt or reg_cnt or reckon_done)begin
		wr_en = 0;
		load = 0;
		wr_end = 0;
		shift = 0;
		clr_reg_cnt = 0;
		done			= 0;
		reckon		= 0;
		
		next_state = state;
		
		case(state)
		S_start:		begin
							if(start == 1'b1)
								next_state = S_reckon;
						end
			
		S_reckon:	begin
							reckon = 1'b1;
							if(reckon_done == 1'b1)
								next_state = S_idle;
						end
		
		S_idle:		begin
							wr_en = 1'b1;
							load = 1'b1;
							next_state = S_wr;
						end
						
		S_wr:			begin
							if(bit_cnt == 5'd31)begin
								wr_end = 1'b1;
								next_state = S_ini;
								end
							else
								shift = 1'b1;
						end
							
		S_ini:		begin
							if(reg_cnt == 5'd21)begin
								clr_reg_cnt = 1'b1;
								next_state = S_done;
								end
							else begin
								wr_en = 1'b1;
								load = 1'b1;
								next_state = S_wr;
								end
						end
							
		S_done:		begin
						//	next_state = S_start;   ////
							next_state = next_state;
							done = 1;
						end
							
		default:			next_state = S_start;
		endcase
		end
		
	//sen_spi
	always@(negedge clock or negedge reset)
		if(!reset)sen_spi <= 1'b0;
		else if(wr_en == 1'b1)sen_spi <= 1'b1;
		else if(wr_end == 1'b1)sen_spi <= 1'b0;

		//shift_reg
	always@(negedge clock or negedge reset)
		if(!reset)shift_reg <= 32'h0;
		else if(load == 1'b1)shift_reg <= reg_init;
		else if(shift == 1'b1)shift_reg <= {shift_reg[30:0],1'b0};
		
	//bit_cnt
	always@(negedge clock or negedge reset)
		if(!reset)bit_cnt <= 5'h0;
		else if(bit_cnt == 5'd31)bit_cnt <= 5'h0;
		else if(shift == 1'b1)bit_cnt <= bit_cnt + 1'b1;
		
	//reg_cnt
	always@(negedge clock or negedge reset)
		if(!reset)reg_cnt <= 5'h0;
		else if(clr_reg_cnt == 1'b1)reg_cnt <= 5'h0;
		else if(load == 1'b1)reg_cnt <= reg_cnt + 1'b1;

//	reckonTime_cnt    reckon_done
	always@(negedge clock or negedge reset)begin
		if(!reset)begin
			reckonTime_cnt <= 7'd0;
			reckon_done <= 1'b0;
		end
		else if(reckonTime_cnt == 7'd70)begin
			reckonTime_cnt <= 7'd0;
			reckon_done <= 1'b1;
		end
		else if(reckon == 1'b1)begin
			reckonTime_cnt <= reckonTime_cnt +1'b1;
			reckon_done <= reckon_done;			
		end
		else begin
			reckonTime_cnt <= 7'd0;
			reckon_done <= 1'b0;
		end
	end	

	

	


	always@(reg_cnt or Nint or Fout_div or Nfarc or Fout_Double_fundament)begin
		case(reg_cnt)
			/*HMC830LP6GE�ϵ��ĸ�λ���ϵ���Լ250us��PLL��λ��Ĭ��״ֵ̬*/
		   5'd0:		reg_init = {1'b0,6'h0,24'h00_00_20,1'b0};
			5'd1: 	reg_init = {1'b0,6'h0,24'h00_00_20,1'b0};
			5'd2:		reg_init = {1'b0,6'h0,24'h00_00_00,1'b0};
			5'd3:		reg_init = {1'b0,6'h0,24'h00_00_00,1'b0};

			/*����λ������Reg01h[1] = 1��ʹSPI`s��PLL����*/
			5'd4:		reg_init = {1'b0,6'h1,24'h00_00_02,1'b0};

			/*����Reg02h = 2���������HMC840��ʱ�ӽ���R DIVIDER���FD/PD�Ĳο�Ƶ�ʣ�Fractional Mode B��Ҫ�������FD/PD��Ƶ�����Ϊ100MHz*/
			5'd5:		reg_init = {1'b0,6'h2,24'h00_00_02,1'b0}; //REF  DIVIDER   R = 2  	
		//	5'd6:		reg_init = {1'b0,6'h5,8'h00,3'b111,Fout_div,4'h2,3'b000,1'b0};	//output div vaule Fout_div ��Ƶ����ķ�Ƶ

			/*����Reg05h-VCO_Reg02h������k��ϵ��*/
			5'd6:		reg_init = {1'b0,6'h5,8'h00,3'b111,6'd12,4'h2,3'b000,1'b0};	//output div vaule Fout_div ��Ƶ����ķ�Ƶ

			/*����Reg0bh�����ö�Ӧ�źŵ�Reserved*/
			5'd7:		reg_init = {1'b0,6'hb,24'h07_c0_21,1'b0};

			5'd8:		reg_init = {1'b0,6'hc,24'h00_00_00,1'b0};

			/*����Reg0fh������gpo_selectΪ1��Lock Detect Output��LDO Driver Always On*/
			5'd9:		reg_init = {1'b0,6'hf,24'h00_00_81,1'b0};	

			/*����Reg05h���������Ϊ������������Ĭ�ϵ��Զ����ģʽ*/
			5'd10:	reg_init = {1'b0,6'h5,9'h000,4'h0,2'h0,1'h0,1'b0,4'h3,3'b000,1'b0};   // output  double     x2   Fout_Double_fundament

//			5'd10:	reg_init = {1'b0,6'h5,24'h00_08_18,1'b0};   // output  double     x2   Fout_Double_fundament

			/*Ϊ�˱�֤HMC830LP6GEָ�������ܣ����ձ���Ƽ��Ľ���VCO_Reg05������*/
			5'd11:	reg_init = {1'b0,6'h5,24'h00_16_28,1'b0}; // 24'h00_16_28 = 24'b0000_0000_0001_0110_0010_1000	datasheet default setting

			/*Ϊ�˱�֤HMC830LP6GEָ�������ܣ����ձ���Ƽ��Ľ���VCO_Reg04������*/
			5'd12:	reg_init = {1'b0,6'h5,24'h00_60_a0,1'b0}; // 24'h00_60_a0 = 24'b0000_0000_0110_0000_1010_0000   datasheet default setting 

			/*����Reg05h-VCO_Reg00h��������Ƶ�Σ�������Reg05h���õ����*/
			5'd13:	reg_init = {1'b0,6'h5,24'h00_00_00,1'b0};
			
			5'd14:	reg_init = {1'b0,6'h9,24'h54_23_64,1'b0};

			5'd15:	reg_init = {1'b0,6'h8,24'hc1_be_ff,1'b0};
			
			5'd16:	reg_init = {1'b0,6'h7,24'h00_05_4d,1'b0};
			
			5'd17:	reg_init = {1'b0,6'ha,24'h00_20_46,1'b0};

			5'd18:	reg_init = {1'b0,6'h6,24'h23_0a_7c,1'b0};

		//	5'd19:	reg_init = {1'b0,6'h3,9'h000,Nint,1'b0}; 	//  Reg 03h  N_INT     60    Nint
			5'd19:	reg_init = {1'b0,6'h3,9'h000,15'd48,1'b0}; 	//  Reg 03h  N_INT     20    Nint  min 16

		//	5'd20:	reg_init = {1'b0,6'h4,Nfarc[23:0],1'b0};			//Reg 04h
			/*N��Ƶ��С�����֣�����������*/
			5'd20:	reg_init = {1'b0,6'h4,24'd0,1'b0};			//Reg 04h

			default: reg_init = 32'h0000_0000;
		endcase
	end
			



			  
endmodule				

