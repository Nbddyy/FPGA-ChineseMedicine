module SUB (
	input wire [7:0] C,
	input wire [7:0] D,
	output wire [8:0] sub_result
);

assign sub_result = C - D;

endmodule