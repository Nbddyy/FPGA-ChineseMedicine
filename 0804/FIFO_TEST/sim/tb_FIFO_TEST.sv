
`timescale 1ns/1ps
module tb_FIFO_TEST (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	reg [15:0] random_data;
	reg [15:0] random_data_in;

	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			random_data <= 16'd0;
		end else begin
			random_data <= {$random} % 256;
		end
	end

	assign random_data_in = random_data;

	// (*NOTE*) replace reset, clock, others
	FIFO_TEST inst_FIFO_TEST (.clk(clk), .rst_n(rst_n), .random_data(random_data_in));

	
endmodule
