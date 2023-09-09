
`timescale 1ns/1ps
module tb_SPI_Page_Program (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	// (*NOTE*) replace reset, clock, others
	reg       key;
	wire       cs;
	wire       spi_clk;
	wire       spi_mosi;
	wire [3:0] led_out;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	initial begin
		key = 1'd1;
		#200
		key = 1'd0;
		#20_001_000
		key = 1'd1;
	end

	SPI_Page_Program inst_SPI_Page_Program
		(
			.clk      (clk),
			.rst_n    (rst_n),
			.key      (key),
			.cs       (cs),
			.spi_clk  (spi_clk),
			.spi_mosi (spi_mosi),
			.led_out  (led_out)
		);

	
endmodule
