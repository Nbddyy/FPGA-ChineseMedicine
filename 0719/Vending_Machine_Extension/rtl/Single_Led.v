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
// File   : Single_Led.v
// Create : 2023-07-21 19:58:22
// Revise : 2023-07-21 19:58:22
// Editor : sublime text4, tab size (4)
// Descri : 此模块用于实现售货机出货时LED灯单向右流水0.5s的操作
// -----------------------------------------------------------------------------
module Single_Led 
#(
	parameter cnt_500ms_max = 32'd24_999_999
)
(
	input clk,
	input rst_n,
	input single_in,
	output reg [3:0] single_led
);

	/*使用独热码表示单向流水下的几种状态*/
	reg [4:0] single_led_state;
	parameter IDLE = 5'b00_001;
	parameter D6 = 5'b00_010;
	parameter D7 = 5'b00_100;
	parameter D8 = 5'b01_000;
	parameter D9 = 5'b10_000;

	/*定义一个计时0.5s的变量*/
	reg [31:0] cnt_500ms;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 32'd0;
		end else if(cnt_500ms == cnt_500ms_max && single_in) begin
			cnt_500ms <= 32'd0;
		end else if(single_in) begin
			cnt_500ms <= cnt_500ms + 32'd1;
		end else begin
			cnt_500ms <= 32'd0;
		end
	end

	/*描述触发单向流水时几种状态之间的转移*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			single_led_state <= IDLE;
		end else begin
			case(single_led_state)
				IDLE : begin
					if(single_in) begin
						single_led_state <= D6;
					end else begin
						single_led_state <= IDLE;
					end
				end

				D6 : begin
					if(cnt_500ms == cnt_500ms_max) begin
						single_led_state <= D7;
					end else if(single_in) begin
						single_led_state <= D6;
					end else begin
						single_led_state <= IDLE;
					end
				end

				D7 : begin
					if(cnt_500ms == cnt_500ms_max && single_in) begin
						single_led_state <= D8;
					end else if(single_in) begin
						single_led_state <= D7;
					end else begin
						single_led_state <= IDLE;
					end
				end

				D8 : begin
					if(cnt_500ms == cnt_500ms_max && single_in) begin
						single_led_state <= D9;
					end else if(single_in) begin
						single_led_state <= D8;
					end else begin
						single_led_state <= IDLE;
					end
				end

				D9 : begin
					if(cnt_500ms == cnt_500ms_max && single_in) begin
						single_led_state <= D6;
					end else if(single_in) begin
						single_led_state <= D9;
					end else begin
						single_led_state <= IDLE;
					end
				end

				default : single_led_state <= IDLE;
			endcase
		end 
	end

	/*描述几种状态转移下single_led的输出结果*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			single_led <= 4'b1111;
		end else begin
			case(single_led_state)
				IDLE : single_led <= 4'b1111;
				D6 : single_led <= 4'b1110;
				D7 : single_led <= 4'b1101;
				D8 : single_led <= 4'b1011;
				D9 : single_led <= 4'b0111;
				default : single_led <= 4'b1111;
			endcase
		end
	end

endmodule