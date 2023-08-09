module DIV_16_FF (
	input clk,
	input rst_n,
	output out
);

	wire q1,q2,q3;

	FF FF_1 (
		.clk(clk),
		.rst_n(rst_n),
		.Q(q1)
	);

	FF FF_2 (
		.clk(q1),
		.rst_n(rst_n),
		.Q(q2)
	);

	FF FF_3 (
		.clk(q2),
		.rst_n(rst_n),
		.Q(q3)
	);

	FF FF_4 (
		.clk(q3),
		.rst_n(rst_n),
		.Q(out)
	);

endmodule