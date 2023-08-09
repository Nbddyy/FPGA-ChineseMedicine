
`timescale 1ns/1ps
module tb_Integrated_Waveform (); /* this is automatically generated */

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
	Integrated_Waveform inst_Integrated_Waveform (.clk(clk), .rst_n(rst_n));

endmodule
