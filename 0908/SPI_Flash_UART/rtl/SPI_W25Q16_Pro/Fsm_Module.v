// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : Fsm_Module.v
// Create : 2023-09-06 15:28:25
// Revise : 2023-09-06 15:28:25
// Editor : sublime text4, tab size (4)
// Descri : 通过FPGA向W25Q16配置寄存器，当cnt达到153(index == 152)时停止输出
// -----------------------------------------------------------------------------
module Fsm_Module 
#(
	parameter cnt_max = 8'd1,
	parameter spi_width_value = 8'd8,
	parameter cnt_index = 8'd3
)
(
	input clk,
	input rst_n,
	input spi_done,
	input flag,
	output reg spi_start,
	output [1:0] spi_cmd,
	output reg [7:0] spi_width,
	output reg [7:0] index,
	output reg led_flag,
	output [7:0] cnt_number
);

	reg [7:0] cnt;	//用来表示输出数据的地址依据

	reg [31:0] cnt_3600;

	reg key_flag;

	/*对按键进行锁存*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_flag <= 1'd0;
		end else if(flag) begin
			key_flag <= 1'd1;
		end else begin
			key_flag <= key_flag;
		end
	end

	/*对W25Q16芯片进行指令操作前进行延时处理*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_3600 <= 32'd0;
		end else if(cnt_3600 == 32'd5000) begin
			cnt_3600 <= cnt_3600;
		end else begin
			cnt_3600 <= cnt_3600 + 32'd1;
		end
	end

	//定义该模块存在的几种状态
	parameter IDLE = 2'b01;
	parameter WRITE = 2'b10;

	reg [1:0] state;

	reg spi_done_latch;

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : begin
					if((spi_done || spi_done_latch) && key_flag && cnt_3600 == 32'd5000 && (cnt < cnt_index)) begin
						state <= WRITE;
					end else if(key_flag && cnt >= cnt_index && cnt <= cnt_max + 8'd1 && spi_done) begin
						state <= WRITE;
					end else begin
						state <= IDLE;
					end
				end
				
				WRITE : state <= IDLE;

				default : state <= IDLE;
			endcase
		end
	end

    always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		spi_done_latch <= 1'd1;
    	end else begin
    		case(state)
    			IDLE : spi_done_latch <= (spi_done == 1'd1) ? spi_done : spi_done_latch;
    			WRITE : spi_done_latch <= 1'd0;
    			default : spi_done_latch <= spi_done_latch;
    		endcase
    	end
    end

	

	/*temp cnt*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			case(state)
				IDLE : cnt <= cnt;
				WRITE : cnt <= (cnt <= cnt_max + 8'd1) ? cnt + 8'd1 : cnt;
				default : cnt <= cnt;
			endcase
		end
	end

	/*output spi_start*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			spi_start <= 1'd0;
		end else begin
			case(state)
				IDLE : spi_start <= 1'd0;
				WRITE : spi_start <= (cnt <= cnt_max + 8'd1) ?  1'd1 : 1'd0;
				default : spi_start <= 1'd0;
			endcase
		end
	end

	assign spi_cmd = 2'b00;

	/*output spi_width*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			spi_width <= spi_width_value;
		end else begin
			case(state)
				IDLE : spi_width <= spi_width;
				WRITE : spi_width <= (cnt != 8'd1) ? spi_width_value : 8'd24;
				default : spi_width <= spi_width;
			endcase
		end
	end

	/*output index*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			index <= 8'd0;
		end else begin
			case(state)
				IDLE : index <= index;
				WRITE : index <= cnt;
				default : index <= index;
			endcase
		end
	end

	/*当index数据传输完毕后，拉高led_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_flag <= 1'd0;
		end else if(cnt == cnt_max + 8'd2) begin
			led_flag <= 1'd1;
		end else begin
			led_flag <= led_flag;
		end
	end

	assign cnt_number = cnt;

endmodule