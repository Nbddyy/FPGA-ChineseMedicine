module VGA_Colorful (
	input clk,
	input rst_n,
	output hsync,	//行扫描周期
	output vsync,	//场扫描周期
	output [15:0] rgb
);

	wire c0;
	wire locked;

	PLL_25MHz inst_PLL_25MHz (
		.areset(!rst_n),
		.inclk0(clk),
		.c0(c0),
		.locked(locked));

	VGA_Pro inst_VGA_Pro (
		.clk(c0),
		.rst_n(rst_n && locked),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
);

endmodule