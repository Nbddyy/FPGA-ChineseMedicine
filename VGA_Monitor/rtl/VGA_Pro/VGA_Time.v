module VGA_Time (
	input clk,
	input rst_n,
	input [15:0] pix_data,
	output [9:0] pix_x,
	output [9:0] pix_y,
	output hsync,
	output vsync,
	output [15:0] rgb 
);

	parameter cnt_h_max = 10'd799;
	parameter cnt_v_max = 10'd524;

	reg [9:0] cnt_h;	//用于记录行扫描周期
	reg [9:0] cnt_v;	//用于记录场扫描周期
	wire data_req;		//用于输出pix_x和pix_y
	wire rgb_valid;		//用于判断是否获取数据

	/*Intermediate variable cnt_h*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_h <= 10'd0;
		end else if(cnt_h == cnt_h_max) begin
			cnt_h <= 10'd0;
		end else begin
			cnt_h <= cnt_h + 10'd1;
		end
	end

	/*Intermediate variable cnt_v*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_v <= 10'd0;
		end else if(cnt_v == cnt_v_max && cnt_h == cnt_h_max) begin
			cnt_v <= 10'd0;
		end else if(cnt_h == cnt_h_max) begin
			cnt_v <= cnt_v + 10'd1;
		end else begin
			cnt_v <= cnt_v;
		end
	end

	/*data_req作为输出pix_x和pix_y的有效标识*/
	assign data_req = ((cnt_v >= 10'd35 && cnt_v <= 10'd514) && (cnt_h >= 10'd143 && cnt_h <= 10'd782)) ? 1'd1 : 1'd0;

	/*rgb_valid作为输出rgb的取数标识*/
	assign rgb_valid = ((cnt_v >= 10'd35 && cnt_v <= 10'd514) && (cnt_h >= 10'd144 && cnt_h <= 10'd783)) ? 1'd1 : 1'd0;

	/*output pix_x*/
	assign pix_x = (data_req) ? (cnt_h - 10'd143) : 10'h3ff;

	/*output pix_y*/
	assign pix_y = (cnt_v >= 10'd35 && cnt_v <= 514) ? (cnt_v - 10'd35) : 10'h3ff;

	/*output hsync*/
	assign hsync = (cnt_h >= 10'd0 && cnt_h <= 10'd95) ? 1'd1 : 1'd0;

	/*output vsync*/
	assign vsync = (cnt_v == 10'd0 || cnt_v == 10'd1) ? 1'd1 : 1'd0;

	/*output rgb*/
	assign rgb = (rgb_valid) ? pix_data : 16'd0;

endmodule