module IP_Flash (
	input clk_50mhz,
	input rst_n,  
	output led_out
);

	wire c0;
	wire locked;

	F_PLL F_PLL_1 (
		.areset(~rst_n),
		.inclk0(clk_50mhz),
		.c0(c0),
		.locked(locked));

	Flash 
	#(
		.cnt_1s_max(32'd199_999_999)
	)
	Flash_1
	(
		.clk_200mhz(c0),
		.rst(locked),
		.led_out(led_out)  
	);


endmodule