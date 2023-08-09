`timescale 1ns/1ps

module DIV_7_tb ();

	reg sys_clk;
	reg sys_rst_n;
	wire clk_7;

	initial begin
		sys_clk <= 1'd0;
		sys_rst_n <= 1'd0;
		#14
		sys_rst_n <= 1'd1;
	end

	always #10 sys_clk <= ~sys_clk;

	DIV_7 DIV_7_1 (
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.clk_7(clk_7)
	);

endmodule