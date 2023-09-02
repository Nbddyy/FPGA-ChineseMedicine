module USB_Piano (
	input clk,
	input rst_n,
	input rx,
	output beep
);

	wire c0;
	wire locked;

	wire op_flag;
	wire [7:0] op_data;

	wire flag;

	PLL_125MHz inst_PLL_125MHz (
		.areset(!rst_n),
		.inclk0(clk),
		.c0(c0),
		.locked(locked));

	UART_Rx 
	#(
		.baud_cnt_max(16'd1085)
	)
	inst_UART_Rx
	(
		.clk(c0),
		.rst_n(rst_n && locked),
		.rx(rx),
		.op_flag(op_flag),
		.op_data(op_data)
	);

	Detect_Module inst_Detect_Module (
		.clk(c0),
		.rst_n(rst_n && locked),
		.op_flag(op_flag),
		.op_data(op_data),
		.flag(flag)
	);


	Buzzer 
	#(
		.cnt_1s_max(32'd124_999_999),
		.cnt_Do_max(24'd238_549),	//各个蜂鸣器频率计数
		.cnt_Re_max(24'd212_585),
		.cnt_Mi_max(24'd189_394),
		.cnt_Fa_max(24'd179_083),
		.cnt_So_max(24'd159_439),
		.cnt_La_max(24'd142_045),
		.cnt_Si_max(24'd126_518)
	)
	inst_Buzzer
	(
		.clk(c0),
		.rst_n(rst_n && locked),
		.flag(flag),
		.beep(beep)
	);

endmodule