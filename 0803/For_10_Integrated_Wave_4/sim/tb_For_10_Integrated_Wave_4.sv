
`timescale 1ns/1ps
module tb_For_10_Integrated_Wave_4 (); /* this is automatically generated */

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
	For_10_Integrated_Wave_4 inst_For_10_Integrated_Wave_4 (.clk(clk), .rst_n(rst_n));
endmodule
