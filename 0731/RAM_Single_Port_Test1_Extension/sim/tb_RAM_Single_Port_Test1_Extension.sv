
`timescale 1ns/1ps
module tb_RAM_Single_Port_Test1_Extension (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	RAM_Single_Port_Test1_Extension inst_RAM_Single_Port_Test1_Extension (.clk(clk), .rst_n(rst_n));

endmodule
