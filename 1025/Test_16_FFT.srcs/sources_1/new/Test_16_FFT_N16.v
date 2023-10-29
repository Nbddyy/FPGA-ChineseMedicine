module Test_16_FFT_N16 (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	
	input signed [18:0] X0_real,
	input signed [18:0] X0_imaginary,
	input signed [18:0] X1_real,
	input signed [18:0] X1_imaginary,
	input signed [18:0] X2_real,
	input signed [18:0] X2_imaginary,
	input signed [18:0] X3_real,
	input signed [18:0] X3_imaginary,
	input signed [18:0] X4_real,
	input signed [18:0] X4_imaginary,
	input signed [18:0] X5_real,
	input signed [18:0] X5_imaginary,
	input signed [18:0] X6_real,
	input signed [18:0] X6_imaginary,
	input signed [18:0] X7_real,
	input signed [18:0] X7_imaginary,
	input signed [18:0] X8_real,
	input signed [18:0] X8_imaginary,
	input signed [18:0] X9_real,
	input signed [18:0] X9_imaginary,
	input signed [18:0] X10_real,
	input signed [18:0] X10_imaginary,
	input signed [18:0] X11_real,
	input signed [18:0] X11_imaginary,
	input signed [18:0] X12_real,
	input signed [18:0] X12_imaginary,
	input signed [18:0] X13_real,
	input signed [18:0] X13_imaginary,
	input signed [18:0] X14_real,
	input signed [18:0] X14_imaginary,
	input signed [18:0] X15_real,
	input signed [18:0] X15_imaginary,

	output reg signed [19:0] FO0_real,
	output reg signed [19:0] FO0_imaginary,
	output reg signed [19:0] FO1_real,
	output reg signed [19:0] FO1_imaginary,
	output reg signed [19:0] FO2_real,
	output reg signed [19:0] FO2_imaginary,
	output reg signed [19:0] FO3_real,
	output reg signed [19:0] FO3_imaginary,
	output reg signed [19:0] FO4_real,
	output reg signed [19:0] FO4_imaginary,
	output reg signed [19:0] FO5_real,
	output reg signed [19:0] FO5_imaginary,
	output reg signed [19:0] FO6_real,
	output reg signed [19:0] FO6_imaginary,
	output reg signed [19:0] FO7_real,
	output reg signed [19:0] FO7_imaginary,
	output reg signed [19:0] FO8_real,
	output reg signed [19:0] FO8_imaginary,
	output reg signed [19:0] FO9_real,
	output reg signed [19:0] FO9_imaginary,
	output reg signed [19:0] FO10_real,
	output reg signed [19:0] FO10_imaginary,
	output reg signed [19:0] FO11_real,
	output reg signed [19:0] FO11_imaginary,
	output reg signed [19:0] FO12_real,
	output reg signed [19:0] FO12_imaginary,
	output reg signed [19:0] FO13_real,
	output reg signed [19:0] FO13_imaginary,
	output reg signed [19:0] FO14_real,
	output reg signed [19:0] FO14_imaginary,
	output reg signed [19:0] FO15_real,
	output reg signed [19:0] FO15_imaginary
);

	/*
	FO0 = (A_real + A_imaginary) + (B_real + B_imaginary) * 1
		= (A_real + B_real) + (A_imaginary + B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO0_real <= 20'd0;
		end else begin
			FO0_real <= X0_real + X8_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO0_imaginary <= 20'd0;
		end else begin
			FO0_imaginary <= X0_imaginary + X8_imaginary;
		end
	end

	/*
	FO1 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.924 - 0.383j)
		= (A_real + A_imaginary) + (0.924*B_real - 0.383*B_real_imaginary + 0.924*B_imaginary + 0.383*B_imaginary_real)
		= (A_real + 0.924*B_real + 0.383*B_imaginary_real) + (A_imaginary - 0.383*B_real_imaginary + 0.924*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO1_real <= 20'd0;
		end else begin
			FO1_real <= (X1_real * 1024 + 946 * X9_real + 392 * X9_imaginary);
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO1_imaginary <= 20'd0;
		end else begin
			FO1_imaginary <= (X1_imaginary * 1024 - 392 * X9_real + 946 * X9_imaginary);
		end
	end

	/*
	FO2 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.707 - 0.707j)
		= (A_real + A_imaginary) + 0.707*B_real - 0.707*B_real_imaginary + 0.707*B_imaginary + 0.707*B_imaginary_real
		= (A_real + 0.707*B_real + 0.707*B_imaginary_real) + (A_imaginary - 0.707*B_real_imaginary + 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO2_real <= 20'd0;
		end else begin
			FO2_real <= (1024 * X2_real + 724 * X10_real + 724 * X10_imaginary);
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO2_imaginary <= 20'd0;
		end else begin
			FO2_imaginary <= (1024 * X2_imaginary - 724 * X10_real + 724 * X10_imaginary);
		end
	end

	/*
	FO3 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.383 - 0.924j)
		= (A_real + A_imaginary) + (0.383*B_real - 0.924*B_real_imaginary + 0.383*B_imaginary + 0.924*B_imaginary_real)
		= (A_real + 0.383*B_real + 0.924*B_imaginary_real) + (A_imaginary - 0.924*B_real_imaginary + 0.383*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO3_real <= 20'd0;
		end else begin
			FO3_real <= (X3_real * 1024 + 392 * X11_real + 946 * X11_imaginary);
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO3_imaginary <= 20'd0;
		end else begin
			FO3_imaginary <= (X3_imaginary * 1024 - 946 * X11_real + 392 * X11_imaginary);
		end
	end

	/*
	FO4 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-j)
		= (A_real + A_imaginary) -B_real_imaginary + B_imaginary_real
		= (A_real + B_imaginary_real) + (A_imaginary - B_real_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO4_real <= 20'd0;
		end else begin
			FO4_real <= X4_real + X12_imaginary;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO4_imaginary <= 20'd0;
		end else begin
			FO4_imaginary <= X4_imaginary - X12_real;
		end
	end

	/*
	FO5 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.383 - 0.924j)
		= (A_real + A_imaginary) + (-0.383*B_real - 0.924*B_real_imaginary - 0.383*B_imaginary + 0.924*B_imaginary_real)
		= (A_real - 0.383*B_real + 0.924*B_imaginary_real) + (A_imaginary - 0.924*B_real_imaginary - 0.383*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO5_real <= 20'd0;
		end else begin
			FO5_real <= (X5_real * 1024 - 392 * X13_real + 946 * X13_imaginary);
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO5_imaginary <= 20'd0;
		end else begin
			FO5_imaginary <= (X5_imaginary * 1024 - 946 * X13_real - 392 * X13_imaginary);
		end
	end

	/*
	FO6 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.707 - 0.707j)
		= (A_real + A_imaginary) - 0.707*B_real - 0.707*B_real_imaginary - 0.707*B_imaginary + 0.707*B_imaginary_real
		= (A_real - 0.707*B_real + 0.707*B_imaginary_real) + (A_imaginary - 0.707*B_real_imaginary - 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO6_real <= 20'd0;
		end else begin
			FO6_real <= (1024 * X6_real - 724 * X14_real + 724 * X14_imaginary);
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO6_imaginary <= 20'd0;
		end else begin
			FO6_imaginary <= (1024 * X6_imaginary - 724 * X14_real - 724 * X14_imaginary);
		end
	end

	/*
	FO7 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.924 - 0.383j)
		= (A_real + A_imaginary) + (-0.924*B_real - 0.383*B_real_imaginary - 0.924*B_imaginary + 0.383*B_imaginary_real)
		= (A_real - 0.924*B_real + 0.383*B_imaginary_real) + (A_imaginary - 0.383*B_real_imaginary - 0.924*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO7_real <= 20'd0;
		end else begin
			FO7_real <= (X7_real * 1024 - 946 * X15_real + 392 * X15_imaginary) ;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO7_imaginary <= 20'd0;
		end else begin
			FO7_imaginary <= (X7_imaginary * 1024 - 392 * X15_real - 946 * X15_imaginary) / 1024;
		end
	end

	/*
	FO8 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-1)
		= (A_real - B_real) + (A_imaginary - B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO8_real <= 20'd0;
		end else begin
			FO8_real <= X0_real - X8_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO8_imaginary <= 20'd0;
		end else begin
			FO8_imaginary <= X0_imaginary - X8_imaginary;
		end
	end

	/*
	FO9 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.924 + 0.383j)
		= (A_real + A_imaginary) + (-0.924*B_real + 0.383*B_real_imaginary - 0.924*B_imaginary - 0.383*B_imaginary_real)
		= (A_real - 0.924*B_real - 0.383*B_imaginary_real) + (A_imaginary + 0.383*B_real_imaginary - 0.924*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO9_real <= 20'd0;
		end else begin
			FO9_real <= (X1_real * 1024 - 946 * X9_real - 392 * X9_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO9_imaginary <= 20'd0;
		end else begin
			FO9_imaginary <= (X1_imaginary * 1024 + 392 * X9_real - 946 * X9_imaginary) / 1024;
		end
	end

	/*
	FO10 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.707 + 0.707j)
		= (A_real + A_imaginary) + 0.707*B_real - 0.707*B_real_imaginary + 0.707*B_imaginary + 0.707*B_imaginary_real
		= (A_real - 0.707*B_real - 0.707*B_imaginary_real) + (A_imaginary + 0.707*B_real_imaginary - 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO10_real <= 20'd0;
		end else begin
			FO10_real <= (1024 * X2_real - 724 * X10_real - 724 * X10_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO10_imaginary <= 20'd0;
		end else begin
			FO10_imaginary <= (1024 * X2_imaginary + 724 * X10_real - 724 * X10_imaginary) / 1024;
		end
	end

	/*
	FO11 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.383 + 0.924j)
		= (A_real + A_imaginary) + (0.383*B_real - 0.924*B_real_imaginary + 0.383*B_imaginary + 0.924*B_imaginary_real)
		= (A_real - 0.383*B_real - 0.924*B_imaginary_real) + (A_imaginary + 0.924*B_real_imaginary - 0.383*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO11_real <= 20'd0;
		end else begin
			FO11_real <= (X3_real * 1024 - 392 * X11_real - 946 * X11_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO11_imaginary <= 20'd0;
		end else begin
			FO11_imaginary <= (X3_imaginary * 1024 + 946 * X11_real - 392 * X11_imaginary) / 1024;
		end
	end

	/*
	FO12 = (A_real + A_imaginary) + (B_real + B_imaginary) * (j)
		= (A_real + A_imaginary) -B_real_imaginary + B_imaginary_real
		= (A_real - B_imaginary_real) + (A_imaginary + B_real_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO12_real <= 20'd0;
		end else begin
			FO12_real <= X4_real - X12_imaginary;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO12_imaginary <= 20'd0;
		end else begin
			FO12_imaginary <= X4_imaginary + X12_real;
		end
	end

	/*
	FO13 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.383 + 0.924j)
		= (A_real + A_imaginary) + (-0.383*B_real - 0.924*B_real_imaginary - 0.383*B_imaginary + 0.924*B_imaginary_real)
		= (A_real + 0.383*B_real - 0.924*B_imaginary_real) + (A_imaginary + 0.924*B_real_imaginary + 0.383*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO13_real <= 20'd0;
		end else begin
			FO13_real <= (X5_real * 1024 + 392 * X13_real - 946 * X13_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO13_imaginary <= 20'd0;
		end else begin
			FO13_imaginary <= (X5_imaginary * 1024 + 946 * X13_real + 392 * X13_imaginary) / 1024;
		end
	end

	/*
	FO14 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.707 + 0.707j)
		= (A_real + A_imaginary) - 0.707*B_real - 0.707*B_real_imaginary - 0.707*B_imaginary + 0.707*B_imaginary_real
		= (A_real + 0.707*B_real - 0.707*B_imaginary_real) + (A_imaginary + 0.707*B_real_imaginary + 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO14_real <= 20'd0;
		end else begin
			FO14_real <= (1024 * X6_real + 724 * X14_real - 724 * X14_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO14_imaginary <= 20'd0;
		end else begin
			FO14_imaginary <= (1024 * X6_imaginary + 724 * X14_real + 724 * X14_imaginary) / 1024;
		end
	end

	/*
	FO15 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.924 + 0.383j)
		= (A_real + A_imaginary) + (-0.924*B_real - 0.383*B_real_imaginary - 0.924*B_imaginary + 0.383*B_imaginary_real)
		= (A_real + 0.924*B_real - 0.383*B_imaginary_real) + (A_imaginary + 0.383*B_real_imaginary + 0.924*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO15_real <= 20'd0;
		end else begin
			FO15_real <= (X7_real * 1024 + 946 * X15_real - 392 * X15_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			FO15_imaginary <= 20'd0;
		end else begin
			FO15_imaginary <= (X7_imaginary * 1024 + 392 * X15_real - 946 * X15_imaginary) / 1024;
		end
	end

endmodule