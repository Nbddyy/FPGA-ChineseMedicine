
`timescale 1ns/1ps
module tb_Test_FIR (); /* this is automatically generated */

	reg board_clk_50mhz;
	reg board_rst_n;

	initial begin
		board_clk_50mhz <= 1'd0;
		board_rst_n <= 1'd0;
		#233
		board_rst_n = 1'd1;
	end

	always #10 board_clk_50mhz <= !board_clk_50mhz;

	// (*NOTE*) replace reset, clock, others
	Test_FIR inst_Test_FIR (.board_clk_50mhz(board_clk_50mhz), .board_rst_n(board_rst_n));

	
endmodule
