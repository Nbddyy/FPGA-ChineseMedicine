`timescale 1ns/1ps

module TEST_TOP_tb ();

reg [7:0] A;
reg [7:0] B;
reg [7:0] C;
reg [7:0] D;
reg [7:0] E;
reg [7:0] F;
wire [26:0] P;

initial begin
	A = 10;
	B = 10;
	C = 10;
	D = 10;
	E = 10;
	F = 10;
end

always #10 A = {$random} % 255;
always #10 B = {$random} % 255;
always #10 C = {$random} % 255;
always #10 D = {$random} % 255;
always #10 E = {$random} % 255;
always #10 F = {$random} % 255;

TEST_TOP TEST_TOP (
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.E(E),
	.F(F),
	.P(P)
);

endmodule