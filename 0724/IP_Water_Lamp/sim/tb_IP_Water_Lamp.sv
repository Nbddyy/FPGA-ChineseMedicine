
`timescale 1ns/1ns
module tb_IP_Water_Lamp (); /* this is automatically generated */

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

	// (*NOTE*) replace reset, clock, others
	
	wire [3:0] led_out;

	IP_Water_Lamp IP_Water_Lamp_1 (
		.clk_50mhz(clk_50mhz),
		.rst_n(rst_n),
		.led_out(led_out)
	);

endmodule
