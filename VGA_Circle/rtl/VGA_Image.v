module VGA_Image (
	input clk,
	input rst_n,
	input [9:0] pix_x,
	input [9:0] pix_y,
	output reg [15:0] pix_data
);

	/*本次纯色使用护眼绿RGB(204,232,207)，24'b11001100_11101000_11001111*/
	parameter EyeGreen = 16'b11001_111010_11001;

	/*output pix_data
	圆的圆心坐标为(320,240)，圆的半径为100*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_data <= 16'd0;
		end else begin
			if(pix_x != 10'h3ff) begin
				pix_data <= ((pix_x - 10'd320) * (pix_x - 10'd320) + (pix_y - 10'd240) * (pix_y - 10'd240) <= 10000) ? EyeGreen : 16'd0;
			end else begin
				pix_data <= 16'd0;
			end
		end
	end

endmodule