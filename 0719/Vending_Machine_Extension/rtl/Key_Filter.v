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
// File   : Key_Filter.v
// Create : 2023-07-21 08:44:04
// Revise : 2023-07-21 08:44:04
// Editor : sublime text4, tab size (4)
// Descri : 按键消抖模块用于模拟投币0.5元和1元以及退钱的操作操作
// -----------------------------------------------------------------------------
module Key_Filter 
#(
	parameter cnt_20ms = 32'd999_999,
	parameter cnt_10s_max = 32'd499_999_999
)
(
	input clk,
	input rst_n,
	/*[1]模拟1元,[0]模拟0.5元*/
	input [2:0] keys,
	/*[3]投币1元操作
	[2]投币0.5元操作
	[1]是否复位退钱操作
	[0]判断距离上一次操作是否超过10s的标志位*/
	output reg [3:0] kf_out
);

	reg [31:0] half_cnt_20ms;
	reg [31:0] one_cnt_20ms;
	reg [31:0] reset_cnt_20ms;

	reg key_half_flag;	//0.5元投币标志
	reg key_one_flag;	//1元投币标志
	reg key_reset_flag;	//终止投币按键回归原位(不同于复位)
	reg [31:0] cnt_10s;	//标识距离上次投币是否超过10s

	/*用于模拟0.5元按键消抖稳定后输出置1*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			half_cnt_20ms <= 32'd0;
		end else if(keys[0]) begin
			half_cnt_20ms <= 32'd0;
		end else if(half_cnt_20ms != cnt_20ms) begin
			half_cnt_20ms <= half_cnt_20ms + 32'd1;
		end else begin
			half_cnt_20ms <= half_cnt_20ms;
		end
	end

	/*用于模拟1元按键消抖稳定后输出置1*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			one_cnt_20ms <= 32'd0;
		end else if(keys[1]) begin
			one_cnt_20ms <= 32'd0;
		end else if(one_cnt_20ms != cnt_20ms) begin
			one_cnt_20ms <= one_cnt_20ms + 32'd1;
		end else begin
			one_cnt_20ms <= one_cnt_20ms;
		end
	end

	/*用于模拟退钱按键消抖稳定后输出置1*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reset_cnt_20ms <= 32'd0;
		end else if(keys[2]) begin
			reset_cnt_20ms <= 32'd0;
		end else if(reset_cnt_20ms != cnt_20ms) begin
			reset_cnt_20ms <= reset_cnt_20ms + 32'd1;
		end else begin
			reset_cnt_20ms <= reset_cnt_20ms;
		end
	end

	/*定义对应的标志位来标记按键消抖后确定按键成功时刻拉高的电平*/
	
	/*0.5元按键成功标志*/
	
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_half_flag <= 1'd0;
		end else if(half_cnt_20ms == cnt_20ms - 32'd1) begin
			key_half_flag <= 1'd1;
		end else begin
			key_half_flag <= 1'd0;
		end
	end

	/*1元按键成功标志*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_one_flag <= 1'd0;
		end else if(one_cnt_20ms == cnt_20ms - 32'd1) begin
			key_one_flag <= 1'd1;
		end else begin
			key_one_flag <= 1'd0;
		end
	end

	/*退钱按键成功标志*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_reset_flag <= 1'd0;
		end else if(reset_cnt_20ms == cnt_20ms - 32'd1) begin
			key_reset_flag <= 1'd1;
		end else begin
			key_reset_flag <= 1'd0;
		end
	end

	/*当按键成功后开始计数10s，如此期间没有继续投币操作，则输出的第四位置1*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_10s <= cnt_10s_max + 32'd1;
		end else if(key_half_flag || key_one_flag || key_reset_flag) begin
			cnt_10s <= 32'd0;
		end else if(cnt_10s < cnt_10s_max + 32'd1) begin
			cnt_10s <= cnt_10s + 32'd1;
		end else begin
			cnt_10s <= cnt_10s;
		end
	end

	/*对结果进行判断
	0000：终止本次投币退钱
	0110：投币0.5元
	1010：投币1元
	0010：不做投币操作
	0011：不做投币操作其距离上回投币超过10s
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			kf_out <= 4'b0000;
		end else if(key_half_flag) begin
			kf_out <= 4'b0110;
		end else if(key_one_flag) begin
			kf_out <= 4'b1010;
		end else if(key_reset_flag) begin
			kf_out <= 4'b0000;
		end else if(cnt_10s == cnt_10s_max + 32'd1) begin
			kf_out <= 4'b0011;
		end else begin
			kf_out <= 4'b0010;
		end
	end

endmodule