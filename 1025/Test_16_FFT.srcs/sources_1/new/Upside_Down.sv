module Upside_Down (
	input clk,    // Clock
	input rst_n,

	input signed [15:0] datain_real,
	input signed [15:0] datain_imaginary,
	input datain_valid,

	output reg signed [15:0] dataout0_real,
	output reg signed [15:0] dataout0_imaginary,
	output reg signed [15:0] dataout1_real,
	output reg signed [15:0] dataout1_imaginary,
	output reg signed [15:0] dataout2_real,
	output reg signed [15:0] dataout2_imaginary,
	output reg signed [15:0] dataout3_real,
	output reg signed [15:0] dataout3_imaginary,
	output reg signed [15:0] dataout4_real,
	output reg signed [15:0] dataout4_imaginary,
	output reg signed [15:0] dataout5_real,
	output reg signed [15:0] dataout5_imaginary,
	output reg signed [15:0] dataout6_real,
	output reg signed [15:0] dataout6_imaginary,
	output reg signed [15:0] dataout7_real,
	output reg signed [15:0] dataout7_imaginary,

	output reg signed [15:0] dataout8_real,
	output reg signed [15:0] dataout8_imaginary,
	output reg signed [15:0] dataout9_real,
	output reg signed [15:0] dataout9_imaginary,
	output reg signed [15:0] dataout10_real,
	output reg signed [15:0] dataout10_imaginary,
	output reg signed [15:0] dataout11_real,
	output reg signed [15:0] dataout11_imaginary,
	output reg signed [15:0] dataout12_real,
	output reg signed [15:0] dataout12_imaginary,
	output reg signed [15:0] dataout13_real,
	output reg signed [15:0] dataout13_imaginary,
	output reg signed [15:0] dataout14_real,
	output reg signed [15:0] dataout14_imaginary,
	output reg signed [15:0] dataout15_real,
	output reg signed [15:0] dataout15_imaginary

  	
);

	reg dataout_valid;	//用来标识输出是否输出（输入数据到8位时再输出数据）

	reg [7:0] datain_cnt;	

	reg [15:0] dataout_real [15:0];
	reg [15:0] dataout_imaginary [15:0];

	integer i;
	integer k;

	/*用于当前已经寄存的数据个数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			datain_cnt <= 8'd0;
		end else if(datain_cnt == 8'd15 && dataout_valid) begin
			datain_cnt <= 8'd0;
		end else if(datain_valid) begin
			datain_cnt <= datain_cnt + 8'd1;
		end else begin
			datain_cnt <= datain_cnt;
		end
	end

	/*用于对测试的数据进行寄存并实现码位倒置*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			
			// generate for(i = 0; i < 16; i = i + 1) begin : generate_15_dataout_reset
			// 	dataout_real[i] <= 16'd0;
			// 	dataout_imaginary[i] <= 16'd0;
			// end endgenerate
			for(i = 0; i < 16; i = i + 1) begin
				dataout_real[i] <= 16'd0;
				dataout_imaginary[i] <= 16'd0;
			end
			

		end else if(datain_valid) begin
			
			// for(j = 0; j < 16; j = j + 1) begin
			// 	dataout_real[j] <= (j == datain_cnt) ? datain_real : dataout_real[j];
			// 	dataout_imaginary[j] <= (j == datain_cnt) ? datain_imaginary : dataout_imaginary[j];
			// end

			case(datain_cnt)
				8'd0 : begin
					dataout_real[0] = datain_real;
					dataout_imaginary[0] = datain_imaginary;
				end
				8'd1 : begin
					dataout_real[1] = datain_real;
					dataout_imaginary[1] = datain_imaginary;
				end
				8'd2 : begin
					dataout_real[2] = datain_real;
					dataout_imaginary[2] = datain_imaginary;
				end
				8'd3 : begin
					dataout_real[3] = datain_real;
					dataout_imaginary[3] = datain_imaginary;
				end
				8'd4 : begin
					dataout_real[4] = datain_real;
					dataout_imaginary[4] = datain_imaginary;
				end
				8'd5 : begin
					dataout_real[5] = datain_real;
					dataout_imaginary[5] = datain_imaginary;
				end
				8'd6 : begin
					dataout_real[6] = datain_real;
					dataout_imaginary[6] = datain_imaginary;
				end
				8'd7 : begin
					dataout_real[7] = datain_real;
					dataout_imaginary[7] = datain_imaginary;
				end



				8'd8 : begin
					dataout_real[8] = datain_real;
					dataout_imaginary[8] = datain_imaginary;
				end
				8'd9 : begin
					dataout_real[9] = datain_real;
					dataout_imaginary[9] = datain_imaginary;
				end
				8'd10 : begin
					dataout_real[10] = datain_real;
					dataout_imaginary[10] = datain_imaginary;
				end
				8'd11 : begin
					dataout_real[11] = datain_real;
					dataout_imaginary[11] = datain_imaginary;
				end
				8'd12 : begin
					dataout_real[12] = datain_real;
					dataout_imaginary[12] = datain_imaginary;
				end
				8'd13 : begin
					dataout_real[13] = datain_real;
					dataout_imaginary[13] = datain_imaginary;
				end
				8'd14 : begin
					dataout_real[14] = datain_real;
					dataout_imaginary[14] = datain_imaginary;
				end
				8'd15 : begin
					dataout_real[15] = datain_real;
					dataout_imaginary[15] = datain_imaginary;
				end
			endcase


		end else begin
			
			// generate for(k = 0; k < 16; k = k + 1) begin : generate_15_dataout_retain
			// 	dataout_real[k] <= dataout_real[k];
			// 	dataout_imaginary[k] <= datain_imaginary[k];
			// end endgenerate
			for(k = 0; k < 16; k = k + 1) begin
				dataout_real[k] <= dataout_real[k];
				dataout_imaginary[k] <= datain_imaginary[k];
			end
			

		end
	end

	/*数据输出使能*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			dataout_valid <= 1'd0;
		end else if(datain_cnt == 8'd15) begin
			dataout_valid <= 1'd1;
		end else begin
			dataout_valid <= 1'd0;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			dataout0_real <= 16'd0;
			dataout0_imaginary <= 16'd0;
			dataout1_real <= 16'd0;
			dataout1_imaginary <= 16'd0;
			dataout2_real <= 16'd0;
			dataout2_imaginary <= 16'd0;
			dataout3_real <= 16'd0;
			dataout3_imaginary <= 16'd0;
			dataout4_real <= 16'd0;
			dataout4_imaginary <= 16'd0;
			dataout5_real <= 16'd0;
			dataout5_imaginary <= 16'd0;
			dataout6_real <= 16'd0;
			dataout6_imaginary <= 16'd0;
			dataout7_real <= 16'd0;
			dataout7_imaginary <= 16'd0;

			dataout8_real <= 16'd0;
			dataout8_imaginary <= 16'd0;
			dataout9_real <= 16'd0;
			dataout9_imaginary <= 16'd0;
			dataout10_real <= 16'd0;
			dataout10_imaginary <= 16'd0;
			dataout11_real <= 16'd0;
			dataout11_imaginary <= 16'd0;
			dataout12_real <= 16'd0;
			dataout12_imaginary <= 16'd0;
			dataout13_real <= 16'd0;
			dataout13_imaginary <= 16'd0;
			dataout14_real <= 16'd0;
			dataout14_imaginary <= 16'd0;
			dataout15_real <= 16'd0;
			dataout15_imaginary <= 16'd0;

		end else if(dataout_valid) begin
			dataout0_real <= dataout_real[0];
			dataout0_imaginary <= dataout_imaginary[0];
			dataout1_real <= dataout_real[8];
			dataout1_imaginary <= dataout_imaginary[8];
			dataout2_real <= dataout_real[4];
			dataout2_imaginary <= dataout_imaginary[4];
			dataout3_real <= dataout_real[12];
			dataout3_imaginary <= dataout_imaginary[12];
			dataout4_real <= dataout_real[2];
			dataout4_imaginary <= dataout_imaginary[2];
			dataout5_real <= dataout_real[10];
			dataout5_imaginary <= dataout_imaginary[10];
			dataout6_real <= dataout_real[6];
			dataout6_imaginary <= dataout_imaginary[6];
			dataout7_real <= dataout_real[14];
			dataout7_imaginary <= dataout_imaginary[14];

			dataout8_real <= dataout_real[1];
			dataout8_imaginary <= dataout_imaginary[1];
			dataout9_real <= dataout_real[9];
			dataout9_imaginary <= dataout_imaginary[9];
			dataout10_real <= dataout_real[5];
			dataout10_imaginary <= dataout_imaginary[5];
			dataout11_real <= dataout_real[13];
			dataout11_imaginary <= dataout_imaginary[13];
			dataout12_real <= dataout_real[3];
			dataout12_imaginary <= dataout_imaginary[3];
			dataout13_real <= dataout_real[11];
			dataout13_imaginary <= dataout_imaginary[11];
			dataout14_real <= dataout_real[7];
			dataout14_imaginary <= dataout_imaginary[7];
			dataout15_real <= dataout_real[15];
			dataout15_imaginary <= dataout_imaginary[15];
		end else begin
			dataout0_real <= dataout0_real;
			dataout0_imaginary <= dataout0_imaginary;
			dataout1_real <= dataout1_real;
			dataout1_imaginary <= dataout1_imaginary;
			dataout2_real <= dataout2_real;
			dataout2_imaginary <= dataout2_imaginary;
			dataout3_real <= dataout3_real;
			dataout3_imaginary <= dataout3_imaginary;
			dataout4_real <= dataout4_real;
			dataout4_imaginary <= dataout4_imaginary;
			dataout5_real <= dataout5_real;
			dataout5_imaginary <= dataout5_imaginary;
			dataout6_real <= dataout6_real;
			dataout6_imaginary <= dataout6_imaginary;
			dataout7_real <= dataout7_real;
			dataout7_imaginary <= dataout7_imaginary;

			dataout8_real <= dataout8_real;
			dataout8_imaginary <= dataout8_imaginary;
			dataout9_real <= dataout9_real;
			dataout9_imaginary <= dataout9_imaginary;
			dataout10_real <= dataout10_real;
			dataout10_imaginary <= dataout10_imaginary;
			dataout11_real <= dataout11_real;
			dataout11_imaginary <= dataout11_imaginary;
			dataout15_real <= dataout12_real;
			dataout15_imaginary <= dataout12_imaginary;
			dataout13_real <= dataout13_real;
			dataout13_imaginary <= dataout13_imaginary;
			dataout14_real <= dataout14_real;
			dataout14_imaginary <= dataout14_imaginary;
			dataout15_real <= dataout15_real;
			dataout15_imaginary <= dataout15_imaginary;
		end
	end

endmodule