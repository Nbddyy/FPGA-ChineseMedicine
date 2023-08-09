`timescale 1ns/1ns
module tb_PLL_TEST_B_CODE ();

	reg board_clk_50mhz;
	reg board_rst_n;
	wire [3:0] miao_gewei;
	wire [2:0] miao_shiwei;
	wire [3:0] fen_gewei;
	wire [2:0] fen_shiwei;
	wire [3:0] shi_gewei;
	wire [1:0] shi_shiwei;
	wire [3:0] day_gewei;
	wire [3:0] day_shiwei;
	wire [1:0] day_baiwei;
	wire [3:0] year_gewei;
	wire [3:0] year_shiwei;

	initial begin
		board_clk_50mhz = 1'd0;
		board_rst_n = 1'd0;
		#14
		board_rst_n = 1'd1;
	end

	always #10 board_clk_50mhz <= ~board_clk_50mhz;

	PLL_TEST_B_CODE PLL_TEST_B_CODE_1 (
		.board_clk_50mhz(board_clk_50mhz),
		.board_rst_n(board_rst_n),
		.miao_gewei(miao_gewei),
		.miao_shiwei(miao_shiwei),
		.fen_gewei(fen_gewei),
		.fen_shiwei(fen_shiwei),
		.shi_gewei(shi_gewei),
		.shi_shiwei(shi_shiwei),
		.day_gewei(day_gewei),
		.day_shiwei(day_shiwei),
		.day_baiwei(day_baiwei),
		.year_gewei(year_gewei),
		.year_shiwei(year_shiwei)
);

endmodule