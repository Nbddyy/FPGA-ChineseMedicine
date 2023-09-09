
`timescale 1ns/1ps
module tb_SPI_W25Q16_Pro (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	// (*NOTE*) replace reset, clock, others
	reg  key;
	wire  spi_clk;
	wire  cs;
	wire  spi_mosi;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	initial begin
		key = 1'd1;
		#200
		key = 1'd0;
		#20_001_000
		key = 1'd1;
	end

	SPI_W25Q16_Pro inst_SPI_W25Q16_Pro
		(
			.clk      (clk),
			.rst_n    (rst_n),
			.key      (key),
			.spi_clk  (spi_clk),
			.cs       (cs),
			.spi_mosi (spi_mosi)
		);

endmodule
