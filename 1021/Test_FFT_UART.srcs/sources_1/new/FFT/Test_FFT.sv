module Test_FFT (
	input board_clk_100mhz,    // Clock
	input board_rst_n,  // Asynchronous reset active low
	input signed [15:0] datain_real,
	input signed [15:0] datain_imaginary,
	input datain_valid,
	output ip_flag,
	output signed [7:0] ip_data,
	output tx_flag
);

	/*Upside_Down*/
	wire dataout_valid;

	/*Test_FFT_First*/
	wire signed [15:0] x0_real [3:0];
	wire signed [15:0] x0_imaginary [3:0];
	wire signed [15:0] x1_real [3:0];
	wire signed [15:0] x1_imaginary [3:0];

	wire signed [16:0] A0_real [3:0];
	wire signed [16:0] A0_imaginary [3:0];
	wire signed [16:0] A1_real [3:0];
	wire signed [16:0] A1_imaginary [3:0];

	/*Test_FFT_Second*/
	wire signed [17:0] G0_real [1:0];
	wire signed [17:0] G0_imaginary [1:0];
	wire signed [17:0] G1_real [1:0];
	wire signed [17:0] G1_imaginary [1:0];
	wire signed [17:0] G2_real [1:0];
	wire signed [17:0] G2_imaginary [1:0];
	wire signed [17:0] G3_real [1:0];
	wire signed [17:0] G3_imaginary [1:0];

	/*Test_FFT_Third*/
	wire signed [23:0] X0_real;
	wire signed [23:0] X0_imaginary;
	wire signed [23:0] X1_real;
	wire signed [23:0] X1_imaginary;
	wire signed [23:0] X2_real;
	wire signed [23:0] X2_imaginary;
	wire signed [23:0] X3_real;
	wire signed [23:0] X3_imaginary;
	wire signed [23:0] X4_real;
	wire signed [23:0] X4_imaginary;
	wire signed [23:0] X5_real;
	wire signed [23:0] X5_imaginary;
	wire signed [23:0] X6_real;
	wire signed [23:0] X6_imaginary;
	wire signed [23:0] X7_real;
	wire signed [23:0] X7_imaginary;


	/*Upside_Down Initation*/
	Upside_Down inst_Upside_Down (
		.clk(board_clk_100mhz),    // Clock
		.rst_n(board_rst_n),

		.datain_real(datain_real),
		.datain_imaginary(datain_imaginary),
		.datain_valid(datain_valid),

		.dataout0_real(x0_real[0]),
		.dataout0_imaginary(x0_imaginary[0]),
		.dataout1_real(x1_real[0]),
		.dataout1_imaginary(x1_imaginary[0]),
		.dataout2_real(x0_real[1]),
		.dataout2_imaginary(x0_imaginary[1]),
		.dataout3_real(x1_real[1]),
		.dataout3_imaginary(x1_imaginary[1]),
		.dataout4_real(x0_real[2]),
		.dataout4_imaginary(x0_imaginary[2]),
		.dataout5_real(x1_real[2]),
		.dataout5_imaginary(x1_imaginary[2]),
		.dataout6_real(x0_real[3]),
		.dataout6_imaginary(x0_imaginary[3]),
		.dataout7_real(x1_real[3]),
		.dataout7_imaginary(x1_imaginary[3]),

		.tx_flag           (tx_flag),
		.dataout_valid(dataout_valid)
	);


	/*Test_FFT_First Initation*/
	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : generate_4_Test_FFT_First
		Test_FFT_First inst_Test_FFT_First (
		.clk(board_clk_100mhz),    			// Clock
		.rst_n(board_rst_n),  			// Asynchronous reset active low
		.x0_real(x0_real[i]),			// 高一位为符号位：2
		.x0_imaginary(x0_imaginary[i]),	// 2
		.x1_real(x1_real[i]),			// 3
		.x1_imaginary(x1_imaginary[i]),	// -7

		.A0_real(A0_real[i]),
		.A0_imaginary(A0_imaginary[i]),
		.A1_real(A1_real[i]),
		.A1_imaginary(A1_imaginary[i]) 
		);
	end endgenerate

	/*Test_FFT_Second Initation*/
	genvar j;
	generate for(j = 0; j < 2; j = j + 1) begin : generate_2_Test_FFT_Second
		Test_FFT_Second inst_Test_FFT_Second (
			.clk(board_clk_100mhz),    // Clock
			.rst_n(board_rst_n),  // Asynchronous reset active low
			.A0_real(j == 0 ? A0_real[0] : A0_real[2]),
			.A0_imaginary(j == 0 ? A0_imaginary[0] : A0_imaginary[2]),
			.A1_real(j == 0 ? A1_real[0] : A1_real[2]),
			.A1_imaginary(j == 0 ? A1_imaginary[0] : A1_imaginary[2]),
			.A2_real(j == 0 ? A0_real[1] : A0_real[3]),
			.A2_imaginary(j == 0 ? A0_imaginary[1] : A0_imaginary[3]),
			.A3_real(j == 0 ? A1_real[1] : A1_real[3]),
			.A3_imaginary(j == 0 ? A1_imaginary[1] : A1_imaginary[3]),

			.G0_real(G0_real[j]),
			.G0_imaginary(G0_imaginary[j]),
			.G1_real(G1_real[j]),
			.G1_imaginary(G1_imaginary[j]),
			.G2_real(G2_real[j]),
			.G2_imaginary(G2_imaginary[j]),
			.G3_real(G3_real[j]),
			.G3_imaginary(G3_imaginary[j])
		);
	end endgenerate
	
	/*Test_FFT_Third Initation*/
	Test_FFT_Third inst_Test_FFT_Third (
		.clk(board_clk_100mhz),    // Clock
		.rst_n(board_rst_n),

		.G0_real(G0_real[0]),
		.G0_imaginary(G0_imaginary[0]),
		.G1_real(G1_real[0]),
		.G1_imaginary(G1_imaginary[0]),
		.G2_real(G2_real[0]),
		.G2_imaginary(G2_imaginary[0]),
		.G3_real(G3_real[0]),
		.G3_imaginary(G3_imaginary[0]),
		.G4_real(G0_real[1]),
		.G4_imaginary(G0_imaginary[1]),
		.G5_real(G1_real[1]),
		.G5_imaginary(G1_imaginary[1]),
		.G6_real(G2_real[1]),
		.G6_imaginary(G2_imaginary[1]),
		.G7_real(G3_real[1]),
		.G7_imaginary(G3_imaginary[1]),

		.X0_real(X0_real),
		.X0_imaginary(X0_imaginary),
		.X1_real(X1_real),
		.X1_imaginary(X1_imaginary),
		.X2_real(X2_real),
		.X2_imaginary(X2_imaginary),
		.X3_real(X3_real),
		.X3_imaginary(X3_imaginary),
		.X4_real(X4_real),
		.X4_imaginary(X4_imaginary),
		.X5_real(X5_real),
		.X5_imaginary(X5_imaginary),
		.X6_real(X6_real),
		.X6_imaginary(X6_imaginary),
		.X7_real(X7_real),
		.X7_imaginary(X7_imaginary)
	);

	Data_Trs inst_Data_Trs (
		.clk(board_clk_100mhz),
		.rst_n(board_rst_n),  // Asynchronous reset active low
		.dataout_valid(dataout_valid),

		.X0_real(X0_real),
		.X0_imaginary(X0_imaginary),
		.X1_real(X1_real),
		.X1_imaginary(X1_imaginary),
		.X2_real(X2_real),
		.X2_imaginary(X2_imaginary),
		.X3_real(X3_real),
		.X3_imaginary(X3_imaginary),
		.X4_real(X4_real),
		.X4_imaginary(X4_imaginary),
		.X5_real(X5_real),
		.X5_imaginary(X5_imaginary),
		.X6_real(X6_real),
		.X6_imaginary(X6_imaginary),
		.X7_real(X7_real),
		.X7_imaginary(X7_imaginary),

		.ip_flag(ip_flag),
		.ip_data(ip_data)
);

endmodule