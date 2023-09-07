module SPI_Hmc7044_Cfg (
	input clk, 
	input rst_n,
	output spi_clk,
	output cs,
	output spi_mosi
);

	wire clk_div;

	wire spi_done;
	wire spi_start;
	wire [1:0] spi_cmd;
	wire [7:0] spi_width;
	wire [7:0] index;

	wire [23:0] spi_wrdata;

	Clk_Div inst_Clk_Div (
		.clk(clk),
		.rst_n(rst_n), 
		.clk_div(clk_div)
	);

	Fsm_Module 
	#(
		.cnt_max(8'd152),
		.spi_width_value(8'd24)
	)
	inst_Fsm_Module
	(
		.clk(clk_div),
		.rst_n(rst_n),
		.spi_done(spi_done),
		.spi_start(spi_start),
		.spi_cmd(spi_cmd),
		.spi_width(spi_width),
		.index(index)
	);

	Hmc7044_Cfg_Data inst_Hmc7044_Cfg_Data(
		.index(index),
		.spi_wrdata(spi_wrdata)
	);

	SPI_X24 inst_SPI_X24 (
		.clk(clk_div),
		.rst_n(rst_n),
		.spi_start(spi_start),
		.spi_cmd(spi_cmd),
		.spi_wrdata(spi_wrdata),
		.spi_width(spi_width),
		.spi_clk(spi_clk),
		.cs(cs),
		.spi_mosi(spi_mosi),
		.spi_done(spi_done)
	);

endmodule 
