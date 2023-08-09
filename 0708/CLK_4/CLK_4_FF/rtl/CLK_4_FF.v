module CLK_4_FF (
	input clk,
	input rst_n,  
	output out
);

	wire clk_2;

	DIV_4 DIV_4_1 (
		.CLK(clk),
		.RST_N(rst_n),
		.Q(clk_2)
	);

	DIV_4 DIV_4_2 (
		.CLK(clk_2),
		.RST_N(rst_n),
		.Q(out)
	);


endmodule