`timescale 1ns/1ps

module TEST7_tb ();

	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] C;
	reg [7:0] D;
	reg [7:0] E;
	reg [7:0] F;
	reg [7:0] G;
	reg [7:0] H;
	reg [2:0] SEL;
	wire [7:0] Y;

	initial 
		begin
			A = 8'd10;
			B = 8'd10;
			C = 8'd10;
			D = 8'd10;
			E = 8'd10;
			F = 8'd10;
			G = 8'd10;
			H = 8'd10;
			SEL = 3'b000;
			#200;
			$stop;
		end

	always #10 A = {$random} % 256;
	always #10 B = {$random} % 256;
	always #10 C = {$random} % 256;
	always #10 D = {$random} % 256;
	always #10 E = {$random} % 256;
	always #10 F = {$random} % 256;
	always #10 G = {$random} % 256;
	always #10 H = {$random} % 256;
	always #10 SEL = {$random} % 8;

	TEST7 TEST7(
		.A(A),
		.B(B),
		.C(C),
		.D(D),
		.E(E),
		.F(F),
		.G(G),
		.H(H),
		.SEL(SEL),
		.Y(Y)
	);

endmodule