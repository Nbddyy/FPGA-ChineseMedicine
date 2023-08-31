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
// File   : UART_SEND_BCODE_TIME.v
// Create : 2023-08-28 11:50:34
// Revise : 2023-08-28 11:50:34
// Editor : sublime text4, tab size (4)
// Descri : UART_Tx模块我们使用8位传输，在顶层模块实现1s控制
// -----------------------------------------------------------------------------
module UART_SEND_BCODE_TIME (
	input clk,
	input rst_n,
	output tx
);


	wire [7:0] ip_data;
	wire ip_flag;


	wire c0;
	wire locked;




	PLL_125MHz inst_PLL_125MHz (
		.areset(!rst_n),
		.inclk0(clk),
		.c0(c0),
		.locked(locked));

	IRIG_B_Pro inst_IRIG_B_Pro (
		.clk(c0),
		.rst_n(rst_n && locked),
		.ip_data(ip_data),
		.ip_flag(ip_flag)
	);

	UART_Tx
	#(
		.baud_cnt_max(16'd13_020)
	) 
	inst_UART_Tx (
		.clk(c0),
		.rst_n(rst_n && locked),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx(tx) 
	);


endmodule