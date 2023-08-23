
`timescale 1ns/1ps
module tb_VGA_Solid_Color (); /* this is automatically generated */

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

	VGA_Solid_Color inst_VGA_Solid_Color (.clk(clk), .rst_n(rst_n), .hsync(hsync), .vsync(vsync), .rgb(rgb));

endmodule
