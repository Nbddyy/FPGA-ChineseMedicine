module Iic_RW_Data 
#(
	parameter indx_max = 8'd31
)
(
	input clk,
	input rst_n,
	input write,
	input i2c_clk,
	input i2c_end,
	input rd_data,
	input read,
	input ack_4_flag,
	input flag,
	output reg wr_en,
	output reg rd_en,
	output reg i2c_start,
	output [15:0] byte_addr,
	output [7:0] wr_data,
	output reg [7:0] index
);


	//页写数据
	wire [7:0] page_program_datas [31:0];

	assign page_program_datas[0] = {8'h04};
	assign page_program_datas[1] = {8'h05};  
	assign page_program_datas[2] = {8'h06};
	assign page_program_datas[3] = {8'h07};
	assign page_program_datas[4] = {8'h08};
	assign page_program_datas[5] = {8'h09};
	assign page_program_datas[6] = {8'h10};
	assign page_program_datas[7] = {8'h11};
	assign page_program_datas[8] = {8'h12};
	assign page_program_datas[9] = {8'h13}; 
	assign page_program_datas[10] = {8'h14};
	assign page_program_datas[11] = {8'h15};  
	assign page_program_datas[12] = {8'h16};
	assign page_program_datas[13] = {8'h17};
	assign page_program_datas[14] = {8'h18};
	assign page_program_datas[15] = {8'h19};//4f   
	assign page_program_datas[16] = {8'h20};
	assign page_program_datas[17] = {8'h21};
	assign page_program_datas[18] = {8'h22};
	assign page_program_datas[19] = {8'h23};
	assign page_program_datas[20] = {8'h24};
	assign page_program_datas[21] = {8'h25};
	assign page_program_datas[22] = {8'h26};
	assign page_program_datas[23] = {8'h27};
	assign page_program_datas[24] = {8'h28}; 
	assign page_program_datas[25] = {8'h29}; 
	assign page_program_datas[26] = {8'h30};
	assign page_program_datas[27] = {8'h31}; 
	assign page_program_datas[28] = {8'h32}; 
	assign page_program_datas[29] = {8'h33};
	assign page_program_datas[30] = {8'h34};
	assign page_program_datas[31] = {8'h35};

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
		end else if(i2c_end || flag) begin
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

	/*index用来指示当前页写的数据*/
	always @(posedge i2c_clk or negedge rst_n) begin
		if(~rst_n) begin
			index <= 8'd0;
		end else if(index == indx_max) begin
			index <= indx_max;
		end else if(ack_4_flag) begin
			index <= index + 8'd1;
		end
	end

	/*page program
	output wr_data*/
	assign wr_data = page_program_datas[index];


endmodule