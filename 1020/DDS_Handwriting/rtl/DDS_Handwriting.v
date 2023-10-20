module DDS_Handwriting (
	input clk,    // Clock
	output [7:0] data_out
);

	wire [7:0] data_out_2;
	wire [7:0] data_out_3;

	ddr3 inst_ddr3_1 (
		.clk(clk),    // Clock
		.f_word(8'd1),
		.p_word(8'd0),
		.data_out(data_out)
	);

	ddr3 inst_ddr3_2 (
		.clk(clk),    // Clock
		.f_word(8'd1),
		.p_word(8'd10),
		.data_out(data_out_2)
	);

	ddr3 inst_ddr3_3 (
		.clk(clk),    // Clock
		.f_word(8'd8),
		.p_word(8'd0),
		.data_out(data_out_3)
	);


endmodule