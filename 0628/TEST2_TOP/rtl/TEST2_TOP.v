module TEST2_TOP (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	input wire [7:0] E,
	input wire [7:0] F,
	output wire [26:0] P
);

wire [8:0] add_result;
wire [8:0] div_result;
wire [8:0] sub_result;

ADD ADD_1(
	.C(C),
	.D(D),
	.add_result(add_result)
);

DIV DIV_1(
	.A(A),
	.B(B),
	.div_result(div_result)
);

SUB SUB_1(
	.E(E),
	.F(F),
	.sub_result(sub_result)	
);

MULT MULT_1(
	.add_result(add_result),
	.div_result(div_result),
	.sub_result(sub_result),
	.P(P)
);

endmodule