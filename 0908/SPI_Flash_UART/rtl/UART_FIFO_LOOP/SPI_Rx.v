module SPI_Rx 
#(
	parameter baud_cnt_max = 24'd5207,
	parameter cnt_max = 8'd148
)
(
	input clk,
	input rst_n,
	input rx,
	output reg [7:0] op_data,
	output reg op_flag
);

	//定义三次打拍的变量
	reg rx_clap_1;
	reg rx_clap_2;
	reg rx_clap_3;

	reg start_flag;	//信号稳定开始receive的标志信号
	reg work_en;	//每个波特周期计数的使能信号

	reg [3:0] bit_cnt;	//用于记录当前读取到数据帧的哪一位

	reg [7:0] rx_data;	//移位操作的数据
	reg rx_flag;	//移位完成的标志信号

	reg [7:0] cnt;

	//对输入信号打拍，避免亚稳态的不稳定
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_clap_1 <= 1'd1;
			rx_clap_2 <= 1'd1;
			rx_clap_3 <= 1'd1;
		end else begin
			rx_clap_1 <= rx;
			rx_clap_2 <= rx_clap_1;
			rx_clap_3 <= rx_clap_2;
		end
	end

	/*只检测一轮miso输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			start_flag <= 1'd0;
		end else if(cnt == 8'd0 && (!rx_clap_1 && rx_clap_2)) begin
			start_flag <= 1'd1;
		end else begin
			start_flag <= 1'd0;
		end
	end

	/*取数的使能信号
	注意：如果信号本身需要保持，则避免使用组合逻辑*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(cnt == cnt_max && bit_cnt == 4'd8) begin
			work_en <= 1'd0;
		end else if(cnt == 8'd0 && (!rx_clap_1 && rx_clap_2)) begin
			work_en <= 1'd1;
		end else begin
			work_en <= work_en;
		end
	end

	/*计数bit_cnt用来对输入的spi_miso进行移位拼接*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_cnt <= 4'd0;
		end else if(!work_en) begin
			bit_cnt <= 4'd0;
		end else if(bit_cnt == 4'd8) begin
			bit_cnt <= 4'd1;
		end else begin
			bit_cnt <= bit_cnt + 4'd1;
		end
	end

	/*拼接8个二进制的数据*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_data <= 8'd0;
		end else if(work_en && bit_cnt) begin
			rx_data <= {rx_data[7:0],rx_clap_3};
		end
	end

	/*temp rx_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_flag <= 1'd0;
		end else if(bit_cnt == 4'd8) begin
			rx_flag <= 1'd1;
		end else begin
			rx_flag <= 1'd0;
		end
	end

	/*用来记录数据个数，作为work_en拉低的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(start_flag) begin
			cnt <= 8'd1;
		end else if(rx_flag && cnt != cnt_max) begin
			cnt <= cnt + 8'd1;
		end else begin
			cnt <= cnt;
		end
	end

	/*output op_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_data <= 8'h00;
		end else if(rx_flag) begin
			op_data <= rx_data;
		end else begin
			op_data <= op_data;
		end
	end

	/*output op_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_flag <= 1'd0;
		end else if(rx_flag) begin
			op_flag <= 1'd1;
		end else begin
			op_flag <= 1'd0;
		end
	end

endmodule