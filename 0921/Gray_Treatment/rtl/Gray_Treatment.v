module Gray_Treatment (
	input clk,
	input rst_n,
	output hsync,
	output vsync,
	output [15:0] rgb_out
);

	wire c0;
	wire locked;
	wire [15:0] rgb;

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
		.rgb(rgb));


	Gray_Pro inst_Gray_Pro (
		.rgb(rgb), 
		.rgb_out(rgb_out));


endmodule