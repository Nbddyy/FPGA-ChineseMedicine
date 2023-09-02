module USB_Key_Birthday_2000_10_29 (
	input clk,
	input rst_n,
	input key,
	output tx
);

	wire key_flag;

	wire rx;

	wire op_flag;
	wire [7:0] op_data;

	wire ip_flag;
	wire [7:0] ip_data;

	Key_Filter 
	#(
		.cnt_20ms_max(24'd999_999)
	)
	inst_Key_Filter
	(
		.clk(clk),
		.rst_n(rst_n), 
		.key(key),
		.key_flag(key_flag)
	);

	Data_Gen 
	#(
		.birth_year(16'h2000),
		.birth_month(8'h10),
		.birth_day(8'h29),
		.baud_cnt_max(12'd433)
	)
	isnt_Data_Gen
	(
		.clk(clk),
		.rst_n(rst_n),
		.key_flag(key_flag),
		.rx(rx)
	);

	UART_Rx 
	#(
		.baud_cnt_max(12'd433)
	)
	inst_UART_Rx
	(
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.op_flag(op_flag),
		.op_data(op_data)
	);

	Buffer_Module 
	#(
		.cnt_baud_max(16'd4500) 	//比码元间隔多几个clk
	)
	inst_Buffer_Module
	(
		.clk(clk),
		.rst_n(rst_n), 
		.op_flag(op_flag),
		.op_data(op_data),
		.ip_flag(ip_flag),
		.ip_data(ip_data)
	);

	UART_Tx 
	#(
		.baud_cnt_max(16'd433)
	)
	inst_UART_Tx
	(
		.clk(clk),
		.rst_n(rst_n),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx(tx)
	);

endmodule