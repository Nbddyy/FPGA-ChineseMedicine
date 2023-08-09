
`timescale 1ns/1ps
module tb_S_D_E (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk <= ~clk;
	end
 
	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= 1'd0;
		#10
		rst_n <= 1'd1;
	end


	reg  data_in; 
	wire  find_10010;


	initial begin
		data_in <= 1'd0;
	end
	always #13 data_in <= {$random} % 2;

	S_D_E inst_S_D_E (
			.clk        (clk),
			.rst_n      (rst_n),
			.data_in    (data_in),
			.find_10010 (find_10010)
		);

	
endmodule
