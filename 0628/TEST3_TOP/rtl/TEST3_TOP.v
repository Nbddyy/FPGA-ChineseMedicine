module TEST3_TOP (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	input wire [7:0] E,
	input wire [7:0] F,
	output wire [26:0] P
);

wire [8:0] sum1;
wire [8:0] sum2;
wire [8:0] sum3;

ADD1 ADD1_1(
	.A(A),
	.B(B),
	.add_result(sum1)
);

ADD2 ADD2_1(
	.C(C),
	.D(D),
	.add_result(sum2)
);

ADD3 ADD3_1(
	.E(E),
	.F(F),
	.add_result(sum3)
);

MULT MULT_1(
	.sum1(sum1),
	.sum2(sum2),
	.sum3(sum3),
	.P(P)
);

endmodule