module D_FF (
	input clk,  
	input D,
	input rst_n,  
	output reg Q,
	output Q_NOT_GATE
);
	assign Q_NOT_GATE = ~Q;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			Q <= 0;
		end else begin
			Q <= D;
		end
	end

endmodule