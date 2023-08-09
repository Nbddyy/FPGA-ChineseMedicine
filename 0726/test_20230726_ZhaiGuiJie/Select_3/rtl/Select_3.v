module Select_3 (
	input clk,
	input rst_n,
	input a,
	input b,
	input c,
	output out
);

	assign out = a&b || a&c || b&c || a&b&c;

endmodule : 