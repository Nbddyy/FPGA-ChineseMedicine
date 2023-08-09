module ADD (
	input wire [7:0] C,
	input wire [7:0] D,
	output wire [8:0] add_result	
);

assign add_result = C + D;

endmodule