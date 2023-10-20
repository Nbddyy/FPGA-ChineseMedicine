
`timescale 1ns/1ps
module tb_Test_IBUFDS_OBUFDS (); /* this is automatically generated */

	

	// (*NOTE*) replace reset, clock, others
	reg  board_clk_100Mhz_P;
	wire clk_100Mhz_N;
	reg  board_rst_n;
	wire  clk_125Mhz_P;
	wire  clk_125Mhz_N;


	initial begin
		board_clk_100Mhz_P <= 1'd0;
		board_rst_n <= 1'd0;
		#13
		board_rst_n = 1'd1;
	end

	always #5 board_clk_100Mhz_P <= !board_clk_100Mhz_P;
	assign clk_100Mhz_N = !board_clk_100Mhz_P;


	Test_IBUFDS_OBUFDS inst_Test_IBUFDS_OBUFDS
		(
			.board_clk_100Mhz_P (board_clk_100Mhz_P),
			.clk_100Mhz_N		(clk_100Mhz_N),
			.board_rst_n        (board_rst_n),
			.clk_125Mhz_P       (clk_125Mhz_P),
			.clk_125Mhz_N       (clk_125Mhz_N)
		);

endmodule
