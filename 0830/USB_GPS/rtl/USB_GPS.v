module USB_GPS (
	input clk, 
	input rst_n,
	input rx,
	output ds,
	output oe,
	output shcp,
	output stcp
);

	wire op_flag;
	wire [7:0] op_data;

	wire [15:0] hours;
	wire [15:0] minutes;
	wire [15:0] seconds;

	UART_Rx 
	#(
		.baud_cnt_max(24'd5207)
	)
	inst_UART_Rx
	(
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.op_data(op_data),
		.op_flag(op_flag)
	);

	GNRMC_Decode inst_GNRMC_Decode (
		.clk(clk),
		.rst_n(rst_n),
		.op_data(op_data),
		.op_flag(op_flag),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds)
	);

	Hc595_Pro inst_Hc595_Pro (
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.ds(ds),
		.shcp(shcp),
		.stcp(stcp),
		.oe(oe)
	);

endmodule