module DIV_16_DFF (
	input clk,
	input rst_n,
	output out
);

	wire temp1,temp2,temp3,temp4;
	wire q1,q2,q3;

	D_FF D_FF_1 (
		.clk(clk),
		.D(temp1),
		.rst_n(rst_n),
		.Q(q1),
		.Q_NOT_GATE(temp1)
	);

	D_FF D_FF_2 (
		.clk(q1),
		.D(temp2),
		.rst_n(rst_n),
		.Q(q2),
		.Q_NOT_GATE(temp2)
	);

	D_FF D_FF_3 (
		.clk(q2),
		.D(temp3),
		.rst_n(rst_n),
		.Q(q3),
		.Q_NOT_GATE(temp3)
	);

	D_FF D_FF_4 (
		.clk(q3),
		.D(temp4),
		.rst_n(rst_n),
		.Q(out),
		.Q_NOT_GATE(temp4)
	);

endmodule