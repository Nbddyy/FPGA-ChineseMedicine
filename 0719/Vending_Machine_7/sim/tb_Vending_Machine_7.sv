
`timescale 1ns/1ps
module tb_Vending_Machine_7 (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk <= ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n = 1'd0;
		#10
		rst_n <= 1'd1;
	end


	// (*NOTE*) replace reset, clock, others
	// defparam inst_Vending_Machine_7.IDLE = "IDLE";
	// defparam   inst_Vending_Machine_7.S0 = "S0";
	// defparam   inst_Vending_Machine_7.S1 = "S1";
	// defparam   inst_Vending_Machine_7.S2 = "S2";
	// defparam   inst_Vending_Machine_7.S3 = "S3";
	// defparam   inst_Vending_Machine_7.S4 = "S4";
	// defparam   inst_Vending_Machine_7.S5 = "S5";

	reg [2:0] coins;
	reg [2:0] temp;
	initial begin
		coins = 3'd0;
		temp = 3'd0;
		forever #(23) begin
			temp <= {$random} % 4;
			coins <= (temp == 3'd2) ? 3'b101 : temp;
		end;
	end


	reg       change;
	reg       ship;
	wire [2:0] refund;

	Vending_Machine_7 inst_Vending_Machine_7 (
			.clk    (clk),
			.rst_n  (rst_n),
			.coins  (coins),
			.change (change),
			.ship   (ship),
			.refund (refund)
		);

endmodule
