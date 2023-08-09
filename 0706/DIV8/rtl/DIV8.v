module DIV8 (
	input wire clk,
	input wire rst_n,
	output wire out
);
	wire q1;
	wire q2;
	wire q3;

	assign out = q3;

	D D_1 (
		.clk(clk),
		.rst_n(rst_n),
		.q(q1)
	);

	D D_2 (
		.clk(q1),
		.rst_n(rst_n),
		.q(q2)
	);

	D D_3 (
		.clk(q2),
		.rst_n(rst_n),
		.q(q3)
	);

endmodule 