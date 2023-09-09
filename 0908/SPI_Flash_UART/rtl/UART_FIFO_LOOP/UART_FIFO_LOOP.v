module UART_FIFO_LOOP (
	input clk,
	input rst_n, 
	input rx,
	output tx
);

	wire [7:0] op_data;
	wire op_flag;

	wire tx_flag;

	wire ip_flag;
	wire [7:0] ip_data;

	SPI_Rx 
	#(
		.baud_cnt_max(24'd5207),
		.cnt_max(8'd148)
	)
	inst_SPI_Rx
	(
		.clk(clk),
		.rst_n(rst_n),
		.rx(rx),
		.op_data(op_data),
		.op_flag(op_flag)
	);

	FSM_CTRL  
	#(
        .usedw_latch(8'd4)
    )
    inst_FSM_CTRL
	(
		.clk(clk),
		.rst_n(rst_n), 
		.op_flag(op_flag),
		.op_data(op_data),
		.tx_flag(tx_flag),
		.ip_flag(ip_flag),
		.ip_data(ip_data)
	);
	
	UART_Tx 
	#(
		.baud_cnt_max(16'd520)
	)
	inst_UART_Tx
	(
		.clk(clk),
		.rst_n(rst_n),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx_flag(tx_flag),
		.tx(tx)
	);

endmodule