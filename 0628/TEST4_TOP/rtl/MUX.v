module MUX (
	input wire [8:0] M1,
	input wire [8:0] M2,
	input wire [8:0] M3,
	input wire [7:0] SELECT,
	output wire [8:0] P
);

assign P = (SELECT == 2) ? M3 : (SELECT == 1) ? M2 : M1;

endmodule