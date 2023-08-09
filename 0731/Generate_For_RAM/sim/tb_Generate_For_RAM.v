
`timescale 1ns/1ns
module tb_Generate_For_RAM ();

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;




	Generate_For_RAM Generate_For_RAM_1 (
		.clk(clk),
		.rst_n(rst_n)
	);

endmodule