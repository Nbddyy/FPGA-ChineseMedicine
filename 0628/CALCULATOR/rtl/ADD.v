module ADD (
	input wire [7:0] A,
	input wire [7:0] B,
	output wire [8:0] add_result
);

assign add_result = A + B;

endmodule