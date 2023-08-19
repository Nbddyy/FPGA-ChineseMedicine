module Watch (
	input clk,
	input rst_n,
	output ds,
	output shcp,
	output stcp,
	output oe
);

	wire [7:0] hours;
	wire [7:0] minutes;
	wire [7:0] seconds;
	wire [5:0] sel_gen;

    Data_Gen inst_Data_Gen 
	(
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.sel_gen(sel_gen)
	);

	Hc595_Pro inst_Hc595_Pro (
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.sel_in(sel_gen),
		.ds(ds),
		.shcp(shcp),
		.stcp(stcp),
		.oe(oe)
);

endmodule
