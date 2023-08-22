module VGA_Image (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	/*output pix_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_y >= 10'd35 && pix_y <= 10'd514) begin
				if(pix_x >= 10'd143 && pix_x <= 10'd206) begin
					pix_data <= 16'b11111_000000_00000;	//RED
				end else if(pix_x >= 10'd207 && pix_x <= 10'd270) begin
					pix_data <= 16'b11111_101000_00000;	//ORANGE
				end else if(pix_x >= 10'd271 && pix_x <= 10'd334) begin
					pix_data <= 16'b11111_111000_00000;	//YELLOW
				end else if(pix_x >= 10'd335 && pix_x <= 10'd398) begin
					pix_data <= 16'b00000_111111_00000;	//GREEN
				end else if(pix_x >= 10'd399 && pix_x <= 10'd462) begin
					pix_data <= 16'b00000_111111_11111;	//CYAN
				end else if(pix_x >= 10'd463 && pix_x <= 10'd526) begin
					pix_data <= 16'b00000_000000_11111;	//BLUE
				end else if(pix_x >= 10'd527 && pix_x <= 10'd590) begin
					pix_data <= 16'b11111_000000_11111;	//PURPLE
				end else if(pix_x >= 10'd591 && pix_x <= 10'd654) begin
					pix_data <= 16'b00000_000000_00000;	//BLACK
				end else if(pix_x >= 10'd655 && pix_x <= 10'd718) begin
					pix_data <= 16'b11111_111111_11111;	//WHITE
				end else if(pix_x >= 10'd719 && pix_x <= 10'd782) begin
					pix_data <= 16'b01111_011111_01111;	//GRAY
				end else begin
					pix_data <= 16'd0;
				end
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule