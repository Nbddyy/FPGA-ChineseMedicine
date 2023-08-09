`timescale 1ns/1ps

module TEST2_tb ();

	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] C;
	reg [7:0] D;
	wire [7:0] Y;

	initial begin
		A = 8'd32;
		B = 8'd24;
		#200;
		$stop;
	end

	always #10 A = {$random} % 256;
	always #10 B = {$random} % 256;

	TEST2 TEST2(
		.A(A),
		.B(B),
		.C(C),
		.D(D),
		.Y(Y)
	);

endmodule