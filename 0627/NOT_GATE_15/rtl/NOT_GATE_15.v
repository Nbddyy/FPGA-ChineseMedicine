module NOT_GATE_15 (
	input wire A0,
	input wire A1,
	input wire A2,
	input wire A3,
	input wire A4,
	input wire A5,
	input wire A6,
	input wire A7,
	input wire A8,
	input wire A9,
	input wire A10,
	input wire A11,
	input wire A12,
	input wire A13,
	input wire A14,

	output wire Y0,
	output wire Y1,
	output wire Y2,
	output wire Y3,
	output wire Y4,
	output wire Y5,
	output wire Y6,
	output wire Y7,
	output wire Y8,
	output wire Y9,
	output wire Y10,
	output wire Y11,
	output wire Y12,
	output wire Y13,
	output wire Y14

);

assign Y0 = ~A0;
assign Y1 = ~A1;
assign Y2 = ~A2;
assign Y3 = ~A3;
assign Y4 = ~A4;
assign Y5 = ~A5;
assign Y6 = ~A6;
assign Y7 = ~A7;
assign Y8 = ~A8;
assign Y9 = ~A9;
assign Y10 = ~A10;
assign Y11 = ~A11;
assign Y12 = ~A12;
assign Y13 = ~A13;
assign Y14 = ~A14;

endmodule