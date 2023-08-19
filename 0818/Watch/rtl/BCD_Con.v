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
// File   : BCD_Con.v
// Create : 2023-08-18 22:21:50
// Revise : 2023-08-18 22:21:50
// Editor : sublime text4, tab size (4)
// Descri : 给时分秒分别加上对应的锁存器用于记录上一个clk的值，只有寄存的数据
//			发生变化时，才进行十进制转二进制，和二进制转BCD编码
// -----------------------------------------------------------------------------
module BCD_Con (
	input clk,
	input rst_n,
	input [7:0] hours,
	input [7:0] minutes,
	input [7:0] seconds,
	input [5:0] sel_in,
	output reg [7:0] hour,
	output reg [7:0] minute,
	output reg [7:0] second,
	output reg [5:0] sel_out
);

	//定义各自寄存器用来记录上一个clk该值
	reg [7:0] hours_latch;
	reg [7:0] minutes_latch;
	reg [7:0] seconds_latch;


	/*v1:通过时序逻辑中的组合逻辑实现十进制转BCD编码的操作*/
	/*hour的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hour <= 8'b0001_0101;
			hours_latch <= 8'd15;
		end else if(hours_latch != hours) begin
			hours_latch = hours;
			//hours最大为23，占位为5
			hour = {5'b0000_0,hours[4],hours[3],hours[2]};
			if(hour[3:0] > 4'd4) begin
				hour = hour + 8'b0000_0011;
			end else begin
				hour = hour;
			end

			hour = {hour[6:0],hours[1]};
			if(hour[3:0] > 4'd4) begin
				hour = hour + 8'b0000_0011;
			end else begin
				hour = hour;
			end

			hour = {hour[6:0],hours[0]};

			// hours_latch = hours;
			// //hours最大为59，占位为6
			// hour = {5'b0000_0,hours[5],hours[4],hours[3]};
			// if(hour[3:0] > 4'd4) begin
			// 	hour = hour + 8'b0000_0011;
			// end else begin
			// 	hour = hour;
			// end

			// hour = {hour[6:0],hours[2]};
			// if(hour[3:0] > 4'd4) begin
			// 	hour = hour + 8'b0000_0011;
			// end else begin
			// 	hour = hour;
			// end

			// hour = {hour[6:0],hours[1]};
			// if(hour[3:0] > 4'd4) begin
			// 	hour = hour + 8'b0000_0011;
			// end else begin
			// 	hour = hour;
			// end

			// hour = {hour[6:0],hours[0]};

		end else begin
			hour <= hour;
			hours_latch <= hours_latch;
		end
	end

	/*minute的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minute <= 8'b0101_0111;
			minutes_latch <= 8'd57;
		end else if(minutes_latch != minutes) begin
			minutes_latch = minutes;
			//minutes最大为59，占位为6
			minute = {5'b0000_0,minutes[5],minutes[4],minutes[3]};
			if(minute[3:0] > 4'd4) begin
				minute = minute + 8'b0000_0011;
			end else begin
				minute = minute;
			end

			minute = {minute[6:0],minutes[2]};
			if(minute[3:0] > 4'd4) begin
				minute = minute + 8'b0000_0011;
			end else begin
				minute = minute;
			end

			minute = {minute[6:0],minutes[1]};
			if(minute[3:0] > 4'd4) begin
				minute = minute + 8'b0000_0011;
			end else begin
				minute = minute;
			end

			minute = {minute[6:0],minutes[0]};
		end else begin
			minute <= minute;
			minutes_latch <= minutes_latch;
		end
	end

	/*second的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			second <= 8'b0011_0100;
			seconds_latch <= 8'd34;
		end else if(seconds_latch != seconds) begin
			seconds_latch = seconds;
			//seconds最大为59，占位为6
			second = {5'b0000_0,seconds[5],seconds[4],seconds[3]};
			if(second[3:0] > 4'd4) begin
				second = second + 8'b0000_0011;
			end else begin
				second = second;
			end

			second = {second[6:0],seconds[2]};
			if(second[3:0] > 4'd4) begin
				second = second + 8'b0000_0011;
			end else begin
				second = second;
			end

			second = {second[6:0],seconds[1]};
			if(second[3:0] > 4'd4) begin
				second = second + 8'b0000_0011;
			end else begin
				second = second;
			end

			second = {second[6:0],seconds[0]};
		end else begin
			second <= second;
			seconds_latch <= seconds_latch;
		end
	end

	/*sel_out的代码体现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel_out <= 6'd0;
		end else begin
			sel_out <= sel_in;
		end
	end

endmodule
