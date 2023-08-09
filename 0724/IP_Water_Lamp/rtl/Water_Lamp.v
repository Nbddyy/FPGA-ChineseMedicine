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
// File   : Water_Lamp.v
// Create : 2023-07-24 16:50:45
// Revise : 2023-07-24 16:50:45
// Editor : sublime text4, tab size (4)
// Descri : 本次使用输入频率为125mhz实现流水灯的状态转移
// -----------------------------------------------------------------------------
module Water_Lamp 
#(
	parameter cnt_500ms_max = 32'd62_499_999
)
(
	input clk_125mhz,
	input rst,
	output reg [3:0] led_out	
);

	/*
	125mhz周期为8ns，500ms流水灯计数至cnt_500ms_max
	*/

	/*定义流水灯的五种状态*/
	parameter IDLE = 5'b00_001;
	parameter D6 =  5'b00_010;
	parameter D7 = 5'b00_100;
	parameter D8 = 5'b01_000;
	parameter D9 = 5'b10_000;

	/*定义一个计数器实现500ms的计数*/
	reg [31:0] cnt_500ms;
	always @(posedge clk_125mhz or negedge rst) begin
		if(~rst) begin
			cnt_500ms <= 32'd0;
		end else if(cnt_500ms == cnt_500ms_max) begin
			cnt_500ms <= 32'd0;
		end else begin
			cnt_500ms <= cnt_500ms + 32'd1;
		end
	end

	/*状态转移的代码实现*/
	reg [4:0] state;
	always @(posedge clk_125mhz or negedge rst) begin
		if(~rst) begin
			state <= IDLE;
		end else begin

			case(state) 
				IDLE : begin
					state <= D6;
				end

				D6 : state <= (cnt_500ms == cnt_500ms_max) ? D7 : D6;
				D7 : state <= (cnt_500ms == cnt_500ms_max) ? D8 : D7;
				D8 : state <= (cnt_500ms == cnt_500ms_max) ? D9 : D8;
				D9 : state <= (cnt_500ms == cnt_500ms_max) ? D6 : D9;
			endcase

		end
	end

	/*不同状态下的输出情况*/
	always @(posedge clk_125mhz or negedge rst) begin
		if(~rst) begin
			led_out <= 4'b1111;
		end else begin
			case(state)
				D6 : led_out <= 4'b1110;
				D7 : led_out <= 4'b1101;
				D8 : led_out <= 4'b1011;
				D9 : led_out <= 4'b0111;
				default : led_out <= 4'b1111;
			endcase
		end
	end

endmodule