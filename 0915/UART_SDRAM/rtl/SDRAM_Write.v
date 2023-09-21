module SDRAM_Write 
#(
	parameter cnt_trcd_max = 4'd3,
	parameter cnt_trp_max = 4'd2
)
(
	input clk,
	input rst_n,
	input init_end,
	input wr_en,
	input [23:0] wr_addr,
	input [15:0] wr_data,
	input [9:0] wr_burst_len,
	output wr_end,
	output reg [3:0] wr_cmd,
	output reg [1:0] wr_ban,
	output reg [12:0] wr_sdram_addr,
	output reg wr_sdram_en,
	output [15:0] wr_sdram_data,
	output wr_ack
);

	//定义Write模块下存在的几种状态
	parameter IDLE = 8'b0000_0001;
	parameter ACTIVE = 8'b0000_0010;
	parameter TRCD = 8'b0000_0100;
	parameter WRITE = 8'b0000_1000;
	parameter TERM = 8'b0001_0000;
	parameter PRE = 8'b0010_0000;
	parameter TRP = 8'b0100_0000;
	parameter END = 8'b1000_0000;

	//定义几种状态下的四位指令Data
	parameter ACTIVE_CMD = 4'b0011;
	parameter NOP_CMD = 4'b0111;
	parameter WRITE_CMD = 4'b0100;
	parameter TERM_CMD = 4'b0110;
	parameter PRE_CMD =  4'b0010;

	reg [7:0] wr_state;
	reg cnt_time_rst;
	reg [3:0] cnt_time;
	reg [15:0] cnt_wr;

	/*wr_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_state <= IDLE;
		end else begin
			case(wr_state) 
				IDLE : wr_state <= (wr_en && init_end) ? ACTIVE : IDLE;
				ACTIVE : wr_state <= TRCD;
				TRCD : wr_state <= (cnt_time == cnt_trcd_max) ? WRITE : wr_state;
				WRITE : wr_state <= (cnt_wr == wr_burst_len) ? TERM : wr_state;
				TERM : wr_state <= PRE;
				PRE : wr_state <= TRP;
				TRP : wr_state <= (cnt_time == cnt_trp_max) ? END : wr_state;
				END : wr_state <= IDLE;
				default : wr_state <= IDLE;
			endcase
		end
	end

	/*用于标识cnt_time清零的temp信号*/
	always @(*) begin
		case(wr_state)
			ACTIVE : cnt_time_rst <= 1'd0;
			TRCD : cnt_time_rst <= (cnt_time < cnt_trcd_max) ? 1'd0 : 1'd1;
			PRE : cnt_time_rst <= 1'd0;
			TRP : cnt_time_rst <= (cnt_time < cnt_trp_max) ? 1'd0 : 1'd1;
			default : cnt_time_rst <= 1'd1;
		endcase
	end

	/*temp cnt_time用于记录对应command执行等待时间周期计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_time <= 4'd0;
		end else if(cnt_time_rst) begin
			cnt_time <= 4'd0;
		end else begin
			cnt_time <= cnt_time + 4'd1;
		end
	end

	/*cnt_wr用于记录该次写入的数据个数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_wr <= 16'd0;
		end else if(cnt_wr == wr_burst_len) begin
			cnt_wr <= 16'd0;
		end else begin
			case(wr_state)
				TRCD : cnt_wr <= (cnt_time == cnt_trcd_max) ? cnt_wr + 16'd1 : 16'd0;
				WRITE : cnt_wr <= cnt_wr + 16'd1;
				default : cnt_wr <= 16'd0;
			endcase
		end
	end

	/*output wr_end用于表示写入结束的信号*/
	assign wr_end = (wr_state == END) ? 1'd1 : 1'd0;

	/*output wr_cmd用于执行的command*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_cmd <= NOP_CMD;
		end else begin
			case(wr_state)
				ACTIVE : wr_cmd <= ACTIVE_CMD;
				WRITE : wr_cmd <= (cnt_wr == 16'd1) ? WRITE_CMD : NOP_CMD;
				TERM : wr_cmd <= TERM_CMD;
				PRE : wr_cmd <= PRE_CMD;
				default : wr_cmd <= NOP_CMD;
			endcase
		end
	end

	/*output wr_ban用来表示行列操作时的Address*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_ban <= 2'b11;
		end else begin
			case(wr_state)
				ACTIVE : wr_ban <= 2'b00;
				WRITE : wr_ban <= (cnt_wr == 16'd1) ? 2'b00 : 22'b11;
				PRE : wr_ban <= 2'b00;
				default : wr_ban <= 2'b11;
			endcase
		end
	end

	/*output wr_sdram_addr*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_sdram_addr <= 13'h1FFF;
		end else begin
			case(wr_state)
				ACTIVE : wr_sdram_addr <= 13'h0000;
				WRITE : wr_sdram_addr <= (cnt_wr == 16'd1) ? 13'h0000 : 13'h1FFF;
				PRE : wr_sdram_addr <= 13'h0400;
				default : wr_sdram_addr <= 13'h1FFF;
			endcase
		end
	end

	/*output wr_sdram_en*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_sdram_en <= 1'd0;
		end else begin
			wr_sdram_en <= (wr_state == WRITE) ? 1'd1 : 1'd0;
		end
	end

	/*output wr_sdram_data*/
	assign wr_sdram_data = (wr_sdram_en) ? wr_data : 16'd0;


	/*output wr_ack*/
	assign wr_ack = (wr_state == WRITE) ? 1'd1 : 1'd0;

endmodule