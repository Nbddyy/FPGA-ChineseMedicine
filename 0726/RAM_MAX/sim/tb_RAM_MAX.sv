
`timescale 1ns/1ps
module tb_RAM_MAX (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	wire [7:0] max;
	wire [7:0] max_address;

	RAM_MAX	inst_RAM_MAX (.clk(clk), .rst_n(rst_n), .max(max), .max_address(max_address));

endmodule
