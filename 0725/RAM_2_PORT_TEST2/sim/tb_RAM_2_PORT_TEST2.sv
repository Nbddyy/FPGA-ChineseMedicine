`timescale 1ns/1ps
module tb_RAM_2_PORT_TEST2 (); /* this is automatically generated */

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
	RAM_2_PORT_TEST2 inst_RAM_2_PORT_TEST2 (.clk(clk), .rst_n(rst_n));

endmodule
