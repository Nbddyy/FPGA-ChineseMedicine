module Test_16_FFT_N4 (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input signed [16:0] A0_real,
	input signed [16:0] A0_imaginary,
	input signed [16:0] A1_real,
	input signed [16:0] A1_imaginary,
	input signed [16:0] A2_real,
	input signed [16:0] A2_imaginary,
	input signed [16:0] A3_real,
	input signed [16:0] A3_imaginary,

	output reg signed [17:0] G0_real,
	output reg signed [17:0] G0_imaginary,
	output reg signed [17:0] G1_real,
	output reg signed [17:0] G1_imaginary,
	output reg signed [17:0] G2_real,
	output reg signed [17:0] G2_imaginary,
	output reg signed [17:0] G3_real,
	output reg signed [17:0] G3_imaginary
);

	/*G0*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G0_real <= 18'd0;
		end else begin
			G0_real <= A0_real + A2_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G0_imaginary <= 18'd0;
		end else begin
			G0_imaginary <= A0_imaginary + A2_imaginary;
		end
	end


	/*
	G1 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-j)
	   = (A_real + A_imaginary) - (B_real + B_imaginary) * j
	   = (A_real + A_imaginary) - B_real_imaginary + B_imaginary_real
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G1_real <= 18'd0;
		end else begin
			G1_real <= A1_real + A3_imaginary; 
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G1_imaginary <= 18'd0;
		end else begin
			G1_imaginary <= A1_imaginary - A3_real;
		end
	end

	/*
	G2 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-1) 
	   = (A_real + A_imaginary) - (B_real + B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G2_real <= 18'd0;
		end else begin
			G2_real <= A0_real - A2_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G2_imaginary <= 18'd0;
		end else begin
			G2_imaginary <= A0_imaginary - A2_imaginary;
		end
	end

	/*
	G3 = (A_real + A_imaginary) + (B_real + B_imaginary) * (j) 
	   = (A_real + A_imaginary) + B_real_imaginary - B_imaginary_real
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G3_real <= 18'd0;
		end else begin
			G3_real <= A1_real - A3_imaginary;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			G3_imaginary <= 18'd0;
		end else begin
			G3_imaginary <= A1_imaginary + A3_real;
		end
	end


endmodule