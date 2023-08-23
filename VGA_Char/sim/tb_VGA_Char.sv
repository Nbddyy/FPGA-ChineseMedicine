
`timescale 1ns/1ps
module tb_VGA_Char (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	

	// (*NOTE*) replace reset, clock, others
	wire        hsync;
	wire        vsync;
	wire [15:0] rgb;

	VGA_Char inst_VGA_Char (
		.clk(clk),
		.rst_n(rst_n),
		.key_in(key_in),
		.hsync(hsync),
		.vsync(vsync),
		.rgb(rgb)
	);

endmodule
