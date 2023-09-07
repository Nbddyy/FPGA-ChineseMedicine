
`timescale 1ns/1ps
module tb_SPI_Hmc7044_Cfg (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	// (*NOTE*) replace reset, clock, others
	wire  spi_clk;
	wire  cs;
	wire  spi_mosi;

	SPI_Hmc7044_Cfg inst_SPI_Hmc7044_Cfg (.clk(clk), .rst_n(rst_n), .spi_clk(spi_clk), .cs(cs), .spi_mosi(spi_mosi));

	
endmodule
