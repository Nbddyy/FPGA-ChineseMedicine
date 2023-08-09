`timescale 1ns/1ps
module tb_RAM_fftshift (); /* this is automatically generated */

	// clock
	reg clk;
	reg rst_n;
	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;


	// (*NOTE*) replace reset, clock, others
	wire [7:0] q;

	RAM_fftshift inst_RAM_fftshift (.clk(clk), .rst_n(rst_n));
endmodule
