module SPI_Flash_UART (
	input clk,
	input rst_n,
	input key,
	input spi_miso,
	output spi_mosi,
	output cs,
	output spi_clk,
	output tx
);

	wire clk_div;

	SPI_W25Q16_Pro inst_SPI_W25Q16_Pro (
		.clk(clk),
		.rst_n(rst_n), 
		.key(key),
		.spi_clk(spi_clk),
		.cs(cs),
		.clk_div(clk_div),
		.spi_mosi(spi_mosi)
	);

	UART_FIFO_LOOP inst_UART_FIFO_LOOP (
		.clk(clk_div),
		.rst_n(rst_n), 
		.rx(spi_miso),
		.tx(tx)
	);


endmodule