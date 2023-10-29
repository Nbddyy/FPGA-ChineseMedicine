module Test_UART (
	input board_clk_100mhz,    // Clock
	input board_rst_n,  // Asynchronous reset active low
	input rx,
	input tx_flag,
	output datain_valid,
	output signed [15:0] datain_real,
	output signed [15:0] datain_imaginary,
	output ip_flag,
	output signed [7:0] ip_data,
	output tx
);

	wire [31:0] datain;

	wire op_flag;
	wire [7:0] op_data;

	assign datain_real = datain[31:16];
	assign datain_imaginary = datain[15:0];

	UART_Rx 
	#(
		.baud_cnt_max(16'd10_416)
	)
	inst_UART_Rx 
	(
		.clk(board_clk_100mhz),
		.rst_n(board_rst_n),
		.rx(rx),
		.op_data(op_data),
		.op_flag(op_flag)
	);

	FSM_CTRL 
	#(
	    .usedw_latch(8'd16)
	)
	inst_FSM_CTRL
	(
		.clk(board_clk_100mhz),
		.rst_n(board_rst_n), 
		.op_flag(op_flag),
		.op_data(op_data),
		.tx_flag(tx_flag),
		.ip_flag(datain_valid),
		.ip_data(datain)
	);

	UART_Tx 
	#(
		.baud_cnt_max(16'd10_416)
	)
	inst_UART_Tx
	(
		.clk(board_clk_100mhz),
		.rst_n(board_rst_n),
		.ip_data(ip_data),
		.ip_flag(ip_flag),
		.tx(tx) 
	);

endmodule