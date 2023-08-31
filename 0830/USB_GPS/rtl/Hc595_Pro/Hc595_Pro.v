module Hc595_Pro (
	input clk,
	input rst_n,
	input [15:0] hours,
	input [15:0] minutes,
	input [15:0] seconds,
	output ds,
	output shcp,
	output stcp,
	output oe
);

	wire [7:0] data_sta;
	wire [5:0] sel_out;

	Hc595_Sel 
	#(
		.cnt_1ms_max(16'd49_999)
	)
	inst_Hc595_Sel
	(
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.data_sta(data_sta),
		.sel_out(sel_out)
	);

	Hc595_Pre inst_Hc595_Pre (
		.clk(clk),
		.rst_n(rst_n),
		.data_pre(data_sta),
		.sel_in(sel_out),
		.ds(ds),
		.shcp(shcp),
		.stcp(stcp),
		.oe(oe));

endmodule