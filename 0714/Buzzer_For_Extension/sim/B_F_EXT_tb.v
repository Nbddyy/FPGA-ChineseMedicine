`timescale 1ns/1ns

module B_F_EXT_tb ();

	reg clk;
	reg rst_n;
	wire beep_out;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 clk <= ~clk;

	B_F_EXT B_F_EXT_1
	(
		.clk(clk),
		.rst_n(rst_n),  
		.beep_out(beep_out)
	);

endmodule