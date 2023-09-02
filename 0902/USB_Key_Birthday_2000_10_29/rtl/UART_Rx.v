module UART_Rx 
#(
	parameter baud_cnt_max = 12'd433
)
(
	input clk,
	input rst_n,
	input rx,
	output reg op_flag,
	output reg [7:0] op_data
);
	
	//对信号进行打拍避免稳定态的Tmet
	reg rx_clap_1;
	reg rx_clap_2;
	reg rx_clap_3;

	reg start_flag;
	reg work_en;

	reg [11:0] baud_cnt;
	reg bit_flag;	
	reg [3:0] bit_cnt;	//用于标识当前数据帧中数据位

	reg [7:0] rx_data;	//用来进行寄存移位操作
	reg rx_flag;

	/*clap logic*/
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

	/*检测到稳定后的数据帧起始位*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			start_flag <= 1'd0;
		end else if(!rx_clap_2 && rx_clap_3 && !work_en) begin
			start_flag <= 1'd1;
		end else begin
			start_flag <= 1'd0;
		end
	end

	/*开始对数据帧有效位进行寄存的操作*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(bit_flag && bit_cnt == 4'd8 && baud_cnt == (baud_cnt_max >> 1) + 12'd1) begin
			work_en <= 1'd0;
		end else if(start_flag) begin
			work_en <= 1'd1;
		end else begin
			work_en <= work_en;
		end
	end

	/*baud_cnt用于记录每个波特所占的周期*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			baud_cnt <= 12'd0;
		end else if(baud_cnt == baud_cnt_max || !work_en) begin
			baud_cnt <= 12'd0;
		end else if(work_en) begin
			baud_cnt <= baud_cnt + 12'd1;
		end else begin
			baud_cnt <= 12'd0;
		end
	end

	/*bit_flag用来标识可以进行移位操作的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_flag <= 1'd0;
		end else if(work_en && baud_cnt == baud_cnt_max >> 1) begin
			bit_flag <= 1'd1;
		end else begin
			bit_flag <= 1'd0;
		end
	end

	/*bit_cnt用来记录当前处理数据帧的位置*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_cnt <= 4'd0;
		end else if(!work_en) begin
			bit_cnt <= 4'd0;
		end else if(bit_flag) begin
			bit_cnt <= bit_cnt + 4'd1;
		end else begin
			bit_cnt <= bit_cnt;
		end
	end

	/*rx_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_data <= 8'd0;
		end else if(bit_flag && (bit_cnt >= 4'd1 || bit_cnt <= 4'd8)) begin
			rx_data <= {rx_clap_3,rx_data[7:1]};
		end else begin
			rx_data <= rx_data;
		end
	end

	/*rx_flag用于输出的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx_flag <= 1'd0;
		end else if(bit_flag && bit_cnt == 4'd8) begin
			rx_flag <= 1'd1;
		end else begin
			rx_flag <= 1'd0;
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

	/*output op_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_data <= 8'd0;
		end else if(rx_flag) begin
			op_data <= rx_data;
		end else begin
			op_data <= op_data;
		end
	end

endmodule