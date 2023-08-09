// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : yongchan jeon (Kris) poucotm@gmail.com
// File   : Led_Machine.v
// Create : 2023-07-21 19:21:29
// Revise : 2023-07-21 19:21:29
// Editor : sublime text4, tab size (4)
// Descri : 用二段式状态机描述几种亮灯状态的转移以及对应结果的输出
// -----------------------------------------------------------------------------
module Led_Machine 
#(
	parameter led_out_0 = 6'b00_1111,
	parameter led_out_1 = 6'b00_1110,
	parameter led_out_2 = 6'b00_1100,
	parameter led_out_3 = 6'b00_1000,
	parameter led_out_4 = 6'b00_0000,
	parameter led_out_5 = 6'b01_0000,
	parameter led_out_6 = 6'b10_0000
)
(
	input clk,
	input rst_n,
	input [3:0] coins,
	/*led_out存在一下几种输出
	其中低四位控制对应四个LED亮10s的一种情况
	[5]是判断双向流水灯的标志
	[4]是判断单向流水灯的标志
	00_0000：全部熄灭
	00_0001：LED1亮
	00_0011：LED1、LED2亮
	00_0111：LED1、LED2、LED3亮
	00_1111：LED1、LED2、LED3、LED4亮
	01_0000：单向右流水10s
	10_0000：双向流水10s（先右后左）
	*/
	output reg [5:0] led_out
);


	/*定义LED的几种状态如下
	使用独热码表示亮灯各个状态
	IDLE(0_000_001):LED闲置
	ONE(0_000_010)	:LED1亮
	TWO(0_000_100)	:LED1、LED2亮
	THREE(0_001_000):LED1、LED2、LED3亮
	FOUR(0_010_000):LED1、LED2、LED3、LED4亮
	SINGLE(0_100_000):单向流水十秒钟
	DOUBLE(1_000_000):双向流水十秒钟*/
	reg [6:0] led_state;
	parameter IDLE = 7'b0_000_001;
	parameter ONE = 7'b0_000_010;
	parameter TWO = 7'b0_000_100;
	parameter THREE = 7'b0_001_000;
	parameter FOUR = 7'b0_010_000;
	parameter SINGLE = 7'b0_100_000;
	parameter DOUBLE = 7'b1_000_000;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_state <= IDLE;
		end else begin
			case(led_state)
				IDLE : begin
					if(coins == 4'b0000) begin
						led_state <= IDLE;
					end else if(coins == 4'b0110) begin
						led_state <= ONE;
					end else if(coins == 4'b1010) begin
						led_state <= TWO;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= IDLE;
					end
				end

				ONE : begin
					if(coins == 4'b0000) begin
						led_state <= IDLE;
					end else if(coins == 4'b0110) begin
						led_state <= TWO;
					end else if(coins == 4'b1010) begin
						led_state <= THREE;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= ONE;
					end
				end

				TWO : begin
					if(coins == 4'b0000) begin
						led_state <= IDLE;
					end else if(coins == 4'b0110) begin
						led_state <= THREE;
					end else if(coins == 4'b1010) begin
						led_state <= FOUR;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= TWO;
					end
				end

				THREE : begin
					if(coins == 4'b0000) begin
						led_state <= IDLE;
					end else if(coins == 4'b0110) begin
						led_state <= FOUR;
					end else if(coins == 4'b1010) begin
						led_state <= SINGLE;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= THREE;
					end
				end

				FOUR : begin
					if(coins == 4'b0000) begin
						led_state <= IDLE;
					end else if(coins == 4'b0110) begin
						led_state <= SINGLE;
					end else if(coins == 4'b1010) begin
						led_state <= DOUBLE;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= FOUR;
					end
				end

				SINGLE : begin
					if(coins == 4'b0110) begin
						led_state <= ONE;
					end else if(coins == 4'b1010) begin
						led_state <= TWO;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= SINGLE;
					end
				end

				DOUBLE : begin
					if(coins == 4'b0110) begin
						led_state <= ONE;
					end else if(coins == 4'b1010) begin
						led_state <= TWO;
					end else if(coins == 4'b0011) begin
						led_state <= IDLE;
					end else begin
						led_state <= DOUBLE;
					end
				end
			endcase
		end
	end

	/*led_out对应状态下的几种输出情况*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= led_out_0;
		end else begin
			case(led_state) 
				IDLE : led_out <= led_out_0;
				ONE : led_out <= led_out_1;
				TWO : led_out <= led_out_2;
				THREE : led_out <= led_out_3;
				FOUR : led_out <= led_out_4;
				SINGLE : led_out <= led_out_5;
				DOUBLE : led_out <= led_out_6;
				default : led_out <= led_out_0;
			endcase
		end
	end

endmodule