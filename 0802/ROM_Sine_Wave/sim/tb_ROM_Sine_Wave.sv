
`timescale 1ns/1ps
module tb_ROM_Sine_Wave (); /* this is automatically generated */

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
	ROM_Sine_Wave inst_ROM_Sine_Wave (.clk(clk), .rst_n(rst_n));

endmodule
