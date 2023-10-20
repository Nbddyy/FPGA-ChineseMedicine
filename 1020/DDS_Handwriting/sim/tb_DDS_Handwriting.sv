
`timescale 1ns/1ps
module tb_DDS_Handwriting (); /* this is automatically generated */

	reg clk;
	initial begin
		clk = 1'd0;
	end

	always #6 clk <= !clk;

	// (*NOTE*) replace reset, clock, others
	wire [7:0] data_out;

	DDS_Handwriting inst_DDS_Handwriting (.clk(clk), .data_out(data_out));

	
endmodule
