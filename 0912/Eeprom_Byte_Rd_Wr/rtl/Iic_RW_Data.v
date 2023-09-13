module Iic_RW_Data (
	input clk,
	input rst_n,
	input write,
	input i2c_clk,
	input i2c_end,
	input rd_data,
	input read,
	output reg wr_en,
	output reg rd_en,
	output reg i2c_start,
	output [15:0] byte_addr,
	output [7:0] wr_data
);

	reg write_latch;
	reg read_latch;

	/*将按键结果锁存几个clk*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			write_latch <= 1'd0;
		end else if(i2c_start) begin
			write_latch <= 1'd0;
		end else if(write) begin
			write_latch <= 1'd1;
		end else begin
			write_latch <= write_latch;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			read_latch <= 1'd0;
		end else if(i2c_start) begin
			read_latch <= 1'd0;
		end else if(read) begin
			read_latch <= 1'd1;
		end else begin
			read_latch <= read_latch;
		end
	end


	/*用来标识字节写操作的使能信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_en <= 1'd0;
		end else if(i2c_end) begin
			wr_en <= 1'd0;
		end else if(write) begin
			wr_en <= 1'd1;
		end else begin
			wr_en <= wr_en;
		end
	end

	/*用来标识字节读操作的使能信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_en <= 1'd0;
		end else if(i2c_end) begin
			rd_en <= 1'd0;
		end else if(read) begin
			rd_en <= 1'd1;
		end else begin
			rd_en <= rd_en;
		end
	end

	/*用来标识读写开始，提供主从之间的start周期*/
	always @(posedge i2c_clk or negedge rst_n) begin
		if(~rst_n) begin
			i2c_start <= 1'd0;
		end else if(write_latch || read_latch) begin
			i2c_start <= 1'd1;
		end else begin
			i2c_start <= 1'd0;
		end
	end

	/*读写操作的字节地址*/
	assign byte_addr = 16'h0123;

	/*单字节读测试*/
	assign wr_data = 8'h36;

endmodule