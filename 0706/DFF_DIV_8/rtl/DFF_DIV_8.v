module DFF_DIV_8 (
	input clk,
	input rst_n,
	output out
);

	wire q1;
	wire q2;
	wire temp1,temp2,temp3;

	D_FF D_FF_1 (
		.clk(clk),
		.rst_n(rst_n),
		.D(temp1),
		.Q(q1),
		.Q_NOT_GATE(temp1)
	);

	D_FF D_FF_2 (
		.clk(q1),
		.rst_n(rst_n),
		.D(temp2),
		.Q(q2),
		.Q_NOT_GATE(temp2)
	);

	D_FF D_FF_3 (
		.clk(q2),
		.rst_n(rst_n),
		.D(temp3),
		.Q(out),
		.Q_NOT_GATE(temp3)
	);


endmodule