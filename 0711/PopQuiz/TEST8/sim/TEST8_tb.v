`timescale 1ns/1ps

module TEST8_tb ();

	reg clk;
	reg rst_n;
	wire bright;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	TEST8 TEST8_1 (
		.clk(clk),
		.rst_n(rst_n),
		.bright(bright)
	);

endmodule