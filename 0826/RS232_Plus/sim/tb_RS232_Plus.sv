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
// File   : tb_RS232_Plus.sv
// Create : 2023-08-25 22:36:23
// Revise : 2023-08-25 22:36:23
// Editor : sublime text4, tab size (4)
// Descri : 此次验证波特率为9600Bps，一个码元对应一个二进制数
// -----------------------------------------------------------------------------

`timescale 1ns/1ps
module tb_RS232_Plus (); /* this is automatically generated */

	reg rst_n;
	reg clk;

	reg rx;
	wire tx;

	initial begin
		rst_n = 1'd0;
		clk = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	/*用于模拟生成包含1位起始位，8位有效位，一位停止位的数据帧*/
	task generate_rx();	//时序逻辑
		integer i;

		for(i = 0; i < 10; i = i + 1) begin
			case(i) 
				0 : rx <= 0;	//起始位固定为0
				9 : rx <= 1;	//停止位固定为1
				default : rx <= {$random} % 2;
			endcase	

			#104166;	//每一个码元传输所占的ns
		end	

	endtask

	initial begin
		rx = 1'd0;
		#200
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();
	end

	

	RS232_Plus inst_RS232_Plus (.clk(clk), .rst_n(rst_n), .rx(rx), .tx(tx));

endmodule
