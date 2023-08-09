`timescale 1ns/1ps

module TEST4_TOP_tb ();

reg [7:0] A;
reg [7:0] B;
reg [7:0] C;
reg [7:0] D;
reg [7:0] E;
reg [7:0] F;
reg [7:0] SELECT;
wire [8:0] P;

initial begin
	A = 10;
	B = 20;
	C = 30;
	D = 40;
	E = 50;
	F = 60;
	SELECT = 1;
	#200;
	$stop;
end

always #10 A = {$random} % 256;
always #10 B = {$random} % 256;
always #10 C = {$random} % 256;
always #10 D = {$random} % 256;
always #10 E = {$random} % 256;
always #10 F = {$random} % 256;
always #10 SELECT = {$random} % 3;


TEST4_TOP TEST4_TOP(
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.E(E),
	.F(F),
	.SELECT(SELECT),
	.P(P)
);

endmodule