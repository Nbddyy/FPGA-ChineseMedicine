// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : yongchan jeon (Kris) poucotm@gmail.com
// File   : IRIG_B.v
// Create : 2023-07-19 19:48:16
// Revise : 2023-07-19 19:48:16
// Editor : sublime text4, tab size (4)
// Descri : 对Bcode输入进行对应的码元绘制
// -----------------------------------------------------------------------------
module Draw_Symbol 
#(
	parameter bcode_0_flag = 32'd249_999,
	parameter bcode_1_flag = 32'd624_999,
	parameter bcode_2_flag = 32'd999_999,
	parameter num_10ms = 32'd1_249_999
)
(
	input clk,
	input rst_n,
	input wire [31:0] ex_sig_B_code,
	output reg ex_bcode_signal
);


	reg ex_bcode_3_signals [2:0];
	reg [31:0] ex_bcode_3_signals_cnt;
	wire [31:0] ex_bcode_3_signals_flag [2:0];
	assign ex_bcode_3_signals_flag[0] = bcode_0_flag;
	assign ex_bcode_3_signals_flag[1] = bcode_1_flag;
	assign ex_bcode_3_signals_flag[2] = bcode_2_flag;

	/*10ms计数*/
	always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				ex_bcode_3_signals_cnt <= 32'd0;
			end else if(ex_bcode_3_signals_cnt == num_10ms) begin
				ex_bcode_3_signals_cnt <= 32'd0;
			end else begin
				ex_bcode_3_signals_cnt <= ex_bcode_3_signals_cnt + 32'd1;
			end
		end


	/*先绘制0、1、P码元*/
	genvar i;
	generate for(i = 0; i < 3; i = i + 1) begin : for_ex_bcode	

		/*电平转换,绘制对应码元图*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				ex_bcode_3_signals[i] <= 1'd1;
			end else if(ex_bcode_3_signals_cnt >= ex_bcode_3_signals_flag[i] && ex_bcode_3_signals_cnt < num_10ms) begin
				ex_bcode_3_signals[i] <= 1'd0;
			end else begin
				ex_bcode_3_signals[i] <= 1'd1;
			end
		end

	end endgenerate
	
	/*将bcode绘制转变为B码脉冲序列*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_bcode_signal <= 1'd0;
		end else begin
			case(ex_sig_B_code)
				48 	: ex_bcode_signal <= ex_bcode_3_signals[0];
				49 	: ex_bcode_signal <= ex_bcode_3_signals[1];
				"P" : ex_bcode_signal <= ex_bcode_3_signals[2];
				default : ex_bcode_signal <= 1'd0;
			endcase
		end
	end

endmodule