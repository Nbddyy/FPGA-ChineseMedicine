module FF (
	input clk,  
	input rst_n,  
	output reg Q
);

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			Q <= 0;
		end else begin
			Q <= ~Q;
		end
	end

endmodule