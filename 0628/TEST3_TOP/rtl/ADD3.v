module ADD3 (
	input wire [7:0] E,
	input wire [7:0] F,
	output wire [8:0] add_result
);

assign add_result = E + F;

endmodule