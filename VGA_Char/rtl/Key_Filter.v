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
// File   : Key_Filter.v
// Create : 2023-08-23 09:36:32
// Revise : 2023-08-23 09:36:32
// Editor : sublime text4, tab size (4)
// Descri : 由于更换clk频率为25MHz，以后按照50MHz计数的按键标志可能出现问题，
//			后续需要经过SignalTap进行验证是否需要更改代码。
// -----------------------------------------------------------------------------
module Key_Filter 
#(
	parameter cnt_20ms_max = 32'd999_999
)
(
	input clk,
	input rst_n,
	input key,
	output reg key_flag
);

	/*定义计数20ms的计数器*/
	reg [31:0] cnt_20ms;

	/*记录按键消抖稳定后的按键确认*/
	always @(posedge clk or negedge rst_n) begin

		if(~rst_n) begin
			cnt_20ms <= 32'd0;
		end else if(key) begin
			cnt_20ms <= 32'd0;
		end else if(cnt_20ms == cnt_20ms_max) begin
			cnt_20ms <= cnt_20ms;
		end else begin
			cnt_20ms <= cnt_20ms + 32'd1;
		end
		
	end

	/*当cnt_20ms记录到按键稳定后，则认为此按键有效*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_flag <= 1'd0;
		end else if(cnt_20ms == cnt_20ms_max - 32'd1) begin
			key_flag <= 1'd1;
		end else begin
			key_flag <= 1'd0;
		end
	end

endmodule