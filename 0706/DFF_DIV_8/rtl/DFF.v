module D_FF (
	input wire clk,
	input wire rst_n,
	input wire D,
	output reg Q,
	output wire Q_NOT_GATE
);

	assign Q_NOT_GATE = ~Q;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			Q <= 1'd0;
		end else begin
			Q <= D;
		end
	end


endmodule