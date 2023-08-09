`timescale 1ns/1ns

module tb_RAM_2_PORT_Extension ();

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	RAM_2_PORT_Extension RAM_2_PORT_Extension_1 (
		.clk(clk),
		.rst_n(rst_n)
	);

endmodule


