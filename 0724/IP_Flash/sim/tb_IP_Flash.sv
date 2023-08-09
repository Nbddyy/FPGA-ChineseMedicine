
`timescale 1ns/1ps
module tb_IP_Flash (); /* this is automatically generated */

	// clock
	reg clk_50mhz;
	reg rst_n;
	initial begin
		clk_50mhz = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk_50mhz <= ~clk_50mhz;


	wire led_out;

	IP_Flash inst_IP_Flash (.clk_50mhz(clk_50mhz), .rst_n(rst_n), .led_out(led_out));

endmodule
