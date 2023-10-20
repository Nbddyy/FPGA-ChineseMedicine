
`timescale 1ns/1ps
module tb_Test_DDS (); /* this is automatically generated */

	// synchronous reset
	reg board_rst_n;
	reg  board_clk_100mhz;
	initial begin
		board_rst_n <= 1'd0;
		board_clk_100mhz <= 1'd0;
		#13
		board_rst_n <= 1'd1;
	end

	always #5 board_clk_100mhz <= !board_clk_100mhz;
	

	Test_DDS inst_Test_DDS (.board_clk_100mhz(board_clk_100mhz), .board_rst_n(board_rst_n));

	
endmodule
