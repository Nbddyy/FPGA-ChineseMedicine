module DIV (
	input wire [7:0] A,
	input wire [7:0] B,
	output wire [8:0] div_result
);

assign div_result = A / B;

endmodule