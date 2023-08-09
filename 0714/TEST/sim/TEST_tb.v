`timescale 1ns/1ns

module TEST_tb ();

	reg clk;
	reg rst_n;
	wire led_out;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	TEST 
	#(
		.max(32'd24)
	)
	TEST_1
	(
		.clk(clk),
		.rst_n(rst_n), 
		.led_out(led_out)
	);

endmodule 