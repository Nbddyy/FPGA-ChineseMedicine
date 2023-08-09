module PLL_TEST_B_CODE (
	input board_clk_50mhz,
	input board_rst_n,
	output [3:0] miao_gewei,
	output [2:0] miao_shiwei,
	output [3:0] fen_gewei,
	output [2:0] fen_shiwei,
	output [3:0] shi_gewei,
	output [1:0] shi_shiwei,
	output [3:0] day_gewei,
	output [3:0] day_shiwei,
	output [1:0] day_baiwei,
	output [3:0] year_gewei,
	output [3:0] year_shiwei
);
	wire pll_c0;
	wire pll_locked;
	wire [7:0] moni_b_code_out;

	MY_PLL MY_PLL_1 (
		.areset(~board_rst_n),
		.inclk0(board_clk_50mhz),
		.c0(pll_c0),
		.locked(pll_locked));

	B_CODE_GEN 
	#(
		.cnt_10ms_max(32'd1_249),
	    .cnt_8ms_max(32'd999),
	    .cnt_5ms_max(32'd624),
	    .cnt_2ms_max(32'd249)
	)
	B_CODE_GEN_1
	(
		.pll_c0(pll_c0),
		.pll_locked(pll_locked),
		.moni_b_code_out(moni_b_code_out)
	);

	B_CODE_decode 
	#(
		.cnt_10ms_max(32'd1_249)
	)
	B_CODE_decode_1 (
		.pll_c0(pll_c0),
		.pll_locked(pll_locked),
		.moni_b_code_out(moni_b_code_out),
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