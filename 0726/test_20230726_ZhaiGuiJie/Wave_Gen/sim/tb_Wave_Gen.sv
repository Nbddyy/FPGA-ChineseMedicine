
`timescale 1ns/1ps
module tb_Wave_Gen (); /* this is automatically generated */

	reg clk_100mhz;
	reg rst_n;
	wire wave_out;

	initial begin
		clk_100mhz = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #5 clk_100mhz <= ~clk_100mhz;

	Wave_Gen inst_Wave_Gen (
			.clk_100mhz (clk_100mhz),
			.rst_n      (rst_n),
			.wave_out   (wave_out)
		);


endmodule
