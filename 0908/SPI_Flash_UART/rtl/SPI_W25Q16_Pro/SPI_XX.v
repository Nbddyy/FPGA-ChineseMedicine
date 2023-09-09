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
// File   : SPI_XX.v
// Create : 2023-09-07 17:18:05
// Revise : 2023-09-07 17:18:05
// Editor : sublime text4, tab size (4)
// Descri : 此次SPI协议输出模式为CPOL = 0，CPHA = 0，我们向W25Q16芯片写入两
//			个指令，分别为06h和C7h，chip erase命令写入前先将WEL拉高锁存
// -----------------------------------------------------------------------------
module SPI_XX 
#(
	parameter cnt_number_max = 8'd1
)
(
	input clk,
	input rst_n,
	input spi_start,
	input [1:0] spi_cmd,
	input [23:0] spi_wrdata,
	input [7:0] spi_width,
	input [7:0] cnt_number,
	output spi_clk,
	output cs,
	output reg spi_mosi,
	output reg spi_done
);

	wire clk_n;
	reg [5:0] state;
	reg [7:0] cnt;
	wire clk_en;

	//定义输出判断存在的几种状态
	parameter IDLE = 6'b000_001;
	parameter S0 = 6'b000_010;
	parameter S1 = 6'b000_100;
	parameter S2 = 6'b001_000;
	parameter S3 = 6'b010_000;
	parameter S4 = 6'b100_000;

	assign clk_n = !clk;

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : state <= (spi_start && cnt_number < cnt_number_max + 8'd2) ? S0 : IDLE;
				S0 : state <= S1;
				S1 : begin
					if(cnt_number == cnt_number_max + 8'd1 && cnt == spi_width) begin
						state <= S2;
					end else if(cnt_number < 8'd3) begin
						state <= S1;
					end else begin
						state <= S1;
					end
				end 
				S2 : state <= S3;
				S3 : state <= S4;
				S4 : state <= IDLE;
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
				S0 : cnt <= 8'd1;
				S1 : cnt <= ((cnt < spi_width) && (cnt != spi_width)) ? cnt + 8'd1 : 8'd1;
				default : cnt <= 8'd0;
			endcase
		end
	end

	assign clk_en = (state == S1) ? 1'd1 : 1'd0;

	assign cs = ((state == S1 || state == S2) || (cnt_number == cnt_number_max + 8'd2)) ? 1'd0 : 1'd1;

	assign spi_clk = ((state == S1 && (cnt >= 8'd1 && cnt <= spi_width)) || (cnt_number == cnt_number_max + 8'd2)) ? clk_n : 1'd0;

	always @(*) begin
		if(!rst_n) begin
			spi_mosi = 1'd0;
		end else begin
			spi_mosi = (state == S1 && (cnt >= 8'd1 && cnt <= spi_width)) ? spi_wrdata[spi_width - cnt] : 1'd0;

		end
	end


	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			spi_done = 1'd1;
		end else begin

				spi_done = (state == S1 && cnt == spi_width - 8'd2) ? 1'd1 : 1'd0; 

			
		end
	end

endmodule