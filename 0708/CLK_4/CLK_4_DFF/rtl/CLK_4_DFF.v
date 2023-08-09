module CLK_4_DFF (
	input clk,
	input rst_n,  
	output out
);
	
	wire temp1,temp2;
	wire clk_2;


	DIV_4 DIV_4_1 (
		.CLK(clk),
		.RST_N(rst_n),
		.D(temp1),
		.Q_NOT_GATE(temp1),
		.Q(clk_2)
	);
	
	DIV_4 DIV_4_2 (
		.CLK(clk_2),
		.RST_N(rst_n),
		.D(temp2),
		.Q_NOT_GATE(temp2),
		.Q(out)
	);
	


endmodule