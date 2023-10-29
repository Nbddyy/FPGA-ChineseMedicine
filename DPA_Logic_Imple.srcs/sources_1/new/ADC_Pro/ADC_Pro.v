module ADC_Pro (
	input clk,
	input rst_n,  // Asynchronous reset active low
	input detect_com,

	output test_over,
	output reset,
	output spi_clk,
	output cs,
	output spi_mosi
);
	wire init_comple;

	ADC_Init #(
		.pow_on_delay(24'd16_000),
		.reset_wid(24'd16_005),
		.regist_delay(24'd16_010)
	) inst_ADC_Init (
		.clk         (clk),
		.rst_n       (rst_n),
		.init_comple (init_comple),
		.reset       (reset)
	);

	wire spi_done;
	wire spi_start;
	wire [7:0] spi_width;
	wire [7:0] index;

	Fsm_Module #(
			.cnt_max(8'd52),
			.spi_width_value(8'd16)
		) inst_Fsm_Module (
			.clk         (clk),
			.rst_n       (rst_n),
			.spi_done    (spi_done),
			.detect_com  (detect_com),
			.init_comple (init_comple),
			.spi_start   (spi_start),
			.spi_width   (spi_width),
			.index       (index),
			.test_over(test_over)
		);

	wire [23:0] spi_wrdata;

	ADS42LB69_Cfg_Data inst_ADS42LB69_Cfg_Data(
		.index(index),
		.spi_wrdata(spi_wrdata)
	);


	SPI_X16 inst_SPI_X16 (
		.clk        (clk),
		.rst_n      (rst_n),
		.spi_start  (spi_start),
		.spi_wrdata (spi_wrdata),
		.spi_width  (spi_width),
		.spi_clk    (spi_clk),
		.cs         (cs),
		.spi_mosi   (spi_mosi),
		.spi_done   (spi_done)
		);


endmodule