module SDRAM_Read 
#(
	parameter cnt_trcd_max = 4'd3,
	parameter cnt_trp_max = 4'd2,
	parameter cnt_rd_max = 16'd12,
	parameter cnt_lat_max = 4'd3
)
(
	input clk,
	input rst_n,
	input init_end,
	input rd_en,
	input [9:0] rd_burst_len,
	input [23:0] rd_addr,
	input [15:0] rd_data,
	output rd_end,
	output reg [3:0] rd_cmd,
	output reg [1:0] rd_ban,
	output reg [12:0] rd_sdram_addr,
	output rd_ack,
	output reg [15:0] rd_sdram_data 
);

	//定义该模块存在的几种状态
	parameter IDLE = 10'b00_0000_0001;
	parameter ACTIVE = 10'b00_0000_0010;
	parameter TRCD = 10'b00_0000_0100;
	parameter READ = 10'b00_0000_1000;
	parameter LAT = 10'b00_0001_0000;
	parameter DOUT = 10'b00_0010_0000;
	parameter TERM = 10'b00_0100_0000;
	parameter PRE = 10'b00_1000_0000;
	parameter TRP = 10'b01_0000_0000;
	parameter END = 10'b10_0000_0000;

	//定义各命令的数值
	parameter NOP_CMD = 4'b0111;
	parameter ACTIVE_CMD = 4'b0011;
	parameter READ_CMD = 4'b0101;
	parameter TERM_CMD = 4'b0110;
	parameter PRE_CMD = 4'b0010;

	reg [9:0] rd_state;
	reg cnt_time_rst;
	reg [3:0] cnt_time;
	reg [15:0] cnt_rd;

	reg [15:0] rd_data_clap_1;

	/*temp rd_data_clap_1*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_data_clap_1 <= 16'd0;
		end else begin
			rd_data_clap_1 <= rd_data;
		end
	end

	/*rd_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_state <= IDLE;
		end else begin
			case(rd_state)
				IDLE : rd_state <= (rd_en) ? ACTIVE : rd_state;
				ACTIVE : rd_state <= TRCD;
				TRCD : rd_state <= (cnt_time == cnt_trcd_max) ? READ : rd_state;
				READ : rd_state <= LAT;
				LAT : rd_state <= (cnt_time == cnt_trcd_max) ? DOUT : rd_state;

				DOUT : begin
					if(cnt_rd == cnt_rd_max - 16'd6) begin
						rd_state <= TERM;
					end else if(cnt_rd == cnt_rd_max) begin
						rd_state <= PRE;
					end else begin
						rd_state <= rd_state;
					end
				end 

				TERM : rd_state <= DOUT;

				PRE : rd_state <= TRP;
				TRP : rd_state <= (cnt_time == cnt_trp_max) ? END : rd_state;
				END : rd_state <= IDLE;
				default : rd_state <= IDLE;
			endcase
		end
	end

	/*temp cnt_time_rst*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_time_rst <= 1'd1;
		end else begin
			case(rd_state)
				IDLE : cnt_time_rst <= (rd_en) ? 1'd0 : 1'd1;
				ACTIVE : cnt_time_rst <= 1'd0;
				TRCD : cnt_time_rst <= (cnt_time == cnt_trcd_max - 4'd1) ? 1'd1 : 1'd0;
				READ : cnt_time_rst <= 1'd0;
				LAT : cnt_time_rst <= (cnt_time == 4'd1) ? 1'd0 : 1'd1;
				DOUT : cnt_time_rst <= (cnt_rd == cnt_rd_max) ? 1'd0 : 1'd1;
				PRE : cnt_time_rst <= 1'd0;
				default : cnt_time_rst <= 1'd1;
			endcase
		end
	end

	/*temp cnt_time*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_time <= 4'd0;
		end else begin
			cnt_time <= (cnt_time_rst) ? 4'd0 : cnt_time + 4'd1;
		end
	end

	/*temp cnt_rd*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_rd <= 16'd0;
		end else begin
			case(rd_state)
				LAT : cnt_rd <= (cnt_time == cnt_trcd_max) ? cnt_rd + 16'd1 : cnt_rd;
				DOUT : cnt_rd <= (cnt_rd != cnt_rd_max) ? cnt_rd + 16'd1 : 16'd0;
				TERM : cnt_rd <= cnt_rd + 16'd1;
				default : cnt_rd <= 16'd0;
			endcase
		end
	end
	
	/*output rd_end*/
	assign rd_end = (rd_state == END) ? 1'd1 : 1'd0;

	/*output rd_cmd*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_cmd <= NOP_CMD;
		end else begin
			case(rd_state)
				ACTIVE : rd_cmd <= ACTIVE_CMD;
				READ : rd_cmd <= READ_CMD;
				TERM : rd_cmd <= TERM_CMD;
				PRE : rd_cmd <= PRE_CMD;
				default : rd_cmd <= NOP_CMD;
			endcase
		end
	end

	/*output rd_ban*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_ban <= 2'b11;
		end else begin
			case(rd_state)
				ACTIVE : rd_ban <= 2'b00;
				READ : rd_ban <= 2'b00;
				PRE : rd_ban <= 2'b00;
				default : rd_ban <= 2'b11;
			endcase
		end
	end

	/*output rd_sdram_addr*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_sdram_addr <= 13'h1FFF;
		end else begin
			case(rd_state)
				ACTIVE : rd_sdram_addr <= 13'h0000;
				READ : rd_sdram_addr <= 13'h0000;
				PRE : rd_sdram_addr <= 13'h0400;
				default : rd_sdram_addr <= 13'h1FFF;
			endcase
		end
	end

	/*output rd_ack*/
	assign rd_ack = (cnt_rd >= 16'd2 && cnt_rd <= 16'd11) ? 1'd1 : 1'd0;

	/*output rd_sdram_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_sdram_data <= 16'd0;
		end else if(cnt_rd >= 16'd1 && cnt_rd <= 16'd10) begin
			rd_sdram_data <= rd_data_clap_1;
		end else begin
			rd_sdram_data <= 16'd0;
		end
	end


endmodule