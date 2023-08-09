`timescale 1ns/1ps

module TEST3_TOP_tb ();

wire [26:0] P;

TEST3_TOP TEST3_TOP_1(
	.A(8'd10),
	.B(8'd20),
	.C(8'd30),
	.D(8'd40),
	.E(8'd50),
	.F(8'd60),
	.P(P)
);

endmodule