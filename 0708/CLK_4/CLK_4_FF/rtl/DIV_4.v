module DIV_4 (
	input CLK,
	input RST_N,
	output reg Q
);

	always@(posedge CLK or negedge RST_N) begin
		if(!RST_N) begin
			Q <= 1'd0;
		end else begin
			Q <= ~Q;
		end
	end

endmodule