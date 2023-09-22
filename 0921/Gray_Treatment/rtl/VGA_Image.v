// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : bddyy N (China) qq1877117587@outlook.com
// File   : VGA_Image.v
// Create : 2023-09-21 19:36:33
// Revise : 2023-09-21 19:36:33
// Editor : sublime text4, tab size (4)
// Descri : 本次使用最大化存储量单端口ROM，图片像素点(340,191)，存储数据为左上角为
//			原点，即深度计数由左到右，由上到下
// -----------------------------------------------------------------------------
module VGA_Image 
#(
	parameter horizontal = 10'd150,	//水平像素点
	parameter vertical = 10'd85		//垂直像素点
)
(
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output [15:0] pix_data
);

	reg rden;
	reg [15:0] address;
	wire [15:0] q;

	reg rden_clap;

	/*rden用于从ROM中读取数据*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rden <= 1'd0;
		end else begin
			
			if(vertical % 2) begin 	//偶数
				if( (pix_y >= 10'd240 - (vertical >> 1)) && (pix_y <= 10'd239 + (vertical >> 1)) ) begin
					if(horizontal % 2) begin
						rden <= ( (pix_x >= 10'd320 - (horizontal >> 1)) && (pix_x <= 10'd319 + (horizontal >> 1)) ) ? 1'd1 : 1'd0;
					end else begin
						rden <= ( (pix_x >= 10'd320 - (horizontal >> 1)) && (pix_x <= 10'd320 + (horizontal >> 1)) ) ? 1'd1 : 1'd0;
					end
				end else begin
					rden <= 1'd0;
				end
			end else begin 			//奇数
				if( (pix_y >= 10'd240 - (vertical >> 1)) && (pix_y <= 10'd240 + (vertical >> 1)) ) begin
					if(horizontal % 2) begin
						rden <= ( (pix_x >= 10'd320 - (horizontal >> 1)) && (pix_x <= 10'd319 + (horizontal >> 1)) ) ? 1'd1 : 1'd0;
					end else begin
						rden <= ( (pix_x >= 10'd320 - (horizontal >> 1)) && (pix_x <= 10'd320 + (horizontal >> 1)) ) ? 1'd1 : 1'd0;
					end
				end else begin
					rden <= 1'd0;
				end
			end
		end 

	end

	/*对rden进行打一拍*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rden_clap <= 1'd0;
		end else begin
			rden_clap <= rden;
		end
	end

	/*取数地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 16'd0;
		end else if(pix_y >= 10'd190 && pix_y <= 10'd289) begin
			address <= (rden) ? address + 16'd1 : address;
		end else begin
			address <= 16'd0;
		end
	end

	/*output pix_data*/
	assign pix_data = (rden_clap) ? q : 16'd0;

	ROM_Single_16_16384 inst_ROM_Single_16_16384 (
		.address(address), 
		.clock(clk), 
		.rden(rden), 
		.q(q));


endmodule