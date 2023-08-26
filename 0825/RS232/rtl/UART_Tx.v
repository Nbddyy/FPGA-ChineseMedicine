module UART_Tx (
	input clk,
	input rst_n,
	input [7:0] ip_data,
	input ip_flag,
	output reg tx
);

	reg work_en;

	reg [15:0] baud_cnt;
	reg bit_flag;
	reg [3:0] bit_cnt;

	/*用于确定接收数据的使能信号*/ 
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(bit_cnt == 4'd9 && bit_flag) begin
			work_en <= 1'd0;
		end else if(ip_flag) begin
			work_en <= 1'd1;
		end else begin
			work_en <= work_en;
		end
	end

	/*用于计数每个波特所占周期*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			baud_cnt <= 16'd0;
		end else if(!work_en || baud_cnt == 16'd5207) begin
			baud_cnt <= 16'd0;
		end else begin
			baud_cnt <= baud_cnt + 16'd1;
		end
	end

	/*用于记录每个码元的取数标志*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_flag <= 1'd0;
		end else if(!work_en) begin
			bit_flag <= 1'd0;
		end else if(baud_cnt == 16'd98) begin
			bit_flag <= 1'd1;
		end else begin
			bit_flag <= 1'd0;
		end
	end

	/*用于记录当前读取的码元位置以及作为work_en的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_cnt <= 4'd0;
		end else if(!work_en || (bit_cnt == 4'd9 && bit_flag)) begin
			bit_cnt <= 4'd0;
		end else if(bit_flag) begin
			bit_cnt <= bit_cnt + 4'd1;
		end else begin
			bit_cnt <= bit_cnt;
		end
	end

	/*output tx*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			tx <= 1'd1;
		end else if(!work_en) begin 	//停止位和空闲状态由此赋值
			tx <= 1'd1;
		end else if(!bit_cnt && bit_flag) begin 	//起始位
			tx <= 1'd0;
		end else if(bit_flag) begin
			tx <= (bit_cnt != 4'd9) ? ip_data[bit_cnt - 1] : 1'd1;	//有效数据位和停止位赋值
		end else begin
			tx <= tx;
		end
	end

endmodule
