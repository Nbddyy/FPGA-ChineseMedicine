module Test_FFT_Third (
	input clk,    // Clock
	input rst_n,

	input signed [17:0] G0_real,
	input signed [17:0] G0_imaginary,
	input signed [17:0] G1_real,
	input signed [17:0] G1_imaginary,
	input signed [17:0] G2_real,
	input signed [17:0] G2_imaginary,
	input signed [17:0] G3_real,
	input signed [17:0] G3_imaginary,
	input signed [17:0] G4_real,
	input signed [17:0] G4_imaginary,
	input signed [17:0] G5_real,
	input signed [17:0] G5_imaginary,
	input signed [17:0] G6_real,
	input signed [17:0] G6_imaginary,
	input signed [17:0] G7_real,
	input signed [17:0] G7_imaginary,

	output reg signed [23:0] X0_real,
	output reg signed [23:0] X0_imaginary,
	output reg signed [23:0] X1_real,
	output reg signed [23:0] X1_imaginary,
	output reg signed [23:0] X2_real,
	output reg signed [23:0] X2_imaginary,
	output reg signed [23:0] X3_real,
	output reg signed [23:0] X3_imaginary,
	output reg signed [23:0] X4_real,
	output reg signed [23:0] X4_imaginary,
	output reg signed [23:0] X5_real,
	output reg signed [23:0] X5_imaginary,
	output reg signed [23:0] X6_real,
	output reg signed [23:0] X6_imaginary,
	output reg signed [23:0] X7_real,
	output reg signed [23:0] X7_imaginary
);

	/*
	X0 = (A_real + A_imaginary) + (B_real + B_imaginary) * 1
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X0_real <= 24'd0;
		end else begin
			X0_real <= G0_real + G4_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X0_imaginary <= 24'd0;
		end else begin
			X0_imaginary <= G0_imaginary + G4_imaginary;
		end
	end

	/*
	X1 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.707 - 0.707j)
	   = (A_real + A_imaginary) + (0.707*B_real - 0.707*B_real_imaginary + 0.707*B_imaginary + 0.707*B_imaginary_real)
	   = (A_real + 0.707*B_real + 0.707*B_imaginary_real) + (A_imaginary - 0.707*B_real_imaginary + 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X1_real <= 24'd0;
		end else begin
			X1_real <= (G1_real * 1024 + 723 * G5_real + 723 * G5_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X1_imaginary <= 24'd0;
		end else begin
			X1_imaginary <= (G1_imaginary * 1024 - 723 * G5_real + 723 * G5_imaginary) / 1024;
		end
	end

	/*
	X2 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-j)
	   = (A_real + A_imaginary) - B_real_imaginary + B_imaginary_real
	   = (A_real + B_imaginary_real) + (A_imaginary - B_real_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X2_real <= 24'd0;
		end else begin
			X2_real <= G2_real + G6_imaginary;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X2_imaginary <= 24'd0;
		end else begin
			X2_imaginary <= G2_imaginary - G6_real;
		end
	end

	/*
	X3 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.707 - 0.707j)
	   = (A_real + A_imaginary) + (-0.707*B_real - 0.707*B_real_imaginary - 0.707*B_imaginary + B_imaginary_real)
	   = (A_real - 0.707*B_real + B_imaginary_real) + (A_imaginary - 0.707*B_real_imaginary - 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X3_real <= 24'd0;
		end else begin
			X3_real <= (G3_real * 1024 - 723 * G7_real + G7_imaginary * 1024) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X3_imaginary <= 24'd0;
		end else begin
			X3_imaginary <= (G3_imaginary * 1024 - 723 * G7_real - 723 * G7_imaginary) / 1024;
		end
	end

	/*
	X4 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-1)
	   = (A_real + A_imaginary) - B_real - B_imaginary
	   = (A_real - B_real) + (A_imaginary - B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X4_real <= 24'd0;
		end else begin
			X4_real <= G0_real - G4_real;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X4_imaginary <= 24'd0;
		end else begin
			X4_imaginary <= G0_imaginary - G4_imaginary;
		end
	end

	/*
	X5 = (A_real + A_imaginary) + (B_real + B_imaginary) * (-0.707 + 0.707j)
	   = (A_real + A_imaginary) + (-0.707*B_real + 0.707*B_real_imaginary - 0.707*B_imaginary - 0.707*B_imaginary_real)
	   = (A_real + A_imaginary) - 0.707*B_real + 0.707*B_real_imaginary - 0.707*B_imaginary - 0.707*B_imaginary_real
	   = (A_real - 0.707*B_real - 0.707*B_imaginary_real) + (A_imaginary + 0.707*B_real_imaginary - 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X5_real <= 24'd0;
		end else begin
			X5_real <= (G1_real * 1024 - 723 * G5_real - 723 * G5_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X5_imaginary <= 24'd0;
		end else begin
			X5_imaginary <= (G1_imaginary * 1024 + 723 * G5_real - 723 * G5_imaginary) / 1024;
		end
	end

	/*
	X6 = (A_real + A_imaginary) + (B_real + B_imaginary) * j
	   = (A_real + A_imaginary) + B_real_imaginary - B_imaginary_real
	   = (A_real - B_imaginary_real) + (A_imaginary + B_real_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X6_real <= 24'd0;
		end else begin
			X6_real <= G2_real - G6_imaginary;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X6_imaginary <= 24'd0;
		end else begin
			X6_imaginary <= G2_imaginary + G6_real;
		end
	end

	/*
	X7 = (A_real + A_imaginary) + (B_real + B_imaginary) * (0.707 + 0.707j)
	   = (A_real + A_imaginary) + (0.707*B_real + 0.707*B_real_imaginary + 0.707*B_imaginary - 0.707*B_imaginary_real)
	   = (A_real + 0.707*B_real - 0.707*B_imaginary_real) + (A_imaginary + 0.707*B_real_imaginary + 0.707*B_imaginary)
	*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X7_real <= 24'd0;
		end else begin
			X7_real <= (G3_real * 1024 + 723 * G7_real - 723 * G7_imaginary) / 1024;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			X7_imaginary <= 24'd0;
		end else begin
			X7_imaginary <= (G3_imaginary * 1024 + 723 * G7_real + 723 * G7_imaginary) / 1024;
		end
	end



endmodule