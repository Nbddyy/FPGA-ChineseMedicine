module VGA_Monitor_Data (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	parameter BLACK = 16'b11111_111111_11111;
	parameter BLUE = 16'b00000_000000_11111;
	parameter WHITE = 16'b00000_000000_00000;
	parameter GREEN = 16'b00000_111111_00000;

	/*output pix_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_y != 10'h3ff) begin
				if(pix_y < 10'd240) begin
					pix_data <= (pix_x < 10'd320) ? BLACK : BLUE;
				end else begin
					pix_data <= (pix_x < 10'd320) ? WHITE : GREEN;
				end
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule