
`timescale 1ns/1ns
module tb_Dynamic_Digital_Tube (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	wire shcp;
	wire stcp;
	wire ds;
	wire oe;

	Dynamic_Digital_Tube inst_Dynamic_Digital_Tube (.clk(clk), .rst_n(rst_n), .shcp(shcp), .stcp(stcp), .ds(ds), .oe(oe));

endmodule
