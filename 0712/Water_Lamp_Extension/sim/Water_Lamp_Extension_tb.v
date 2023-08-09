`timescale 1ns/1ns

module Water_Lamp_Extension_tb ();

	reg clk;
	reg rst_n;
	wire led_state;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	Water_Lamp_Extension Water_Lamp_Extension_1 (
		.clk(clk),
		.rst_n(rst_n),
		.led_state(led_state)
	);

endmodule