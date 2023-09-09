module UART_Tx 
#(
	parameter baud_cnt_max = 16'd433
)
(
	input clk,
	input rst_n,
	input [7:0] ip_data,
	input ip_flag,
	output reg tx_flag,
	output reg tx
);

	reg work_en;

	reg [15:0] baud_cnt;
	reg bit_flag;
	reg [3:0] bit_cnt;

	//定义四种状态用来表示该模块处于什么状态
	reg [3:0] state;

	reg [7:0] ip_data_latch;

	parameter IDLE = 4'b0001;
	parameter HEAD = 4'b0010;
	parameter DATA = 4'b0100;
	parameter TAIL = 4'b1000;

	/*将ip_data进行寄存*/
	always @(*) begin
		if(~rst_n) begin
			ip_data_latch <= 8'd0;
		end else if(ip_flag) begin
			ip_data_latch <= ip_data;
		end else begin
			ip_data_latch <= ip_data_latch;
		end
	end

	/*用于确定接收数据的使能信号*/ 
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(bit_cnt == 4'd10 && bit_flag) begin
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
		end else if(!work_en || baud_cnt == baud_cnt_max) begin
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
		end else if(!work_en || (bit_cnt == 4'd10 && bit_flag)) begin
			bit_cnt <= 4'd0;
		end else if(bit_flag) begin
			bit_cnt <= bit_cnt + 4'd1;
		end else begin
			bit_cnt <= bit_cnt;
		end
	end

	/*state transition logic*/
	always @(*) begin
		if(~rst_n) begin
			state = IDLE;
		end else begin
			case(state)
				IDLE : state = (bit_cnt) ? HEAD : IDLE;
				HEAD : state = (bit_cnt == 4'd2) ? DATA : HEAD;
				DATA : state = (bit_cnt == 4'd10) ? TAIL : DATA;
				TAIL : state = (!bit_cnt) ? IDLE : TAIL;
				default : state = IDLE;
			endcase
		end
	end

	/*output tx_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			tx_flag <= 1'd0;
		end else if(state == TAIL && baud_cnt == 16'd99) begin
			tx_flag <= 1'd1;
		end else begin
			tx_flag <= 1'd0;
		end
	end

	/*output tx*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			tx <= 1'd1;
		end else begin
			case(state) 
				IDLE : tx <= tx;
				HEAD : tx <= 1'd0;	//起始位固定为0
				DATA : tx <= ip_data_latch[bit_cnt - 2];
				TAIL : tx <= 1'd1;	//停止位固定为1
				default : tx <= 1'd0;
			endcase
		end
	end

endmodule