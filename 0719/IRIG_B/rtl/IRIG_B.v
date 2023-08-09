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
// Create : 2023-07-20 09:57:42
// Revise : 2023-07-20 09:57:42
// Editor : sublime text4, tab size (4)
// Attent : 编码过程延迟10ms，时间过长是否有可以优化的地方
// -----------------------------------------------------------------------------
module IRIG_B (
	input clk,
	input rst_n,
	input wire [31:0] ex_sig_B_code,
	output wire [3:0] second_units_output,
	output wire [2:0] second_tens_output,
	output wire [3:0] minute_units_output,
	output wire [2:0] minute_tens_output,
	output wire [3:0] hour_units_output,
	output wire [1:0] hour_tens_output,
	output wire [3:0] day_units_output,
	output wire [3:0] day_tens_output,
	output wire [1:0] day_hunds_output,
	output wire [3:0] year_units_output,
	output wire [3:0] year_tens_output
);

	Draw_Symbol Draw_Symbol_1(
		.clk(clk),
		.rst_n(rst_n),
		.ex_sig_B_code(ex_sig_B_code),
		.ex_bcode_signal(ex_bcode_signal)
	);

	Irig_Parse Irig_Parse_1 
	(
		.clk(clk),
		.rst_n(rst_n),
		.ex_bcode_signal(ex_bcode_signal),
		.second_units_output(second_units_output),
		.second_tens_output(second_tens_output),
		.minute_units_output(minute_units_output),
		.minute_tens_output(minute_tens_output),
		.hour_units_output(hour_units_output),
		.hour_tens_output(hour_tens_output),
		.day_units_output(day_units_output),
		.day_tens_output(day_tens_output),
		.day_hunds_output(day_hunds_output),
		.year_units_output(year_units_output),
		.year_tens_output(year_tens_output)
	);

endmodule