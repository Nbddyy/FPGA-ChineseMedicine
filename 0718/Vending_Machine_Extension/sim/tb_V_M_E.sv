
`timescale 1ns/1ps
module tb_V_M_E (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk <= ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= '0;
		#10
		rst_n <= '1;
	end

	reg [2:0] coin;
	reg [2:0] temp;
	initial begin
		coin <= 3'd0;
		temp <= 3'd0;
		forever #(23) begin
			temp <= {$random} % 4;
			coin <= (temp == 2) ? 3'b101 : temp;
		end;
	end

	wire       change;
	wire    [2:0]   refund;
	wire       shipping;


	V_M_E inst_V_M_E (
			.clk      (clk),
			.rst_n    (rst_n),
			.coin     (coin),
			.change   (change),
			.refund   (refund),
			.shipping (shipping)
		);

	
endmodule
