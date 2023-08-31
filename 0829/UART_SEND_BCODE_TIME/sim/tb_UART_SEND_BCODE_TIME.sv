
`timescale 1ns/1ns
module tb_UART_SEND_BCODE_TIME (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk = ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	// (*NOTE*) replace reset, clock, others
	wire  tx;

	UART_SEND_BCODE_TIME inst_UART_SEND_BCODE_TIME (.clk(clk), .rst_n(rst_n), .tx(tx));

endmodule
