`timescale 1ns/1ps

module CLK_4_CNT_tb ();

	reg clk;
	reg rst_n;
	wire clk_4;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	CLK_4_CNT CLK_4_CNT_1 (
		.clk(clk),
		.rst_n(rst_n),
		.clk_4(clk_4)
	);

endmodule