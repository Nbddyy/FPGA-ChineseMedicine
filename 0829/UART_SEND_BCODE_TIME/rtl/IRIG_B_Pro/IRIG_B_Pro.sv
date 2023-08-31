module IRIG_B_Pro (
	input clk,
	input rst_n,
	output [7:0] ip_data,
	output ip_flag
);


	wire ex_bcode_signal;


	B_Gen
	#(
		.cnt_10ms(24'd1_249_999),
	    .cnt_8ms(24'd999_999),
	    .cnt_5ms(24'd624_999),
	    .cnt_2ms(24'd249_999)
	)
	inst_B_Gen
	(
		.clk(clk),
		.rst_n(rst_n),
		.ex_bcode_signal(ex_bcode_signal)
	); 

	IRIG_Parse
	#(
		.bcode_0_flag(24'd249_999),
		.bcode_1_flag(24'd624_999),
		.bcode_p_flag(24'd999_999)
	)
	inst_IRIG_Parse
	(
		.clk(clk),
		.rst_n(rst_n),
		.ex_bcode_signal(ex_bcode_signal),
		.ip_data(ip_data),
		.ip_flag(ip_flag)
	);


endmodule