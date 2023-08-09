module Dynamic_Digital_Tube (
	input clk,
	input rst_n,
	output shcp,
	output stcp,
	output ds,
	output oe
);

	wire [31:0] data_flow;
	wire [5:0] sel;
	wire [5:0] sel_out;
	wire [7:0] sec;

	Data_Flow_Pre Data_Flow_Pre_1
	(
		.clk(clk),
		.rst_n(rst_n),
		.data_flow(data_flow),
		.sel(sel)
	);

	Data_Flow_Control Data_Flow_Control_1 (
		.clk(clk),
		.rst_n(rst_n),
		.data_flow(data_flow),
		.sel_in(sel),
		.sel_out(sel_out),
		.sec(sec)
	);

	Hc595_Pre Hc595_Pre_1 (
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel_out),
		.sec(sec),
		.shcp(shcp),
		.stcp(stcp),
		.ds(ds),
		.oe(oe)
);

endmodule