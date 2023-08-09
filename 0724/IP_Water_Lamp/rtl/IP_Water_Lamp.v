module IP_Water_Lamp (
	input clk_50mhz,
	input rst_n,
	output [3:0] led_out
);

	wire c0;
	wire locked;

	/*注意locked为低电平复位*/
	F_PLL F_PLL_1 (
		.inclk0(clk_50mhz),
		.areset(~rst_n),
		.c0(c0),
		.locked(locked));

	Water_Lamp 
	#(
		.cnt_500ms_max(32'd62_499_999)
	)
	Water_Lamp_1
	(
		.clk_125mhz(c0),
		.rst(locked),
		.led_out(led_out)	
	);

endmodule