module MULT (
	input wire [8:0] add_result,
	input wire [8:0] div_result,
	input wire [8:0] sub_result,
	output wire [26:0] P
);

assign P = add_result * div_result * sub_result;

endmodule