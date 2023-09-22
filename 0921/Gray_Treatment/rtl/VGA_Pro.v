module VGA_Pro (
	input clk,
	input rst_n,  
	output hsync,
	output vsync,
	output [15:0] rgb
);

	wire [9:0] pix_x;
	wire [9:0] pix_y;
	wire [15:0] pix_data;

	VGA_Time inst_VGA_Time (
			.clk      (clk),
			.rst_n    (rst_n),
			.pix_data (pix_data),
			.pix_x    (pix_x),
			.pix_y    (pix_y),
			.hsync    (hsync),
			.vsync    (vsync),
			.rgb      (rgb)
		);

	VGA_Image inst_VGA_Image (
		.clk(clk), 
		.rst_n(rst_n), 
		.pix_x(pix_x), 
		.pix_y(pix_y), 
		.pix_data(pix_data));


endmodule