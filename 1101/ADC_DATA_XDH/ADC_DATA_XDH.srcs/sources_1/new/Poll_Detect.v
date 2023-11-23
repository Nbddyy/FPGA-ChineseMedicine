// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : Poll_Detect.sv
// Create : 2023-08-11 14:28:12
// Revise : 2023-08-11 20:39:03
// Editor : sublime text4, tab size (4)
// Descri : 进行判断时，避免对一个累加的数据进行条件判断；IP核为超前进位输出
//		  : v2 : 增加至30个FIFO轮询检测，且数据帧头按照HELLO Format
// -----------------------------------------------------------------------------
module Poll_Detect (
	input rd_clk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [10:0] rd_data_count [0:29],
	input [63:0] dout [0:29],
	output reg dout_valid [0:29],
	output data_valid,
	output reg [63:0] up_data
);
	
	reg [63:0] up_data_temp [0:29];
	reg dout_valid_temp [0:29];
	
	reg data_valid_pre;		//定义读使能信号下的输出data_valid_pre

	reg [11:0] cnt_1024;	//用于标识一帧中包含帧头信息192位，有效数据位为8000个字节

	//使用二进制编码表示一下五种状态
	parameter IDLE = 8'd0;
	parameter CH0 = 8'd1;
	parameter CH1 = 8'd2;
	parameter CH2 = 8'd3;
	parameter CH3 = 8'd4;
	parameter CH4 = 8'd5;
	parameter CH5 = 8'd6;
	parameter CH6 = 8'd7;
	parameter CH7 = 8'd8;
	parameter CH8 = 8'd9;
	parameter CH9 = 8'd10;
	parameter CH10 = 8'd11;
	parameter CH11 = 8'd12;
	parameter CH12 = 8'd13;
	parameter CH13 = 8'd14;
	parameter CH14 = 8'd15;
	parameter CH15 = 8'd16;
	parameter CH16 = 8'd17;
	parameter CH17 = 8'd18;
	parameter CH18 = 8'd19;
	parameter CH19 = 8'd20;
	parameter CH20 = 8'd21;
	parameter CH21 = 8'd22;
	parameter CH22 = 8'd23;
	parameter CH23 = 8'd24;
	parameter CH24 = 8'd25;
	parameter CH25 = 8'd26;
	parameter CH26 = 8'd27;
	parameter CH27 = 8'd28;
	parameter CH28 = 8'd29;
	parameter CH29 = 8'd30;

	reg [7:0] state;

	//定义寄存各个缓存通道的发包个数
	reg [63:0] cnt_ch [0:29];
	// reg [63:0] ch_cnt; 	//用于锁存每次读请求下的数据个数

	integer i,k,l;
	/*状态转移的代码实现*/
	always@(posedge rd_clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;

			for(i = 0; i < 30; i = i + 1) begin
				cnt_ch[i] <= 64'd0;
			end
		end else begin
			case(state) 
				IDLE : begin
					if(rd_data_count[0] >= 11'd1000) begin
						state <= CH0;
						cnt_ch[0] <= cnt_ch + 64'd1;
					end else if(rd_data_count[1] >= 11'd1000) begin
						state <= CH1;
						cnt_ch[1] <= cnt_ch + 64'd1;
					end else if(rd_data_count[2] >= 11'd1000) begin
						state <= CH2;
						cnt_ch[2] <= cnt_ch + 64'd1;
					end else if(rd_data_count[3] >= 11'd1000) begin
						state <= CH3;
						cnt_ch[3] <= cnt_ch + 64'd1;
					end else if(rd_data_count[4] >= 11'd1000) begin
						state <= CH4;
						cnt_ch[4] <= cnt_ch + 64'd1;
					end else if(rd_data_count[5] >= 11'd1000) begin
						state <= CH5;
						cnt_ch[5] <= cnt_ch + 64'd1;
					end else if(rd_data_count[6] >= 11'd1000) begin
						state <= CH6;
						cnt_ch[6] <= cnt_ch + 64'd1;
					end else if(rd_data_count[7] >= 11'd1000) begin
						state <= CH7;
						cnt_ch[7] <= cnt_ch + 64'd1;
					end else if(rd_data_count[8] >= 11'd1000) begin
						state <= CH8;
						cnt_ch[8] <= cnt_ch + 64'd1;
					end else if(rd_data_count[9] >= 11'd1000) begin
						state <= CH9;
						cnt_ch[9] <= cnt_ch + 64'd1;
					end else if(rd_data_count[10] >= 11'd1000) begin
						state <= CH10;
						cnt_ch[10] <= cnt_ch + 64'd1;
					end else if(rd_data_count[11] >= 11'd1000) begin
						state <= CH11;
						cnt_ch[11] <= cnt_ch + 64'd1;
					end else if(rd_data_count[12] >= 11'd1000) begin
						state <= CH12;
						cnt_ch[12] <= cnt_ch + 64'd1;
					end else if(rd_data_count[13] >= 11'd1000) begin
						state <= CH13;
						cnt_ch[13] <= cnt_ch + 64'd1;
					end else if(rd_data_count[14] >= 11'd1000) begin
						state <= CH14;
						cnt_ch[14] <= cnt_ch + 64'd1;
					end else if(rd_data_count[15] >= 11'd1000) begin
						state <= CH15;
						cnt_ch[15] <= cnt_ch + 64'd1;
					end else if(rd_data_count[16] >= 11'd1000) begin
						state <= CH16;
						cnt_ch[16] <= cnt_ch + 64'd1;
					end else if(rd_data_count[17] >= 11'd1000) begin
						state <= CH17;
						cnt_ch[17] <= cnt_ch + 64'd1;
					end else if(rd_data_count[18] >= 11'd1000) begin
						state <= CH18;
						cnt_ch[18] <= cnt_ch + 64'd1;
					end else if(rd_data_count[19] >= 11'd1000) begin
						state <= CH19;
						cnt_ch[19] <= cnt_ch + 64'd1;
					end else if(rd_data_count[20] >= 11'd1000) begin
						state <= CH20;
						cnt_ch[20] <= cnt_ch + 64'd1;
					end else if(rd_data_count[21] >= 11'd1000) begin
						state <= CH21;
						cnt_ch[21] <= cnt_ch + 64'd1;
					end else if(rd_data_count[22] >= 11'd1000) begin
						state <= CH22;
						cnt_ch[22] <= cnt_ch + 64'd1;
					end else if(rd_data_count[23] >= 11'd1000) begin
						state <= CH23;
						cnt_ch[23] <= cnt_ch + 64'd1;
					end else if(rd_data_count[24] >= 11'd1000) begin
						state <= CH24;
						cnt_ch[24] <= cnt_ch + 64'd1;
					end else if(rd_data_count[25] >= 11'd1000) begin
						state <= CH25;
						cnt_ch[25] <= cnt_ch + 64'd1;
					end else if(rd_data_count[26] >= 11'd1000) begin
						state <= CH26;
						cnt_ch[26] <= cnt_ch + 64'd1;
					end else if(rd_data_count[27] >= 11'd1000) begin
						state <= CH27;
						cnt_ch[27] <= cnt_ch + 64'd1;
					end else if(rd_data_count[28] >= 11'd1000) begin
						state <= CH28;
						cnt_ch[28] <= cnt_ch + 64'd1;
					end else if(rd_data_count[29] >= 11'd1000) begin
						state <= CH29;
						cnt_ch[29] <= cnt_ch + 64'd1;
					end else begin
						state <= state;
											//cnt_ch不处理，默认保持不变
					end

				end

				default : begin
					state <= (cnt_1024 == 12'd1023) ? IDLE : state;
										    //cnt_ch不处理，默认保持不变
				end 
				
			endcase

		end

	end

	/*cnt_1024用于包装一帧的指示*/
	always @(posedge rd_clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1024 <= 12'd0;
		end else begin
			cnt_1024 <= (state = IDLE) ? 12'd0  : cnt_1024 + 12'd1;
		end
	end

	/*******************************************************************/
	/*up_data数据帧包装发送*/
	
	genvar [7:0] j;		//???????????????????????????????????????????????
	generate for(j = 0; j < 30; j = j + 1) begin : generate_30_core_frame
		
		always @(posedge rd_clk or negedge rst_n) begin
			if(~rst_n) begin
				up_data_temp[j] <= 64'd0;
				dout_valid_temp[j] <= 1'd0;
			end else if(state != IDLE) begin

				case(cnt_1024) 
					12'd0 : begin up_data_temp[j] <= {32'hadf90c00,j+1,24'h0}; dout_valid_temp[j] <= 1'd0; end
					12'd1 : begin up_data_temp[j] <= cnt_ch[j]; dout_valid_temp[j] <= 1'd0; end
					12'd2 : begin
						if(j < 9) begin
							up_data_temp[j] <= {8'h0,j,48'h0};
							dout_valid_temp[j] <= 1'd0;
						end else if(j < 19) begin
							up_data_temp[j] <= {8'h1,j % 9,48'h0};
							dout_valid_temp[j] <= 1'd0;
						end else begin
							up_data_temp[j] <= {8'h2,j % 19,48'h0};
							dout_valid_temp[j] <= 1'd0;
						end
					end 

					12'd3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 : begin
						up_data_temp[j] <= 62'h0;
						dout_valid_temp[j] <= (cnt_1024 == 12'd23) ? 1'd1 ； 1'd0;
					end 

					default : begin up_data_temp[j] <= dout[j]; dout_valid_temp[j] <= 1'd1 end 

				endcase

			end else begin
				up_data_temp[j] <= 64'd0;
				dout_valid_temp[j] <= 1'd0;
			end
		end

	end endgenerate
	/*******************************************************************/

	assign data_valid = (state != IDLE) ? 1'd1 : 1'd0;

	/*dout_valid and up_data*/
	always @(posedge rd_clk or negedge rst_n) begin
		if(~rst_n) begin
			for(k = 0; k < 30; k = k + 1) begin
				dout_valid[k] <= 1'd0;
			end

			up_data <= 64'd0;
		end else begin
			case(state)
				CH0 : begin dout_valid[0] <= dout_valid_temp[0]; up_data <= up_data_temp[0]; end
				CH1 : begin dout_valid[1] <= dout_valid_temp[1]; up_data <= up_data_temp[1]; end
				CH2 : begin dout_valid[2] <= dout_valid_temp[2]; up_data <= up_data_temp[2]; end
				CH3 : begin dout_valid[3] <= dout_valid_temp[3]; up_data <= up_data_temp[3]; end
				CH4 : begin dout_valid[4] <= dout_valid_temp[4]; up_data <= up_data_temp[4]; end
				CH5 : begin dout_valid[5] <= dout_valid_temp[5]; up_data <= up_data_temp[5]; end
				CH6 : begin dout_valid[6] <= dout_valid_temp[6]; up_data <= up_data_temp[6]; end
				CH7 : begin dout_valid[7] <= dout_valid_temp[7]; up_data <= up_data_temp[7]; end
				CH8 : begin dout_valid[8] <= dout_valid_temp[8]; up_data <= up_data_temp[8]; end
				CH9 : begin dout_valid[9] <= dout_valid_temp[9]; up_data <= up_data_temp[9]; end
				CH10 : begin dout_valid[10] <= dout_valid_temp[10]; up_data <= up_data_temp[10]; end
				CH11 : begin dout_valid[11] <= dout_valid_temp[11]; up_data <= up_data_temp[11]; end
				CH12 : begin dout_valid[12] <= dout_valid_temp[12]; up_data <= up_data_temp[12]; end
				CH13 : begin dout_valid[13] <= dout_valid_temp[13]; up_data <= up_data_temp[13]; end
				CH14 : begin dout_valid[14] <= dout_valid_temp[14]; up_data <= up_data_temp[14]; end
				CH15 : begin dout_valid[15] <= dout_valid_temp[15]; up_data <= up_data_temp[15]; end
				CH16 : begin dout_valid[16] <= dout_valid_temp[16]; up_data <= up_data_temp[16]; end
				CH17 : begin dout_valid[17] <= dout_valid_temp[17]; up_data <= up_data_temp[17]; end
				CH18 : begin dout_valid[18] <= dout_valid_temp[18]; up_data <= up_data_temp[18]; end
				CH19 : begin dout_valid[19] <= dout_valid_temp[19]; up_data <= up_data_temp[19]; end
				CH20 : begin dout_valid[20] <= dout_valid_temp[20]; up_data <= up_data_temp[20]; end
				CH21 : begin dout_valid[21] <= dout_valid_temp[21]; up_data <= up_data_temp[21]; end
				CH22 : begin dout_valid[22] <= dout_valid_temp[22]; up_data <= up_data_temp[22]; end
				CH23 : begin dout_valid[23] <= dout_valid_temp[23]; up_data <= up_data_temp[23]; end
				CH24 : begin dout_valid[24] <= dout_valid_temp[24]; up_data <= up_data_temp[24]; end
				CH25 : begin dout_valid[25] <= dout_valid_temp[25]; up_data <= up_data_temp[25]; end
				CH26 : begin dout_valid[26] <= dout_valid_temp[26]; up_data <= up_data_temp[26]; end
				CH27 : begin dout_valid[27] <= dout_valid_temp[27]; up_data <= up_data_temp[27]; end
				CH28 : begin dout_valid[28] <= dout_valid_temp[28]; up_data <= up_data_temp[28]; end
				CH29 : begin dout_valid[29] <= dout_valid_temp[29]; up_data <= up_data_temp[29]; end


				default : begin
					for(l = 0; l < 30; l = l + 1) begin
						dout_valid[l] <= 1'd0;
					end

					up_data <= 64'd0;
				end

			endcase
		end
	end

endmodule