module VGA_Solid_Color (
	input clk,
	input rst_n,
	output hsync,
	output vsync,
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