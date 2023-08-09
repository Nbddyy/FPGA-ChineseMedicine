module TEST4_TOP (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	input wire [7:0] E,
	input wire [7:0] F,
	input wire [7:0] SELECT,
	output wire [8:0] P
);

wire [8:0] M1;
wire [8:0] M2;
wire [8:0] M3;

ADD ADD_1(
	.A(A),
	.B(B),
	.add_result(M1)
);

ADD ADD_2(
	.A(C),
	.B(D),
	.add_result(M2)
);

ADD ADD_3(
	.A(E),
	.B(F),
	.add_result(M3)
);

MUX MUX(
	.M1(M1),
	.M2(M2),
	.M3(M3),
	.SELECT(SELECT),
	.P(P)
);

endmodule