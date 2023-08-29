
`timescale 1ns/1ps
module tb_USB_Transmission_8_Bytes (); /* this is automatically generated */

	reg clk;
	reg rst_n;
	
	wire tx; 

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14 
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;


	USB_Transmission_8_Bytes inst_USB_Transmission_8_Bytes (.clk(clk), .rst_n(rst_n), .tx(tx));

endmodule
