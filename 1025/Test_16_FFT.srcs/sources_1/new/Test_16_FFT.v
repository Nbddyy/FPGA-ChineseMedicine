//==================================================================================================
//  Filename      : Test_16_FFT.v
//  Created On    : 2023-10-25 19:40:47
//  Last Modified : 2023-10-25 23:19:16
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module Test_16_FFT (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low

	input [15:0] datain_real,
	input [15:0] datain_imaginary,
	input datain_valid
);

	genvar i;
	genvar j;
	genvar k;

	/*Test_16_FFT_N2 input*/
	wire [15:0] A0_real [7:0];
	wire [15:0] A0_imaginary [7:0];
	wire [15:0] A1_real [7:0];
	wire [15:0] A1_imaginary [7:0];

	/*Test_16_FFT_N2 output */
	wire [16:0] F0_real [7:0];
	wire [16:0] F0_imaginary [7:0];
	wire [16:0] F1_real [7:0];
	wire [16:0] F1_imaginary [7:0];

	/*Test_16_FFT_N4 output*/
	wire [17:0] S0_real [3:0];
	wire [17:0] S0_imaginary [3:0];
	wire [17:0] S1_real [3:0];
	wire [17:0] S1_imaginary [3:0];
	wire [17:0] S2_real [3:0];
	wire [17:0] S2_imaginary [3:0];
	wire [17:0] S3_real [3:0];
	wire [17:0] S3_imaginary [3:0];

	/*Test_16_FFT_N8 output*/
	wire [18:0] T0_real [1:0];
	wire [18:0] T0_imaginary [1:0];
	wire [18:0] T1_real [1:0];
	wire [18:0] T1_imaginary [1:0];
	wire [18:0] T2_real [1:0];
	wire [18:0] T2_imaginary [1:0];
	wire [18:0] T3_real [1:0];
	wire [18:0] T3_imaginary [1:0];
	wire [18:0] T4_real [1:0];
	wire [18:0] T4_imaginary [1:0];
	wire [18:0] T5_real [1:0];
	wire [18:0] T5_imaginary [1:0];
	wire [18:0] T6_real [1:0];
	wire [18:0] T6_imaginary [1:0];
	wire [18:0] T7_real [1:0];
	wire [18:0] T7_imaginary [1:0];

	/*Test_16_FFT_N16 output*/
	wire signed [19:0] FO0_real;
	wire signed [19:0] FO0_imaginary;
	wire signed [19:0] FO1_real;
	wire signed [19:0] FO1_imaginary;
	wire signed [19:0] FO2_real;
	wire signed [19:0] FO2_imaginary;
	wire signed [19:0] FO3_real;
	wire signed [19:0] FO3_imaginary;
	wire signed [19:0] FO4_real;
	wire signed [19:0] FO4_imaginary;
	wire signed [19:0] FO5_real;
	wire signed [19:0] FO5_imaginary;
	wire signed [19:0] FO6_real;
	wire signed [19:0] FO6_imaginary;
	wire signed [19:0] FO7_real;
	wire signed [19:0] FO7_imaginary;
	wire signed [19:0] FO8_real;
	wire signed [19:0] FO8_imaginary;
	wire signed [19:0] FO9_real;
	wire signed [19:0] FO9_imaginary;
	wire signed [19:0] FO10_real;
	wire signed [19:0] FO10_imaginary;
	wire signed [19:0] FO11_real;
	wire signed [19:0] FO11_imaginary;
	wire signed [19:0] FO12_real;
	wire signed [19:0] FO12_imaginary;
	wire signed [19:0] FO13_real;
	wire signed [19:0] FO13_imaginary;
	wire signed [19:0] FO14_real;
	wire signed [19:0] FO14_imaginary;
	wire signed [19:0] FO15_real;
	wire signed [19:0] FO15_imaginary;

	Upside_Down inst_Upside_Down (
		.clk(clk),    // Clock
		.rst_n(rst_n),

		.datain_real(datain_real),
		.datain_imaginary(datain_imaginary),
		.datain_valid(datain_valid),

		.dataout0_real(A0_real[0]),
		.dataout0_imaginary(A0_imaginary[0]),
		.dataout1_real(A1_real[0]),
		.dataout1_imaginary(A1_imaginary[0]),
		.dataout2_real(A0_real[1]),
		.dataout2_imaginary(A0_imaginary[1]),
		.dataout3_real(A1_real[1]),
		.dataout3_imaginary(A1_imaginary[1]),
		.dataout4_real(A0_real[2]),
		.dataout4_imaginary(A0_imaginary[2]),
		.dataout5_real(A1_real[2]),
		.dataout5_imaginary(A1_imaginary[2]),
		.dataout6_real(A0_real[3]),
		.dataout6_imaginary(A0_imaginary[3]),
		.dataout7_real(A1_real[3]),
		.dataout7_imaginary(A1_imaginary[3]),

		.dataout8_real(A0_real[4]),
		.dataout8_imaginary(A0_imaginary[4]),
		.dataout9_real(A1_real[4]),
		.dataout9_imaginary(A1_imaginary[4]),
		.dataout10_real(A0_real[5]),
		.dataout10_imaginary(A0_imaginary[5]),
		.dataout11_real(A1_real[5]),
		.dataout11_imaginary(A1_imaginary[5]),
		.dataout12_real(A0_real[6]),
		.dataout12_imaginary(A0_imaginary[6]),
		.dataout13_real(A1_real[6]),
		.dataout13_imaginary(A1_imaginary[6]),
		.dataout14_real(A0_real[7]),
		.dataout14_imaginary(A0_imaginary[7]),
		.dataout15_real(A1_real[7]),
		.dataout15_imaginary(A1_imaginary[7])

	);

	generate for(i = 0; i < 8; i = i + 1) begin : generate_8_Test_16_FFT_N2
		
		Test_16_FFT_N2 inst_Test_16_FFT_N2 (
			.clk(clk),    			// Clock
			.rst_n(rst_n),  			// Asynchronous reset active low
			.x0_real(A0_real[i]),	// 高一位为符号位
			.x0_imaginary(A0_imaginary[i]),
			.x1_real(A1_real[i]),
			.x1_imaginary(A1_imaginary[i]),
		
			.A0_real(F0_real[i]),
			.A0_imaginary(F0_imaginary[i]),
			.A1_real(F1_real[i]),
			.A1_imaginary(F1_imaginary[i]) 
		);

	end endgenerate

	generate for(j = 0; j < 4; j = j + 1) begin : generate_4_Test_16_FFT_N4
		
		Test_16_FFT_N4 inst_Test_16_FFT_N4 (
			.clk(clk),    // Clock
			.rst_n(rst_n),  // Asynchronous reset active low
	
			.A0_real(F0_real[j*2]),
			.A0_imaginary(F0_imaginary[j*2]),
			.A1_real(F1_real[j*2]),
			.A1_imaginary(F1_imaginary[j*2]),
			.A2_real(F0_real[2*j+1]),
			.A2_imaginary(F0_imaginary[2*j+1]),
			.A3_real(F1_real[2*j+1]),
			.A3_imaginary(F1_imaginary[2*j+1]),

			.G0_real(S0_real[j]),
			.G0_imaginary(S0_imaginary[j]),
			.G1_real(S1_real[j]),
			.G1_imaginary(S1_imaginary[j]),
			.G2_real(S2_real[j]),
			.G2_imaginary(S2_imaginary[j]),
			.G3_real(S3_real[j]),
			.G3_imaginary(S3_imaginary[j])
	);

	end endgenerate
	

	generate for(k = 0; k < 2; k = k + 1) begin : generate_2_Test_16_FFT_N8
		
		Test_16_FFT_N8 inst_Test_16_FFT_N8 (
			.clk(clk),    // Clock
			.rst_n(rst_n),

			.G0_real(S0_real[k*2]),
			.G0_imaginary(S0_imaginary[k*2]),
			.G1_real(S1_real[k*2]),
			.G1_imaginary(S1_imaginary[k*2]),
			.G2_real(S2_real[k*2]),
			.G2_imaginary(S2_imaginary[k*2]),
			.G3_real(S3_real[k*2]),
			.G3_imaginary(S3_imaginary[k*2]),
			.G4_real(S0_real[k*2+1]),
			.G4_imaginary(S0_imaginary[k*2+1]),
			.G5_real(S1_real[k*2 + 1]),
			.G5_imaginary(S1_imaginary[k*2 + 1]),
			.G6_real(S2_real[k*2 + 1]),
			.G6_imaginary(S2_imaginary[k*2 + 1]),
			.G7_real(S3_real[k*2 + 1]),
			.G7_imaginary(S3_imaginary[k*2 + 1]),

			.X0_real(T0_real[k]),
			.X0_imaginary(T0_imaginary[k]),
			.X1_real(T1_real[k]),
			.X1_imaginary(T1_imaginary[k]),
			.X2_real(T2_real[k]),
			.X2_imaginary(T2_imaginary[k]),
			.X3_real(T3_real[k]),
			.X3_imaginary(T3_imaginary[k]),
			.X4_real(T4_real[k]),
			.X4_imaginary(T4_imaginary[k]),
			.X5_real(T5_real[k]),
			.X5_imaginary(T5_imaginary[k]),
			.X6_real(T6_real[k]),
			.X6_imaginary(T6_imaginary[k]),
			.X7_real(T7_real[k]),
			.X7_imaginary(T7_imaginary[k])
		);

	end endgenerate

	Test_16_FFT_N16 inst_Test_16_FFT_N16 (
		.clk(clk),    // Clock
		.rst_n(rst_n),  // Asynchronous reset active low
	
		.X0_real(T0_real[0]),
		.X0_imaginary(T0_imaginary[0]),
		.X1_real(T1_real[0]),
		.X1_imaginary(T1_imaginary[0]),
		.X2_real(T2_real[0]),
		.X2_imaginary(T2_imaginary[0]),
		.X3_real(T3_real[0]),
		.X3_imaginary(T3_imaginary[0]),
		.X4_real(T4_real[0]),
		.X4_imaginary(T4_imaginary[0]),
		.X5_real(T5_real[0]),
		.X5_imaginary(T5_imaginary[0]),
		.X6_real(T6_real[0]),
		.X6_imaginary(T6_imaginary[0]),
		.X7_real(T7_real[0]),
		.X7_imaginary(T7_imaginary[0]),
		.X8_real(T0_real[1]),
		.X8_imaginary(T0_imaginary[1]),
		.X9_real(T1_real[1]),
		.X9_imaginary(T1_imaginary[1]),
		.X10_real(T2_real[1]),
		.X10_imaginary(T2_imaginary[1]),
		.X11_real(T3_real[1]),
		.X11_imaginary(T3_imaginary[1]),
		.X12_real(T4_real[1]),
		.X12_imaginary(T4_imaginary[1]),
		.X13_real(T5_real[1]),
		.X13_imaginary(T5_imaginary[1]),
		.X14_real(T6_real[1]),
		.X14_imaginary(T6_imaginary[1]),
		.X15_real(T7_real[1]),
		.X15_imaginary(T7_imaginary[1]),

		.FO0_real(FO0_real),
		.FO0_imaginary(FO0_imaginary),
		.FO1_real(FO1_real),
		.FO1_imaginary(FO1_imaginary),
		.FO2_real(FO2_real),
		.FO2_imaginary(FO2_imaginary),
		.FO3_real(FO3_real),
		.FO3_imaginary(FO3_imaginary),
		.FO4_real(FO4_real),
		.FO4_imaginary(FO4_imaginary),
		.FO5_real(FO5_real),
		.FO5_imaginary(FO5_imaginary),
		.FO6_real(FO6_real),
		.FO6_imaginary(FO6_imaginary),
		.FO7_real(FO7_real),
		.FO7_imaginary(FO7_imaginary),
		.FO8_real(FO8_real),
		.FO8_imaginary(FO8_imaginary),
		.FO9_real(FO9_real),
		.FO9_imaginary(FO9_imaginary),
		.FO10_real(FO10_real),
		.FO10_imaginary(FO10_imaginary),
		.FO11_real(FO11_real),
		.FO11_imaginary(FO11_imaginary),
		.FO12_real(FO12_real),
		.FO12_imaginary(FO12_imaginary),
		.FO13_real(FO13_real),
		.FO13_imaginary(FO13_imaginary),
		.FO14_real(FO14_real),
		.FO14_imaginary(FO14_imaginary),
		.FO15_real(FO15_real),
		.FO15_imaginary(FO15_imaginary)
);

endmodule