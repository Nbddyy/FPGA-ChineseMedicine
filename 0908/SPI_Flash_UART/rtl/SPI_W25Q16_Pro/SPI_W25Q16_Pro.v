module SPI_W25Q16_Pro (
	input clk,
	input rst_n, 
	input key,
	output spi_clk,
	output cs,
	output clk_div,
	output spi_mosi
);


	wire flag;

	wire spi_done;
	wire spi_start;
	wire [1:0] spi_cmd;
	wire [7:0] spi_width;
	wire [7:0] index;
	wire led_flag;
	wire [7:0] cnt_number;	

	wire [23:0] spi_wrdata;

	Clk_Div inst_Clk_Div (
		.clk(clk),
		.rst_n(rst_n), 
		.clk_div(clk_div)
	);

	Key_Filter 
	#(
		.cnt_20ms_max(32'd99_999)
	)
	inst_Key_Filter
	(
		.clk(clk_div),
		.rst_n(rst_n),
		.key(key),
		.flag(flag)
	);

	Fsm_Module 
	#(
		.cnt_max(8'd1),
		.spi_width_value(8'd8)
	)
	inst_Fsm_Module
	(
		.clk(clk_div),
		.rst_n(rst_n),
		.spi_done(spi_done),
		.flag(flag),
		.spi_start(spi_start),
		.spi_cmd(spi_cmd),
		.spi_width(spi_width),
		.index(index),
		.led_flag(led_flag),
		.cnt_number(cnt_number)
	);

	SPI_XX 
	#(
		.cnt_number_max(8'd1)
	)
	inst_SPI_XX
	(
		.clk(clk_div),
		.rst_n(rst_n),
		.spi_start(spi_start),
		.spi_cmd(spi_cmd),
		.spi_wrdata(spi_wrdata),
		.spi_width(spi_width),
		.cnt_number(cnt_number),
		.spi_clk(spi_clk),
		.cs(cs),
		.spi_mosi(spi_mosi),
		.spi_done(spi_done)
	);

	W25Q16_Cfg_Data inst_W25Q16_Cfg_Data (
		.index(index),
		.spi_wrdata(spi_wrdata)
	);
	
endmodule