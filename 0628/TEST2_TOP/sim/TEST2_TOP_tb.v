`timescale 1ns/1ps

module TEST2_TOP_tb ();

wire [26:0] P;

TEST2_TOP TEST2_TOP_1(
	.A(20),
	.B(10),
	.C(30),
	.D(40),
	.E(60),
	.F(50),
	.P(P)
);

endmodule