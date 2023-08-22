module VGA_Time (
	input clk,
	input rst_n,
	input [15:0] pix_data,
	output reg [9:0] pix_x,
	output reg [9:0] pix_y,
	output hsync,
	output vsync,
	output [15:0] rgb
);

	reg [9:0] cnt_h;	//用于记录行扫描周期
	reg [9:0] cnt_v;	//用于记录场扫描周期
	reg data_req;		//输出rgb获取的信号标识
	reg rgb_valid;		//查看输出rgb有效的信号预测

	/*cnt_h的0-799循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_h <= 10'd0;
		end else if(cnt_h == 10'd799) begin
			cnt_h <= 10'd0;
		end else begin
			cnt_h <= cnt_h + 10'd1;
		end
	end

	/*cnt_v的0-524的循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_v <= 10'd0;
		end else if(cnt_v == 10'd524 && cnt_h == 10'd799) begin
			cnt_v <= 10'd0;
		end else if(cnt_h == 10'd799) begin
			cnt_v <= cnt_v + 10'd1;
		end else begin
			cnt_v <= cnt_v;
		end
	end

	/*中间变量data_req作为输出rgb获取数据的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data_req <= 1'd0;
		end else if((cnt_h >= 142 && cnt_h <= 781) && (cnt_v >= 10'd35 && cnt_v <= 514)) begin
			data_req <= 1'd1;
		end else begin
			data_req <= 1'd0;
		end
	end

	/*中间变量rgb_valid作为输出预测信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rgb_valid <= 1'd0;
		end else if((cnt_h >= 143 && cnt_h <= 782) && (cnt_v >= 10'd35 && cnt_v <= 514)) begin
			rgb_valid <= 1'd1;
		end else begin
			rgb_valid <= 1'd0;
		end
	end

	/*output pix_x
	由于我们本次使用的是640*480@60的VGA配置，像素坐标点的值不能使用0，
	故初始化值定为10'h3ff即10'd1023，即超出对应的扫描周期即可*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_x <= 10'd0;
		end else if(pix_x == 10'd799) begin
			pix_x <= 10'd0;
		end else begin
			pix_x <= pix_x + 10'd1;
		end
	end

	/*output pix_y*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			pix_y <= 10'd0;
		end else if(pix_y == 10'd524 && pix_x == 10'd799) begin
			pix_y <= 10'd0;
		end else if(pix_x == 10'd799) begin
			pix_y <= pix_y + 10'd1;
		end else begin
			pix_y <= pix_y;
		end
	end

	/*output hsync*/
	assign hsync = (cnt_h >= 10'd0 && cnt_h <= 10'd95) ? 1'd1 : 1'd0;

	/*output vsync*/
	assign vsync = (cnt_v == 10'd0 || cnt_v == 10'd1) ? 1'd1 : 1'd0;

	/*output rgb*/
	assign rgb = (rgb_valid == 1'd1) ? pix_data : 16'd0;

endmodule