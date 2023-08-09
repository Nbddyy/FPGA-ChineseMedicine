module D (
	input wire clk,
	input wire rst_n,
	output reg q
);

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			q <= 1'd0;
		end else begin
			q <= ~q;
		end
	end

endmodule