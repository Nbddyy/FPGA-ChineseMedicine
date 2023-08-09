module DIV_4 (
	input CLK,
	input RST_N,
	input D,
	output Q_NOT_GATE,
	output reg Q
);

	assign Q_NOT_GATE = ~Q;
	always@(posedge CLK or negedge RST_N) begin
		if(!RST_N) begin
			Q <= 1'd0;
		end else begin
			Q <= D;
		end
	end

endmodule