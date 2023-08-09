module MAX_MODULE (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	output wire [7:0] P
);

	wire [7:0] max1;
	wire [7:0] max2;

	MAX MAX_1 (
		.A(A),
		.B(B),
		.max(max1)
	);

	MAX MAX_2 (
		.A(B),
		.B(C),
		.max(max2)
	);

	MAX MAX_3 (
		.A(max1),
		.B(max2),
		.max(P)
	);

endmodule