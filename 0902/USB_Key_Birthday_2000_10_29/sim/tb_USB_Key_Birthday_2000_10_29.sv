
`timescale 1ns/1ps
module tb_USB_Key_Birthday_2000_10_29 (); /* this is automatically generated */

	reg clk;
	reg rst_n;
	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	// (*NOTE*) replace reset, clock, others
	reg  key;
	wire  tx;

	initial begin
		key = 1'd1;
		#200
		key = 1'd0;
		#20_100_000
		key = 1'd1;
	end

	USB_Key_Birthday_2000_10_29 inst_USB_Key_Birthday_2000_10_29 (.clk(clk), .rst_n(rst_n), .key(key), .tx(tx));

	
endmodule
