module UART_LED (
	input clk,
	input rst_n,
	input rx,
	output [3:0] led_out
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

	Detect_Module inst_Detect_Module (
		.clk(clk),
		.rst_n(rst_n), 
		.op_data(op_data),
		.op_flag(op_flag),
		.led_out(led_out)
	);

endmodule