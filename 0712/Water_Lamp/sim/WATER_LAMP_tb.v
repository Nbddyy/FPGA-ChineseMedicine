module WATER_LAMP_tb ();

	reg clk;
	reg rst_n;
	wire n_led_state;


	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	WATER_LAMP WATER_LAMP_1 (
		.clk(clk),
		.rst_n(rst_n), 
		.n_led_state(n_led_state)
	);

endmodule


