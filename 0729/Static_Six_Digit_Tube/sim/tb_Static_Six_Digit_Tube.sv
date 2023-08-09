`timescale 1ns/1ns
module tb_Static_Six_Digit_Tube (); /* this is automatically generated */

	reg clk;
	reg rst_n;
	wire ds;
	wire shcp;
	wire stcp;
	wire oe;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	Static_Six_Digit_Tube inst_Static_Six_Digit_Tube (.clk(clk), .rst_n(rst_n), .ds(ds), .shcp(shcp), .stcp(stcp), .oe(oe));

	
endmodule
