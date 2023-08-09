module EIGHT_INTO_ONE (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	input wire [7:0] E,
	input wire [7:0] F,
	input wire [7:0] G,
	input wire [7:0] H,
	input wire [2:0] SEL,
	output reg [7:0] P
);

always@(*)
begin
	case(SEL)
		3'd0: P = A;
		3'd1: P = B;
		3'd2: P = C;
		3'd3: P = D;
		3'd4: P = E;
		3'd5: P = F;
		3'd6: P = G;
		3'd7: P = H;
	endcase
end

endmodule