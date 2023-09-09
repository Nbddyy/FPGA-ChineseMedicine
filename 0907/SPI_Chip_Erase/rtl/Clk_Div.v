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
// File   : Clk_Div.v
// Create : 2023-09-06 15:12:37
// Revise : 2023-09-06 15:12:37
// Editor : sublime text4, tab size (4)
// Descri : 主机和从机之间传输的频率以低频率设备为传输频率（传输速度受限于低频率）
//			此次受限频率最大为10MH在，我们以6.25MHz为传输频率。
// -----------------------------------------------------------------------------
module Clk_Div (
	input clk,
	input rst_n, 
	output reg clk_div
);

	reg [3:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 4'd0;
		end else if(cnt == 4'd4) begin
			cnt <= 4'd0;
		end else begin
			cnt <= cnt + 4'd1;
		end
	end

	/*组合逻辑信号变量不能存储变量本身*/
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			clk_div <= 1'd0;
		end else begin
			clk_div <= (cnt == 4'd4) ? !clk_div : clk_div;
		end
	end

endmodule