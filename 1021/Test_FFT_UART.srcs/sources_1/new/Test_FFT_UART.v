module Test_FFT_UART (
	input board_clk_100mhz,    // Clock
	input board_rst_n,  // Asynchronous reset active low
	input rx,
	output tx
);

	wire tx_flag;
	wire datain_valid;
	wire signed [15:0] datain_real;
	wire signed [15:0] datain_imaginary;
	wire ip_flag;
	wire signed [7:0] ip_data;

	Test_UART inst_Test_UART (
		.board_clk_100mhz(board_clk_100mhz),    // Clock
		.board_rst_n(board_rst_n),  // Asynchronous reset active low
		.rx(rx),
		.tx_flag(tx_flag),
		.datain_valid(datain_valid),
		.datain_real(datain_real),
		.datain_imaginary(datain_imaginary),
		.ip_flag(ip_flag),
		.ip_data(ip_data),
		.tx(tx)
	);

	Test_FFT inst_Test_FFT (
		.board_clk_100mhz(board_clk_100mhz),    // Clock
		.board_rst_n(board_rst_n),  // Asynchronous reset active low
		.datain_real(datain_real),
		.datain_imaginary(datain_imaginary),
		.datain_valid(datain_valid),
		.ip_flag(ip_flag),
		.ip_data(ip_data),
		.tx_flag(tx_flag)
	);	

endmodule