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
// File   : Irig_Parse.v
// Create : 2023-07-19 20:39:25
// Revise : 2023-07-19 20:39:25
// Editor : sublime text4, tab size (4)
// Descri : 对ex_bcode_signal进行解码
// -----------------------------------------------------------------------------
module Irig_Parse 
#(
	parameter bcode_0_flag = 32'd999_999,
	parameter bcode_1_flag = 32'd624_999,
	parameter bcode_2_flag = 32'd249_999,
	parameter num_10ms = 32'd1_249_999
)
(
	input clk,
	input rst_n,
	input ex_bcode_signal,
	output reg [3:0] second_units_output,
	output reg [2:0] second_tens_output,
	output reg [3:0] minute_units_output,
	output reg [2:0] minute_tens_output,
	output reg [3:0] hour_units_output,
	output reg [1:0] hour_tens_output,
	output reg [3:0] day_units_output,
	output reg [3:0] day_tens_output,
	output reg [1:0] day_hunds_output,
	output reg [3:0] year_units_output,
	output reg [3:0] year_tens_output
);

	reg [3:0] second_units;
	reg [2:0] second_tens;
	reg [3:0] minute_units;
	reg [2:0] minute_tens;
	reg [3:0] hour_units;
	reg [1:0] hour_tens;
	reg [3:0] day_units;
	reg [3:0] day_tens;
	reg [1:0] day_hunds;
	reg [3:0] year_units;
	reg [3:0] year_tens;


	// assign second_units_output = {data[4:1]};
	// assign second_tens_output = {data[8:6]};
	// assign minute_units_output  = {data[13:10]};
	// assign minute_tens_output  = {data[17:15]};
	// assign hour_units_output    = {data[23:20]};
	// assign hour_tens_output    = {data[26:25]};
	// assign day_units_output     = {data[33:30]};
	// assign day_tens_output     = {data[38:35]};
	// assign day_hunds_output     = {data[41:40]};
	// assign year_units_output    = {data[53:50]};
	// assign year_tens_output    = {data[58:55]};

	/*当检测到ex_bcode_signal高电平时即10ms一码元变化来临,
	使用中间变量reg [31:0] temp [99:0]来寄存码元的对应编码结果*/


	// /*前置计数*/
	// reg [31:0] cnt_10ms_pre;
	// always @(posedge clk or negedge rst_n) begin
	// 	if(~rst_n) begin
	// 		cnt_10ms_pre <= 32'd0;
	// 	end else if(ex_bcode_signal) begin
	// 		cnt_10ms_pre <= cnt_10ms_pre + 32'd1;
	// 	end else if() begin
	// 		cnt_10ms_pre <= cnt_10ms_pre;
	// 	end
	// end

	/*检测高电平计数用于判断码元类型*/
	reg [31:0] cnt_10ms;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_10ms <= 32'd0;
		end else if(!ex_bcode_signal) begin
			cnt_10ms <= cnt_10ms + 32'd1;
		end else begin
			cnt_10ms <= 32'd0;
		end
	end

	/*使用组合逻辑对输入码元进行编码*/
	reg [31:0] ex_sig_B_code;
	always @(posedge ex_bcode_signal,negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_B_code <= 32'd95;
		end else if(ex_bcode_signal) begin
			case(cnt_10ms - 32'd1)
				bcode_0_flag : ex_sig_B_code <= 32'd48;
				bcode_1_flag : ex_sig_B_code <= 32'd49;
				bcode_2_flag : ex_sig_B_code <= "P";
				default : ex_sig_B_code <= 32'd95;
			endcase
		end else begin
			ex_sig_B_code <= 32'd95;
		end
	end

	/*记录当前解析码元的位置*/
	reg [6:0] num;
	always @(posedge ex_bcode_signal or negedge rst_n) begin : proc_num
		if(~rst_n) begin
			num <= 7'd99;
		end else if(num == 7'd99) begin
			num <= 7'd0;
		end else if(ex_sig_B_code != 32'd95) begin
			num <= num + 7'd1;
		end
	end

	/*将num与码元进行绑定*/
	reg [31:0] num_bcode [99:0];
	always @(*) begin 
		if(!rst_n) begin
			num_bcode[num] = 32'd95;
		end else begin
			num_bcode[num] = ex_sig_B_code;
		end
		
	end


	/*秒的个位解析*/
	always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				second_units <= 4'd0;
				second_units_output <= 4'd0;
			end else if(num == 7'd5) begin
				/*8421BCD码，低位在前，其计算结果为对应位乘以1248*/
				second_units <= num_bcode[2] * 1 + num_bcode[3] * 2 + num_bcode[4] * 4 + num_bcode[5] * 8;
			end else if(num == 7'd75) begin
				second_units_output <= second_units;
			end else begin
				second_units <= second_units;
			end
	end	

	/*秒十位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			second_tens <= 3'd0;
			second_tens_output <= 3'd0;
		end else if(num == 7'd9) begin
			second_tens <= num_bcode[7] * 1 + num_bcode[8] * 2 + num_bcode[9] * 4;
		end else if(num == 7'd75) begin
			second_tens_output <= second_tens;
		end else begin
			second_tens <= second_tens;
		end
	end

	/*分个位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minute_units <= 4'd0;
			minute_units_output <= 4'd0;
		end else if(num == 7'd14)begin
			minute_units <= num_bcode[11] * 1 + num_bcode[12] * 2 + num_bcode[13] * 4 + num_bcode[14] * 8;
		end else if(num == 7'd75) begin
			minute_units_output <= minute_units;
		end	else begin
			minute_units <= minute_units;
		end
	end

	/*分十位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minute_tens <= 3'd0;
			minute_tens_output <= 3'd0;
		end else if(num == 7'd18) begin
			minute_tens <= num_bcode[16] * 1 + num_bcode[17] * 2 + num_bcode[18] * 4;
		end else if(num == 7'd75) begin
			minute_tens_output <= minute_tens;
		end else begin
			minute_tens <= minute_tens;
		end
	end

	/*时个位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hour_units <= 4'd0;
			hour_units_output <= 4'd0;
		end else if(num == 7'd24)begin
			hour_units <= num_bcode[21] * 1 + num_bcode[22] * 2 + num_bcode[23] * 4 + num_bcode[24] * 8;
		end else if(num == 7'd75) begin
			hour_units_output <= hour_units;
		end else begin
			hour_units <= hour_units;
		end
	end

	/*时十位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hour_tens <= 2'd0;
			hour_tens_output <= 2'd0;
		end else if(num == 7'd27) begin
			hour_tens <= num_bcode[26] * 1 + num_bcode[27];
		end else if(num == 7'd75) begin
			hour_tens_output <= hour_tens;
		end else begin
			hour_tens <= hour_tens;
		end
	end

	/*天个位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			day_units <= 4'd0;
			day_units_output <= 4'd0;
		end else if(num == 7'd34)begin
			day_units <= num_bcode[31] * 1 + num_bcode[32] * 2 + num_bcode[33] * 4 + num_bcode[34] * 8;
		end else if(num == 7'd75) begin
			day_units_output <= day_units;
		end else begin
			day_units <= day_units;
		end
	end

	/*天十位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			day_tens <= 4'd0;
			day_tens_output <= 4'd0;
		end else if(num == 7'd39) begin
			day_tens <= num_bcode[36] * 1 + num_bcode[37] * 2 + num_bcode[38] * 4 + num_bcode[39] * 8;
		end else if(num == 7'd75) begin
			day_tens_output <= day_tens;
		end else begin
			day_tens <= day_tens;
		end
	end

	/*天百位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			day_hunds <= 4'd0;
			day_hunds_output <= 4'd0;
		end else if(num == 7'd42) begin
			day_hunds <= num_bcode[41] * 1 + num_bcode[42] * 2;
		end else if(num == 7'd75) begin
			day_hunds_output <= day_hunds;
		end else begin
			day_hunds <= day_hunds;
		end
	end

	/*年个位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			year_units <= 4'd0;
			year_units_output <= 4'd0;
		end else if(num == 7'd54) begin
			year_units <= num_bcode[51] * 1 + num_bcode[52] * 2 + num_bcode[53] * 4 + num_bcode[54] * 8;
		end else if(num == 7'd75) begin
			year_units_output <= year_units;
		end else begin
			year_units <= year_units;
		end
	end

	/*年十位解析*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			year_tens <= 4'd0;
			year_tens_output <= 4'd0;
		end else if(num == 7'd59) begin
			year_tens <= num_bcode[56] * 1 + num_bcode[57] * 2 + num_bcode[58] * 4 + num_bcode[59] * 8;
		end else if(num == 7'd75) begin
			year_tens_output <= year_tens;
		end else begin
			year_tens <= year_tens;
		end
	end

endmodule