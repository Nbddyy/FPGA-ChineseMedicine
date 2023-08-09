`timescale 1ns/1ps
module DIV_16_CNT_tb ();

	reg clk;
	reg rst_n;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	DIV_16_CNT DIV_16_CNT_1 (
		.clk(clk),
		.rst_n(rst_n),
		.div_16(div_16)
	);

endmodule