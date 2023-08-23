module VGA_Image (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	/*定义横向十种颜色的编码*/
	parameter RED = 16'b11111_000000_00000;
	parameter ORANGE = 16'b11111_101000_00000;
	parameter YELLOW = 16'b11111_111000_00000;
	parameter GREEN = 16'b00000_111111_00000;
	parameter CYAN = 16'b00000_111111_11111;
	parameter BLUE = 16'b00000_000000_11111;
	parameter PURPLE = 16'b11111_000000_11111;
	parameter BLACK = 16'b00000_000000_00000;
	parameter WHITE = 16'b11111_111111_11111;
	parameter GRAY = 16'b01111_011111_01111;

	/*定义每个颜色所占的场扫描周期*/
	parameter period = 10'd48;	//(480 / 10 = 48)

	/*output pix_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_y != 10'h3ff) begin
				if((pix_y == 10'd190 || pix_y == 10'd290) && (pix_x >= 10'd269 && pix_x <= 10'd369)) begin 	//白框横向实现
					pix_data <= WHITE;
				end else if((pix_y >= 10'd190 && pix_y <= 10'd290) && (pix_x == 10'd269 || pix_x == 10'd369)) begin 	//白框纵向实现
					pix_data <= WHITE;
				end else if(pix_y <= 47) begin
					pix_data <= (pix_x != 10'h3ff) ? RED : 16'd0;
				end else if(pix_y <= 47 + period) begin
					pix_data <= (pix_x != 10'h3ff) ? ORANGE : 16'd0;
				end else if(pix_y <= 47 + 2*period) begin
					pix_data <= (pix_x != 10'h3ff) ? YELLOW : 16'd0;
				end else if(pix_y <= 47 + 3*period) begin
					pix_data <= (pix_x != 10'h3ff) ? GREEN : 16'd0;
				end else if(pix_y <= 47 + 4*period) begin
					pix_data <= (pix_x != 10'h3ff) ? CYAN : 16'd0;
				end else if(pix_y <= 47 + 5*period) begin
					pix_data <= (pix_x != 10'h3ff) ? BLUE : 16'd0;
				end else if(pix_y <= 47 + 6*period) begin
					pix_data <= (pix_x != 10'h3ff) ? PURPLE : 16'd0;
				end else if(pix_y <= 47 + 7*period) begin
					pix_data <= (pix_x != 10'h3ff) ? BLACK : 16'd0;
				end else if(pix_y <= 47 + 8*period) begin
					pix_data <= (pix_x != 10'h3ff) ? WHITE : 16'd0;
				end else if(pix_y <= 47 + 9*period) begin
					pix_data <= (pix_x != 10'h3ff) ? GRAY : 16'd0;
				end else begin
					pix_data <= 16'd0;
				end
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule
