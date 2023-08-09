module CALCULATOR (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	output wire [17:0] P
);

wire [8:0] add_result;
wire [8:0] sub_result;

ADD ADD_1(
	.A(A),
	.B(B),
	.add_result(add_result)
);

SUB SUB_1(
	.C(C),
	.D(D),
	.sub_result(sub_result)
);

MULT MULT_1(
	.add_result(add_result),
	.sub_result(sub_result),
	.P(P)
	
);

endmodule