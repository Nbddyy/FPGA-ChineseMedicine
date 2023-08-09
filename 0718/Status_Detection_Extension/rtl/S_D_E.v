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
// File   : S_D.v
// Create : 2023-07-18 09:59:01
// Revise : 2023-07-18 09:59:01
// Editor : sublime text4, tab size (4)
// Descri : 使用三段式实现非重复性检测的状态机转换
// -----------------------------------------------------------------------------
module S_D_E (
	input clk,
	input rst_n,  
	input data_in,
	output reg find_10010
);

	
	reg [5:0] cur_state;
	reg [5:0] next_state;


	/*使用独热码进行表示各个状态，仅仅需要比较一位，简化译码逻辑，减少
	了出现毛刺的概率，几种状态对应几个位宽*/
	parameter IDLE = 6'b000_001;
	parameter S0 = 6'b000_010;
	parameter S1 = 6'b000_100;
	parameter S2 = 6'b001_000;
	parameter S3 = 6'b010_000;
	parameter S4 = 6'b100_000;


	/*描述状态转移*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cur_state <= IDLE;
		end else begin
			cur_state <= next_state;
		end
	end

	/*组合逻辑状态转移判断条件*/
	always @(*) begin
		case(cur_state)
			IDLE : next_state = (data_in) ? S0 : IDLE;
			S0 : next_state = (data_in) ? S0 : S1;
			S1 : next_state = (data_in) ? S0 : S2;
			S2 : next_state = (data_in) ? S3 : IDLE;
			S3 : next_state = (data_in) ? S0 : S4;
			S4 : next_state = (data_in) ? S0 : IDLE;
			default : next_state = IDLE;
		endcase // cur_state 
	end

	/*时序逻辑描述输出*/
	always@(posedge clk,negedge rst_n) begin
		if(!rst_n) begin
			find_10010 <= 1'd0;
		end else if(cur_state == S4) begin
			//采用Moore型输出（输出只与当前状态有关）
			find_10010 <= 1'd1;
		end else begin
			find_10010 <= 1'd0;
		end
	end

endmodule