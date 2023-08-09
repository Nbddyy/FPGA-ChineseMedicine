`timescale 1ns/1ps

module TEST_LED_tb ();

	reg CLK;
	reg RST_N;
	wire CNT;

	initial begin
		CLK = 0;
		RST_N = 0;
		#10
		RST_N = 1;
	end

	always #10 CLK = ~CLK;

	TEST_LED TEST_LED_1 (
		.CLK(CLK),
		.RST_N(RST_N),
		.CNT(CNT)
	);

endmodule