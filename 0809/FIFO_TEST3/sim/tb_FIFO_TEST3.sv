
`timescale 1ns/1ps
module tb_FIFO_TEST3 (); /* this is automatically generated */

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= '0;
		#14
		rst_n <= '1;
	end

	// (*NOTE*) replace reset, clock, others
	reg wrclk;	//100MHz
	reg rdclk;	//50MHz

	initial begin
		wrclk = 1'd0;
		rdclk = 1'd0;
	end

	always #5 wrclk <= ~wrclk;
	always #10 rdclk <= ~rdclk;


	reg [31:0] random_data_temp;
	wire [31:0] random_data;
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			random_data_temp <= 32'd0;
		end else begin
			random_data_temp <= {$random} % 256;
		end
	end 

	assign random_data = random_data_temp;

	wire data_valid;
	wire [63:0] up_data;

	FIFO_TEST3 inst_FIFO_TEST3
		(
			.rst_n      (rst_n),
			.random_data(random_data),
			.wrclk      (wrclk),
			.rdclk      (rdclk),
			.data_valid (data_valid),
			.up_data   (up_data)
		);

endmodule
