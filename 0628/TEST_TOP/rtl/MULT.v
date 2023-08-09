module MULT (
	input wire [8:0] sum1,
	input wire [8:0] sum2,
	input wire [8:0] sum3,
	output wire [26:0] P
);

assign P = sum1 * sum2 * sum3;

endmodule