module TEST_TOP (
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

ADD ADD_1(
	.A(A),
	.B(B),
	.add_result(sum1)
);

ADD ADD_2(
	.A(C),
	.B(D),
	.add_result(sum2)
);

ADD ADD_3(
	.A(E),
	.B(F),
	.add_result(sum3)
);

MULT MULT(
	.sum1(sum1),
	.sum2(sum2),
	.sum3(sum3),
	.P(P)
);

endmodule