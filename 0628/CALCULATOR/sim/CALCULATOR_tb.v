`timescale 1ns/1ps

module CALCULATOR_tb ();

wire [17:0] P;

CALCULATOR CALCULATOR_1(
	.A(8'd10),
	.B(8'd20),
	.C(8'd150),
	.D(8'd170),
	.P(P)
);

endmodule