`timescale 1ns/1ps

module NOT_GATE_15_tb ();

reg A0;
reg A1;
reg A2;
reg A3;
reg A4;
reg A5;
reg A6;
reg A7;
reg A8;
reg A9;
reg A10;
reg A11;
reg A12;
reg A13;
reg A14;

wire Y0;
wire Y1;
wire Y2;
wire Y3;
wire Y4;
wire Y5;
wire Y6;
wire Y7;
wire Y8;
wire Y9;
wire Y10;
wire Y11;
wire Y12;
wire Y13;
wire Y14;

initial begin
	A0 = 0;
	A1 = 0;
	A2 = 0;
	A3 = 0;
	A4 = 0;
	A5 = 0;
	A6 = 0;
	A7 = 0;
	A8 = 0;
	A9 = 0;
	A10 = 0;
	A11 = 0;
	A12 = 0;
	A13 = 0;
	A14 = 0;
	#1000
	$stop;
end

always #10 A0 = {$random} % 2;
always #10 A1 = {$random} % 2;
always #10 A2 = {$random} % 2;
always #10 A3 = {$random} % 2;
always #10 A4 = {$random} % 2;
always #10 A5 = {$random} % 2;
always #10 A6 = {$random} % 2;
always #10 A7 = {$random} % 2;
always #10 A8 = {$random} % 2;
always #10 A9 = {$random} % 2;
always #10 A10 = {$random} % 2;
always #10 A11 = {$random} % 2;
always #10 A12 = {$random} % 2;
always #10 A13 = {$random} % 2;
always #10 A14 = {$random} % 2;


NOT_GATE_15 NOT_GATE_15_1(
	.A0(A0),
	.A1(A1),
	.A2(A2),
	.A3(A3),
	.A4(A4),
	.A5(A5),
	.A6(A6),
	.A7(A7),
	.A8(A8),
	.A9(A9),
	.A10(A10),
	.A11(A11),
	.A12(A12),
	.A13(A13),
	.A14(A14),

	.Y0(Y0),
	.Y1(Y1),
	.Y2(Y2),
	.Y3(Y3),
	.Y4(Y4),
	.Y5(Y5),
	.Y6(Y6),
	.Y7(Y7),
	.Y8(Y8),
	.Y9(Y9),
	.Y10(Y10),
	.Y11(Y11),
	.Y12(Y12),
	.Y13(Y13),
	.Y14(Y14)
);

endmodule