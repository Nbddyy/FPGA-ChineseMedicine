
`timescale 1ns/1ps
module tb_SM (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #10 clk = ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= 1'd0;
		#10
		rst_n <= 1'd1;
	end


	//data_in
	reg data_in;
	initial begin
		data_in <= 1'd0;
	end

	always #10 data_in <= {$random} % 2;

	// (*NOTE*) replace reset, clock, others
	parameter IDLE = 8'd0;
	parameter   S0 = 8'd1;
	parameter   S1 = 8'd2;
	parameter   S2 = 8'd3;
	parameter   S3 = 8'd4;
	parameter   S4 = 8'd5;

	wire  find_ok;

	SM inst_SM (
			.clk     (clk),
			.rst_n   (rst_n),
			.data_in (data_in),
			.find_ok (find_ok)
		);

	
endmodule
