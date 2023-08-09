`timescale 1ns/1ps

module DIV8_tb ();

	reg clk;
	reg rst_n;
	wire out;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#13
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	DIV8 DIV8_1 (
	.clk(clk),
	.rst_n(rst_n),
	.out(out)
	);

endmodule