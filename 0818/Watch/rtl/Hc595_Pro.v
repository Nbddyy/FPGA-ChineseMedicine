module Hc595_Pro (
	input clk,
	input rst_n,
	input [7:0] hours,
	input [7:0] minutes,
	input [7:0] seconds,
	input [5:0] sel_in,
	output ds,
	output shcp,
	output stcp,
	output oe
);
	
	wire [7:0] data_sta;
	wire [5:0] sel_out;

	BCD_Pro inst_BCD_Pro (
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.sel_in(sel_in),
		.data_sta(data_sta),	//这里指的是一个sel_out周期内的对应数码管的标准码元格式
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
		.oe(oe)
	);

endmodule
