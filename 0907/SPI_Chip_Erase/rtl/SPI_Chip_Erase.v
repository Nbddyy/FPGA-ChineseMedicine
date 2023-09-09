module SPI_Chip_Erase (
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

	wire [7:0] spi_wrdata;

	Clk_Div inst_Clk_Div (
		.clk(clk),
		.rst_n(rst_n), 
		.clk_div(clk_div)
	);

	Fsm_Module inst_Fsm_Module 	(
		.clk(clk_div),
		.rst_n(rst_n),
		.spi_done(spi_done),
		.spi_start(spi_start),
		.spi_cmd(spi_cmd),
		.spi_width(spi_width),
		.index(index)
	);

	W25Q16_Cfg_Data inst_W25Q16_Cfg_Data(
		.index(index),
		.spi_wrdata(spi_wrdata)
	);

	SPI_X8 inst_SPI_X8 (
    	.rst_n(rst_n),
    	.clk(clk_div),
    	.spi_start(spi_start),//顶层输入
    	.spi_cmd(spi_cmd),//用于使状态机的状态发生切换暂时无用途
    	.spi_wrdata(spi_wrdata),
    	.spi_width(spi_width),//位宽可以由前一模块决定并且提高灵活性
    	.spi_clk(spi_clk),
    	.cs(cs),
    	.spi_mosi(spi_mosi),
    	.spi_done(spi_done)
	);

endmodule 