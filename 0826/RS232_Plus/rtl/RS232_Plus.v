module RS232_Plus (
	input clk,
	input rst_n,
	input rx,
	output tx
);

	wire [7:0] op_data;
	wire op_flag;

	UART_Rx inst_UART_Rx (
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.op_data(op_data),
		.op_flag(op_flag)
	);

	UART_Tx inst_UART_Tx (
		.clk(clk),
		.rst_n(rst_n),
		.ip_data(op_data),
		.ip_flag(op_flag),
		.tx(tx)
	);

	
endmodule
