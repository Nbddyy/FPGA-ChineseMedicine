module Iic_Ctrl 
#(
	parameter cnt_clk_max = 8'd24,
	parameter device_addr_write = 8'b1010_0110,
	parameter device_addr_read = 8'b1010_0111,
	parameter index_max = 8'd31
)
(
	input clk,
	input rst_n,
	input wr_en,
	input rd_en,
	input i2c_start,
	input addr_num,		//0代表1字节，1代表2两字节
	input [15:0] byte_addr,
	input [7:0] wr_data,
	input [7:0] index,
	output reg i2c_clk,
	output reg i2c_end,
	output reg [7:0] rd_data,
	output reg i2c_scl,
	inout wire i2c_sda,
	output reg ack_4_flag	//用来标识页写数据更换
);

	//定义存在的几种状态（使用十进制）
	parameter IDLE = 4'd0;
	parameter START_1 = 4'd1;
	parameter SEND_D_ADDR = 4'd2;
	parameter ACK_1 = 4'd3;
	parameter SEND_B_ADDR_H = 4'd4;
	parameter ACK_2 = 4'd5;
	parameter SEND_B_ADDR_L = 4'd6;
	parameter ACK_3 = 4'd7;
	parameter WR_DATA = 4'd8;
	parameter ACK_4 = 4'd9;
	parameter START_2 = 4'd10;
	parameter SEND_RD_ADDR = 4'd11;
	parameter ACK_5 = 4'd12;
	parameter RD_DATA = 4'd13;
	parameter N_ACK = 4'd14;
	parameter STOP = 4'd15;


	reg [7:0] cnt_clk;
	reg cnt_i2c_clk_en;
	reg [1:0] cnt_i2c_clk;
	reg [2:0] cnt_bit;
	reg [3:0] state;
	reg ack;
	reg i2c_sda_reg;
	reg [7:0] rd_data_reg;
	wire sda_in;
	reg sda_en;

	/*0-74循环计数，用于得到小于400KHz的频率*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_clk <= 8'd0;
		end else if(cnt_clk == cnt_clk_max) begin
			cnt_clk <= 8'd0;
		end else begin
			cnt_clk <= cnt_clk + 8'd1;
		end
 	end

 	/*cnt_i2c_clk计数的使能信号*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			cnt_i2c_clk_en <= 1'd0;
 		end else if(state ==STOP && cnt_bit == 3'd3 && cnt_i2c_clk == 2'd3) begin
 			cnt_i2c_clk_en <= 1'd0;
 		end else if(i2c_start) begin
 			cnt_i2c_clk_en <= 1'd1;
 		end else begin
 			cnt_i2c_clk_en <= cnt_i2c_clk_en;
 		end
 	end

 	/*temp cnt_i2c_clk*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			cnt_i2c_clk <= 2'd0;
 		end else if(cnt_i2c_clk_en) begin
 			cnt_i2c_clk <= cnt_i2c_clk + 2'd1;
 		end else begin
 			cnt_i2c_clk <= 2'd0;
 		end
 	end

 	/*temp cnt_bit用来标识数据的当前位数*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			cnt_bit <= 3'd0;
 		end else begin
 			case(state) 
 				IDLE : cnt_bit <= 3'd0;
 				START_1 : cnt_bit <= 3'd0;
 				SEND_D_ADDR : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				ACK_1 : cnt_bit <= 3'd0;
 				SEND_B_ADDR_H : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				ACK_2 : cnt_bit <= 3'd0;
 				SEND_B_ADDR_L : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				ACK_3 : cnt_bit <= 3'd0;
 				WR_DATA : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				ACK_4 : cnt_bit <= 3'd0;

 				START_2 : cnt_bit <= 3'd0;
 				SEND_RD_ADDR : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				ACK_5 : cnt_bit <= 3'd0;
 				RD_DATA : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				N_ACK : cnt_bit <= 3'd0;

 				STOP : cnt_bit <= (cnt_i2c_clk == 2'd3) ? cnt_bit + 3'd1 : cnt_bit;
 				default : cnt_bit <= 3'd0;
 			endcase
 		end
 	end

 	/*state transition logic*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			state <= IDLE;
 		end else begin
 			case(state)
 				IDLE : state <= (i2c_start) ? START_1 : state;
 				START_1 : state <= (cnt_i2c_clk == 2'd3) ? SEND_D_ADDR : state;
 				SEND_D_ADDR : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? ACK_1 : state;
 				
 				ACK_1 : begin
 					if(ack == 1'd0 && cnt_i2c_clk == 2'd3) begin
 						if(addr_num) begin
 							state <= SEND_B_ADDR_H; 
 						end else begin
 							state <= SEND_B_ADDR_L;
 						end
 					end else begin
 						state <= state;
 					end
 				end 

 				SEND_B_ADDR_H : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? ACK_2 : state;
 				ACK_2 : state <= (ack == 1'd0 && cnt_i2c_clk == 2'd3) ? SEND_B_ADDR_L : state;
 				SEND_B_ADDR_L : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? ACK_3 : state;
 				
 				ACK_3 : begin
 					if(ack == 1'd0 && cnt_i2c_clk == 2'd3 && wr_en) begin
 						state <= WR_DATA;
 					end else if(ack == 1'd0 && cnt_i2c_clk == 2'd3 && rd_en) begin
 						state <= START_2;
 					end else begin
 						state <= state;
 					end
 				end 

 				WR_DATA : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? ACK_4 : state;
 				
 				ACK_4 : begin
 					if(ack == 1'd0 && cnt_i2c_clk == 2'd3 && wr_en && index != index_max) begin
 						state <= WR_DATA;
 					end else if(ack == 1'd0 && cnt_i2c_clk == 2'd3) begin
 						state <= STOP;
 					end else begin
 						state <= state;
 					end 					
 				end

 				START_2 : state <= (cnt_i2c_clk == 2'd3) ? SEND_RD_ADDR : state;
 				SEND_RD_ADDR : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? ACK_5 : state;
 				ACK_5 : state <= (ack == 1'd0 && cnt_i2c_clk == 2'd3) ? RD_DATA : state;
 				RD_DATA : state <= (cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) ? N_ACK : state;
 				N_ACK : begin
 					if(ack == 1'd0 && cnt_i2c_clk == 2'd3 && rd_en) begin
 						state <= RD_DATA;
 					end else if(ack == 1'd1 && cnt_i2c_clk == 2'd3) begin
 						state <= STOP;
 					end else begin
 						state <= state;
 					end 
 				end

 				STOP : state <= (cnt_bit == 3'd3 && cnt_i2c_clk == 2'd3) ? IDLE : STOP;

 				default : state <= IDLE;
 			endcase
 		end
 	end

 	/*temp ack用来记录应答*/
 	always@(*) begin
 		if(!rst_n) begin
 			ack = 1'd1;
 		end else begin
 			case(state) 
 				IDLE : ack = 1'd1;
 				ACK_1 : ack = (cnt_i2c_clk == 2'd0) ? sda_in : ack;
 				ACK_2 : ack = (cnt_i2c_clk == 2'd0) ? sda_in : ack;
 				ACK_3 : ack = (cnt_i2c_clk == 2'd0) ? sda_in : ack;
 				ACK_4 : ack = (cnt_i2c_clk == 2'd0) ? sda_in : ack;
 				ACK_5 : ack = (cnt_i2c_clk == 2'd0) ? sda_in : ack;
 				N_ACK : ack = (rd_en) ? 1'd0 : 1'd1;
 				default : ack = 1'd1;
 			endcase

 			/*testbench*/
 			// ack = 1'd0;
 		end
 	end

 	/*temp i2c_sda_reg*/
 	always @(*) begin
 		if(!rst_n) begin
 			i2c_sda_reg = 1'd1;
 		end else begin
 			case(state)
 				IDLE : i2c_sda_reg = 1'd1;
 				START_1 : i2c_sda_reg = (cnt_i2c_clk) ? 1'd0 : 1'd1;
 				SEND_D_ADDR : i2c_sda_reg = device_addr_write[7 - cnt_bit];
 				ACK_1 : i2c_sda_reg = 1'd1;
 				SEND_B_ADDR_H : i2c_sda_reg = byte_addr[15 - cnt_bit];
 				ACK_2 : i2c_sda_reg = 1'd1;
 				SEND_B_ADDR_L : i2c_sda_reg = byte_addr[7 - cnt_bit];
 				ACK_3 : i2c_sda_reg = 1'd1;
 				WR_DATA : i2c_sda_reg = wr_data[7 - cnt_bit];
 				ACK_4 : i2c_sda_reg = 1'd1;

 				START_2 : i2c_sda_reg = (cnt_i2c_clk == 2'd2 || cnt_i2c_clk == 2'd3) ? 1'd0 : 1'd1;
 				SEND_RD_ADDR : i2c_sda_reg = device_addr_read[7 - cnt_bit];
 				ACK_5 : i2c_sda_reg = 1'd1;
 				RD_DATA : i2c_sda_reg = 1'd1;
 				N_ACK : i2c_sda_reg = (rd_en) ? 1'd0 : 1'd1;

 				STOP : begin
 					if(cnt_bit == 3'd0 && (cnt_i2c_clk <= 2'd2)) begin
 						i2c_sda_reg = 1'd0;
 					end else begin
 						i2c_sda_reg = 1'd1;
 					end
 				end 
 				
 				default : i2c_sda_reg = 1'd1;
 			endcase
 		end
 	end

 	/*用来将从机读取的二进制拼接成8位寄存起来*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			rd_data_reg <= 8'd0;
 		end else begin
 			case(state)
 				RD_DATA : rd_data_reg <= (cnt_i2c_clk == 2'd1) ? {rd_data_reg[7:0],i2c_sda} : rd_data_reg;
 				default : rd_data_reg <= rd_data_reg;
 			endcase
 		end
 	end

 	/*temp sda_in
 	输入数据寄存*/
 	assign sda_in = i2c_sda;

 	/*用来标识i2c_sda的情况：
 	1：主机输出二进制至从机
 	2：主机接收从机二进制*/
 	always@(*) begin
 		if(!rst_n) begin
 			sda_en = 1'd1;
 		end else begin
 			case(state) 
 				IDLE : sda_en = 1'd1;
 				ACK_1 : sda_en = 1'd0;
 				ACK_2 : sda_en = 1'd0;
 				ACK_3 : sda_en = 1'd0;
 				ACK_4 : sda_en = 1'd0;
 				ACK_5 : sda_en = 1'd0;
 				RD_DATA : sda_en = 1'd0;
 				default : sda_en = 1'd1;
 			endcase
 		end
 	end

 	/*output i2c_scl*/
 	always @(posedge clk or negedge rst_n) begin
 		if(~rst_n) begin
 			i2c_clk <= 1'd0;
 		end else if(cnt_clk == cnt_clk_max) begin
 			i2c_clk <= !i2c_clk;
 		end else begin
 			i2c_clk <= i2c_clk;
 		end
 	end

 	/*output i2c_end*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			i2c_end <= 1'd0;
 		end else if(state == STOP && cnt_bit == 3'd3 && cnt_i2c_clk == 2'd3) begin
 			i2c_end <= 1'd1;
 		end else begin
 			i2c_end <= 1'd0;
 		end
 	end

 	/*output rd_data*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			rd_data <= 8'd0;
 		end else if(state == RD_DATA && cnt_bit == 3'd7 && cnt_i2c_clk == 2'd3) begin
 			rd_data <= rd_data_reg;
 		end else begin
 			rd_data <= rd_data;
 		end
 	end

 	/*output i2c_scl*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			i2c_scl <= 1'd1;
 		end else if(state == IDLE || state == STOP) begin
 			i2c_scl <= 1'd1;
 		end else if(state == START_1 && cnt_i2c_clk == 2'd0) begin
			i2c_scl <= i2c_scl;
 		end else if(state != IDLE && (cnt_i2c_clk == 2'd0 || cnt_i2c_clk == 2'd2)) begin
 			i2c_scl <= !i2c_scl;
 		end else begin
 			i2c_scl <= i2c_scl;
 		end
 	end

 	assign i2c_sda = (sda_en == 1'b1) ? i2c_sda_reg : 1'bz;

 	/*output ack_4_flag*/
 	always @(posedge i2c_clk or negedge rst_n) begin
 		if(~rst_n) begin
 			ack_4_flag <= 1'd0;
 		end else begin
 			case(state) 
 				ACK_4 : ack_4_flag <= (cnt_i2c_clk == 2'd0) ? 1'd1 : 1'd0;
 				default : ack_4_flag <= 1'd0;
 			endcase
 		end
 	end

endmodule