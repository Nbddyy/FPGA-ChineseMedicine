module FF (
	input wire D,
	input wire CLK,
	input wire RST,
	output reg Q,
	output wire Q_NOT_GATE
);

assign Q_NOT_GATE = ~Q;

always@(posedge CLK or negedge RST) begin
	if(!RST) begin
		Q <= 0;
	end else begin
		Q <= D;
	end

end

endmodule