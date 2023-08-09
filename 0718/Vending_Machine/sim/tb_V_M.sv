
`timescale 1ns/1ps
module tb_V_M (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk = ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= 1'd0;
		#10
		rst_n <= 1'd1;
	end

	reg [1:0] coin;

	initial begin
		coin <= 2'b00;
		forever #(13) coin <= {$random} % 3;
	end

	wire       change;
	wire       shipping;

	V_M inst_V_M (
			.clk      (clk),
			.rst_n    (rst_n),
			.coin     (coin),
			.change   (change),
			.shipping (shipping)
		);

endmodule
