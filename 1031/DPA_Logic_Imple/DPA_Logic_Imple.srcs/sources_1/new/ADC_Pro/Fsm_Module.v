// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy qq1877117587@outlook.com
// File   : Fsm_Module.v
// Create : 2023-10-28 10:19:07
// Revise : 2023-10-28 10:19:07
// Editor : sublime text4, tab size (4)
// Descri : 通过FPGA向ADS42LB69配置寄存器，当cnt达到53(index == 52)时停止输出
// Revise : 增加test_over, 当对ADC芯片配置测试模式完成后后续模块才开始处理接收到的数据
// -----------------------------------------------------------------------------
module Fsm_Module 
#(
	parameter cnt_max = 8'd52,
	parameter spi_width_value = 8'd16
)
(
	input clk,
	input rst_n,
	input spi_done,
	input detect_com,		//后续IDELAY配完成信号，用于将ADS42芯片配置输出为正常的标识位
	input init_comple,

	output reg spi_start,
	// output [1:0] spi_cmd,
	output [7:0] spi_width,
	output reg [7:0] index,
	output reg test_over	//配置ADC测试模式0~65535的完成标志
);

	reg detect_com_clap;
	wire detect_com_latch;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			detect_com_clap <= 1'd0;
		end else begin
			detect_com_clap <= detect_com;
		end
	end

	assign detect_com_latch = detect_com && !detect_com_clap;

	reg [7:0] cnt;	//用来表示输出数据的地址依据

	//定义该模块存在的几种状态
	parameter IDLE = 3'b001;
	parameter WRITE = 3'b010;
	parameter NORMAL = 3'b100;

	reg [2:0] state;

	reg spi_done_latch;

	always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		spi_done_latch <= 1'd1;
    	end else begin
    		case(state)
    			IDLE : spi_done_latch <= (spi_done == 1'd1) ? spi_done : spi_done_latch;
    			WRITE : spi_done_latch <= 1'd0;
    			NORMAL : spi_done_latch <= 1'd0;
    			default : spi_done_latch <= spi_done_latch;
    		endcase
    	end
    end

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : state <= ((spi_done || spi_done_latch) && init_comple && !detect_com) ? WRITE : (detect_com_latch == 1'd1 && init_comple) ? NORMAL : state;
				WRITE : state <= IDLE;
				NORMAL : state <= IDLE;
				default : state <= IDLE;
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
				WRITE : cnt <= (cnt < cnt_max + 8'd1) ? cnt + 8'd1 : cnt;
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
				WRITE : spi_start <= (cnt < cnt_max + 8'd1) ?  1'd1 : 1'd0;
				NORMAL : spi_start <= 1'd1;
				default : spi_start <= 1'd0;
			endcase
		end
	end

	// assign spi_cmd = 2'b00;

	assign spi_width = spi_width_value;

	/*output index*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			index <= 8'd0;
		end else begin
			case(state)
				IDLE : index <= index;
				WRITE : index <= cnt;
				NORMAL : index <= cnt_max + 8'd1;
				default : index <= index;
			endcase
		end
	end

	/*test_over*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			test_over <= 1'd0;
		end else begin
			test_over <= (index == cnt_max && spi_done) ? 1'd1 : test_over;
		end
	end

endmodule