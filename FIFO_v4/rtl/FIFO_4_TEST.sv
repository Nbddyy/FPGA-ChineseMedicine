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
// File   : FIFO_4_TEST.v
// Create : 2023-08-10 16:54:25
// Revise : 2023-08-10 16:54:25
// Editor : sublime text4, tab size (4)
// Descri : 4FIFO-带帧头-用generate（Poll_Detect未用状态机）
// -----------------------------------------------------------------------------
module FIFO_4_TEST (
	input fifo_rdclk,

	input rst_n,
	input ch_wrclk [3:0],
	input ch_wrreq [3:0],
	input [31:0] ch_data [3:0],

	output data_valid,
	output [63:0] up_data
);


	reg [7:0] cnt_20;
	reg [7:0] cnt_15;
	reg [7:0] cnt_50;
	reg [7:0] cnt_100;

	//定义DCFIFO各变量
	//数据写入端
	wire [13:0] ch_wrusedw [3:0];

	//数据读出端
	reg ch_rdreq [3:0];
	wire [12:0] ch_rdusedw [3:0];
	wire [63:0] ch_q [3:0];

	

	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : generate_4_dcfifo
		DCFIFO_32IN_64OUT_16384 inst_DCFIFO_32IN_64OUT_16384 (
			.data(ch_data[i]),
			.rdclk(fifo_rdclk),
			.rdreq(ch_rdreq[i]),
			.wrclk(ch_wrclk[i]),
			.wrreq(ch_wrreq[i]),
			.q(ch_q[i]),
			.rdusedw(ch_rdusedw[i]),
			.wrusedw(ch_wrusedw[i]));
	end endgenerate

	Poll_Detect Poll_Detect_1 (
		.fifo_rdclk(fifo_rdclk),    //时钟与DCFIFO的rdclk保持一致
		.rst_n(rst_n),
		.ch_rdusedw(ch_rdusedw),
		.ch_q(ch_q),
		.ch_rdreq(ch_rdreq),
		.data_valid(data_valid),
		.up_data(up_data)
	);

endmodule