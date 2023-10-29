module Test_FFT_First (
	input clk,    			// Clock
	input rst_n,  			// Asynchronous reset active low
	input signed [15:0] x0_real,	// 高一位为符号位
	input signed [15:0] x0_imaginary,
	input signed [15:0] x1_real,
	input signed [15:0] x1_imaginary,
	
	output reg signed [16:0] A0_real,
	output reg signed [16:0] A0_imaginary,
	output reg signed [16:0] A1_real,
	output reg signed [16:0] A1_imaginary 
);
	
	/*output A0_real*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			A0_real <= 17'd0;
		end else begin
			A0_real <= x0_real + x1_real;
		end
	end

	/*output A1_real*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			A1_real <= 17'd0;
		end else begin
			A1_real <= x0_real - x1_real;
		end
	end

	/*output A0_imaginary*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			A0_imaginary <= 17'd0;
		end else begin
			A0_imaginary <= x0_imaginary + x1_imaginary;
		end
	end

	/*output A1_imaginary*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			A1_imaginary <= 17'd0;
		end else begin
			A1_imaginary <= x0_imaginary - x1_imaginary;
		end
	end



endmodule