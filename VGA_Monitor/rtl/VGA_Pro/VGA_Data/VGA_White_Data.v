module VGA_White_Data (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	parameter WHITE = 16'b11111_111111_11111;

	/*output pix_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_y != 10'h3ff) begin
				pix_data <= (pix_x != 10'h3ff) ? WHITE : 16'd0;
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule