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
// File   : VGA_Image.v
// Create : 2023-08-23 19:35:52
// Revise : 2023-08-23 19:35:52
// Editor : sublime text4, tab size (4)
// Descri : 01二进制中没有小数概念
// -----------------------------------------------------------------------------
module VGA_Image (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	/*本次纯色使用护眼绿RGB(204,232,207)，24'b11001100_11101000_11001111*/
	parameter EyeGreen = 16'b11001_111010_11001;

	/*output pix_data
	椭圆的圆心坐标为(320,240)，椭圆在x和y方向上的半长轴和半短轴分别为200、100*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_x != 10'h3ff && pix_y != 10'h3ff) begin
				//pix_data <= ( ( ((pix_x-10'd320) * (pix_x-10'd320)) / 40000 + ((pix_y-10'd240) * (pix_y-10'd240)) / 10000) <= 1) ? EyeGreen : 16'd0;
				pix_data <= ( ( ((pix_x-10'd320) * (pix_x-10'd320)) + ((pix_y-10'd240) * (pix_y-10'd240)) * 4) <= 40000) ? EyeGreen : 16'd0;
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule