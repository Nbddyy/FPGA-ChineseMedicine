module DPA_Logic_Imple (
	input board_clk_100mhz,     // Clock
	input board_rst_n,  		// Asynchronous reset active low

	input clk_p,
	input clk_n,
	input din0_p,
	input din0_n,
	input din2_p,
	input din2_n,
	input din4_p,
	input din4_n,
	input din6_p,
	input din6_n,
	input din8_p,
	input din8_n,
	input din10_p,
	input din10_n,
	input din12_p,
	input din12_n,
	input din14_p,
	input din14_n,

	output reset,
	output spi_clk,
	output cs,
	output spi_mosi,
	output [15:0] dout16
);

	wire clk_out1;	//10MHz
	wire clk_out2;	//200MHz
	wire clk_out3;	//250MHz
	wire locked;

  	PLL_10_200_250MHz instance_name
   	(
    	// Clock out ports
    	.clk_out1(clk_out1),     // output clk_out1
    	.clk_out2(clk_out2),     // output clk_out2
    	.clk_out3(clk_out3),     // output clk_out3
    	// Status and control signals
    	.reset(!board_rst_n), // input reset
    	.locked(locked),       // output locked
   		// Clock in ports
    	.clk_in1(board_clk_100mhz));      // input clk_in1

   	wire [1:0] detect_com;

	ADC_Pro inst_ADC_Pro
		(
			.clk        (clk_out1),
			.rst_n      (board_rst_n && locked),
			.detect_com (detect_com),
			.reset      (reset),
			.spi_clk    (spi_clk),
			.cs         (cs),
			.spi_mosi   (spi_mosi)
		);


	Data_Pro inst_Data_Pro
		(
			.rst_n   (board_rst_n && locked),
			.refclk  (clk_out2),
			.clk_p   (clk_p),
			.clk_n   (clk_n),
			.din0_p  (din0_p),
			.din0_n  (din0_n),
			.din2_p  (din2_p),
			.din2_n  (din2_n),
			.din4_p  (din4_p),
			.din4_n  (din4_n),
			.din6_p  (din6_p),
			.din6_n  (din6_n),
			.din8_p  (din8_p),
			.din8_n  (din8_n),
			.din10_p (din10_p),
			.din10_n (din10_n),
			.din12_p (din12_p),
			.din12_n (din12_n),
			.din14_p (din14_p),
			.din14_n (din14_n),
			.dout16  (dout16),
			.detect_com(detect_com)
		);


endmodule