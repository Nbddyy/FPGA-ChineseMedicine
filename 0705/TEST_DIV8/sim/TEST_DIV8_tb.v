`timescale 1ns/1ps

module TEST_DIV8_tb ();

	reg CLK;
	reg RST_N;
	wire DIV8;

	initial begin
		CLK <= 1'd0;
		RST_N <= 1'd0;
		#14
		RST_N <= 1'd1;
	end

	always #10 CLK <= ~CLK;

TEST_DIV8 TEST_DIV8_1 (
	.CLK(CLK),
	.RST_N(RST_N),
	.DIV8(DIV8)
);

endmodule