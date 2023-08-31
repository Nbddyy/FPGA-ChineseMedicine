module UART_Rx 
#(
	parameter baud_cnt_max = 24'd5207
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

	reg [15:0] baud_cnt;	//每个波特所占的周期计数

	reg bit_flag;	//数据帧中每比特数据稳定后可以取数的标志
	reg [3:0] bit_cnt;	//用于记录当前读取到数据帧的哪一位

	reg [7:0] rx_data;	//移位操作的数据
	reg rx_flag;	//移位完成的标志信号

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

	/*通过三次打拍后信号稳定的数据帧接收标志*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			start_flag <= 1'd0;
		end else if(work_en != 1'd1 && rx_clap_2 == 1'd0 && rx_clap_3 == 1'd1) begin
			start_flag <= 1'd1;
		end else begin
			start_flag <= 1'd0;
		end
	end

	/*开始对串行数据进行并行统计的使能信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(start_flag == 1'd1) begin
			work_en <= 1'd1;
		end else if(bit_cnt == 4'd8 && bit_flag) begin
			work_en <= 1'd0;
		end else begin
			work_en <= work_en;
		end
	end

	/*baud在使能信号下的计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			baud_cnt <= 16'd0;
		end else if(!work_en || baud_cnt == baud_cnt_max) begin
			baud_cnt <= 16'd0;
		end else begin
			baud_cnt <= baud_cnt + 16'd1;
		end
	end

	/*bit_flag用于移位标志，当计数到一半时拉高，确保信号稳定*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_flag <= 1'd0;
		end else if(work_en && baud_cnt == baud_cnt_max >> 1) begin
			bit_flag <= 1'd1;
		end else begin
			bit_flag <= 1'd0;
		end
	end

	/*bit_flag用于记录当前接收到哪一位*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_cnt <= 4'd0;
		end else if(!work_en || (bit_cnt == 4'd8 && bit_flag))begin
			bit_cnt <= 4'd0;
		end else if(bit_flag) begin
			bit_cnt <= bit_cnt + 4'd1;
		end else begin
			bit_cnt <= bit_cnt;
		end
	end

	/*rx_data用于寄存移位操作的结果*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_data <= 8'h00;
		end else if(bit_cnt && bit_flag) begin
			rx_data <= {rx_clap_3,rx_data[7:1]};
		end else begin
			rx_data <= rx_data;
		end
	end

	/*rx_flag用于结果取数的标志信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_flag <= 1'd0;
		end else if(bit_cnt == 4'd8 && bit_flag) begin
			rx_flag <= 1'd1;
		end else begin
			rx_flag <= 1'd0;
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