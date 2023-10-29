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

	output reg tx_flag,			//用于反馈SCFIFO已成功读取数据
	output reg dataout_valid 	//用来标识输出是否输出（输入数据到8位时再输出数据）
);

	reg [7:0] datain_cnt;	

	reg [15:0] dataout0_real_temp;
	reg [15:0] dataout0_imaginary_temp;
	reg [15:0] dataout1_real_temp;
	reg [15:0] dataout1_imaginary_temp;
	reg [15:0] dataout2_real_temp;
	reg [15:0] dataout2_imaginary_temp;
	reg [15:0] dataout3_real_temp;
	reg [15:0] dataout3_imaginary_temp;
	reg [15:0] dataout4_real_temp;
	reg [15:0] dataout4_imaginary_temp;
	reg [15:0] dataout5_real_temp;
	reg [15:0] dataout5_imaginary_temp;
	reg [15:0] dataout6_real_temp;
	reg [15:0] dataout6_imaginary_temp;
	reg [15:0] dataout7_real_temp;
	reg [15:0] dataout7_imaginary_temp;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			datain_cnt <= 8'd0;
		end else if(datain_cnt == 8'd7 && dataout_valid) begin
			datain_cnt <= 8'd0;
		end else if(datain_valid) begin
			datain_cnt <= datain_cnt + 8'd1;
		end else begin
			datain_cnt <= datain_cnt;
		end
	end

	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			dataout0_real_temp <= 16'd0;
			dataout0_imaginary_temp <= 16'd0;
			dataout1_real_temp <= 16'd0;
			dataout1_imaginary_temp <= 16'd0;
			dataout2_real_temp <= 16'd0;
			dataout2_imaginary_temp <= 16'd0;
			dataout3_real_temp <= 16'd0;
			dataout3_imaginary_temp <= 16'd0;
			dataout4_real_temp <= 16'd0;
			dataout4_imaginary_temp <= 16'd0;
			dataout5_real_temp <= 16'd0;
			dataout5_imaginary_temp <= 16'd0;
			dataout6_real_temp <= 16'd0;
			dataout6_imaginary_temp <= 16'd0;
			dataout7_real_temp <= 16'd0;
			dataout7_imaginary_temp <= 16'd0;

			tx_flag <= 1'd0;
		end else if(datain_valid) begin
			case(datain_cnt)
				8'd0 : begin
					dataout0_real_temp <= datain_real;
					dataout0_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd1 : begin
					dataout4_real_temp <= datain_real;
					dataout4_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd2 : begin
					dataout2_real_temp <= datain_real;
					dataout2_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd3 : begin
					dataout6_real_temp <= datain_real;
					dataout6_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd4 : begin
					dataout1_real_temp <= datain_real;
					dataout1_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd5 : begin
					dataout5_real_temp <= datain_real;
					dataout5_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd6 : begin
					dataout3_real_temp <= datain_real;
					dataout3_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				8'd7 : begin
					dataout7_real_temp <= datain_real;
					dataout7_imaginary_temp <= datain_imaginary;
					tx_flag <= 1'd1;
				end

				default : begin
					dataout0_real_temp <= dataout0_real_temp;
					dataout0_imaginary_temp <= dataout0_imaginary_temp;
					dataout1_real_temp <= dataout1_real_temp;
					dataout1_imaginary_temp <= dataout1_imaginary_temp;
					dataout2_real_temp <= dataout2_real_temp;
					dataout2_imaginary_temp <= dataout2_imaginary_temp;
					dataout3_real_temp <= dataout3_real_temp;
					dataout3_imaginary_temp <= dataout3_imaginary_temp;
					dataout4_real_temp <= dataout4_real_temp;
					dataout4_imaginary_temp <= dataout4_imaginary_temp;
					dataout5_real_temp <= dataout5_real_temp;
					dataout5_imaginary_temp <= dataout5_imaginary_temp;
					dataout6_real_temp <= dataout6_real_temp;
					dataout6_imaginary_temp <= dataout6_imaginary_temp;
					dataout7_real_temp <= dataout7_real_temp;
					dataout7_imaginary_temp <= dataout7_imaginary_temp;
					tx_flag <= 1'd0;
				end 

			endcase
		end else begin
			dataout0_real_temp <= dataout0_real_temp;
			dataout0_imaginary_temp <= dataout0_imaginary_temp;
			dataout1_real_temp <= dataout1_real_temp;
			dataout1_imaginary_temp <= dataout1_imaginary_temp;
			dataout2_real_temp <= dataout2_real_temp;
			dataout2_imaginary_temp <= dataout2_imaginary_temp;
			dataout3_real_temp <= dataout3_real_temp;
			dataout3_imaginary_temp <= dataout3_imaginary_temp;
			dataout4_real_temp <= dataout4_real_temp;
			dataout4_imaginary_temp <= dataout4_imaginary_temp;
			dataout5_real_temp <= dataout5_real_temp;
			dataout5_imaginary_temp <= dataout5_imaginary_temp;
			dataout6_real_temp <= dataout6_real_temp;
			dataout6_imaginary_temp <= dataout6_imaginary_temp;
			dataout7_real_temp <= dataout7_real_temp;
			dataout7_imaginary_temp <= dataout7_imaginary_temp;
			tx_flag <= 1'd0;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			dataout_valid <= 1'd0;
		end else if(datain_cnt == 8'd7) begin
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
		end else if(dataout_valid) begin
			dataout0_real <= dataout0_real_temp;
			dataout0_imaginary <= dataout0_imaginary_temp;
			dataout1_real <= dataout1_real_temp;
			dataout1_imaginary <= dataout1_imaginary_temp;
			dataout2_real <= dataout2_real_temp;
			dataout2_imaginary <= dataout2_imaginary_temp;
			dataout3_real <= dataout3_real_temp;
			dataout3_imaginary <= dataout3_imaginary_temp;
			dataout4_real <= dataout4_real_temp;
			dataout4_imaginary <= dataout4_imaginary_temp;
			dataout5_real <= dataout5_real_temp;
			dataout5_imaginary <= dataout5_imaginary_temp;
			dataout6_real <= dataout6_real_temp;
			dataout6_imaginary <= dataout6_imaginary_temp;
			dataout7_real <= dataout7_real_temp;
			dataout7_imaginary <= dataout7_imaginary_temp;
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
		end
	end

endmodule