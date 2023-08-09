module MAX (
	input wire [7:0] A,
	input wire [7:0] B,
	output wire [7:0] max
);

assign max = (A > B) ? A : B;

endmodule