module VGA_Monitor (
	input clk,
	input rst_n,
	input key_in,
	output hsync,
	output vsync,
	output [15:0] rgb
);

	wire c0;
	wire locked;
	wire key_flag;

	PLL_25MHz inst_PLL_25MHz (
		.areset(!rst_n),
		.inclk0(clk),
		.c0(c0),
		.locked(locked));

	Key_Filter 
	#(
		.cnt_20ms_max(32'd999_999)
	)
	inst_Key_Filter
	(
		.clk(c0),
		.rst_n(rst_n && locked),
		.key(key_in),
		.key_flag(key_flag)
	);

	VGA_Pro inst_VGA_Pro (
		.clk(c0),
		.rst_n(rst_n && locked),
		.key_flag(key_flag),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
	);

endmodule