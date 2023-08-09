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
// File   : V_M_E.v
// Create : 2023-07-18 17:28:49
// Revise : 2023-07-18 17:28:49
// Editor : sublime text4, tab size (4)
// Descri : 使用三段式状态机实现具有找钱、退钱功能的自动售货机
// -----------------------------------------------------------------------------
module V_M_E (
	input clk,
	input rst_n,
	/*coin[2]为1元判断,coin[1]为0.5元判断,coin[0]为复位判断*/
	input [2:0] coin,
	output reg change,
	output reg [2:0] refund,
	output reg shipping
);

	/*refunds[3]为找钱2元，refunds[2]为找钱1.5元，refunds[1]为找钱1元，
	refunds[0]为找钱0.5元*/
	wire [2:0] refunds [3:0];
	assign refunds[0] = 2'd1;
	assign refunds[1] = 2'd2;
	assign refunds[2] = 2'd3;
	assign refunds[3] = 2'd4;

	parameter IDLE = 6'b000_001;
	parameter S0 = 6'b000_010;
	parameter S1 = 6'b000_100;
	parameter S2 = 6'b001_000;
	parameter S3 = 6'b010_000;
	parameter S4 = 6'b100_000;

	reg [5:0] cur_state;
	reg [5:0] next_state;

	/*时序逻辑描述状态转移*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cur_state <= 6'd0;
		end else begin
			cur_state <= next_state;
		end
	end

	/*组合逻辑描述状态判断条件*/
	always @(*) begin
		case (cur_state)
			IDLE : next_state = (coin == 3'b001) ? IDLE :
								(coin == 3'b011) ? S0 :
								(coin == 3'b101) ? S1 : IDLE;
			S0 : next_state = (coin == 3'b001) ? S0 :
								(coin == 3'b011) ? S1 :
								(coin == 3'b101) ? S2 : IDLE;
			S1 : next_state = (coin == 3'b001) ? S1 :
								(coin == 3'b011) ? S2 :
								(coin == 3'b101) ? S3 : IDLE;
			S2 : next_state = (coin == 3'b001) ? S2 :
								(coin == 3'b011) ? S3 :
								(coin == 3'b101) ? S4 : IDLE;
			S3 : next_state = (coin == 3'b001) ? S3 :
								(coin == 3'b011) ? S4 :
								(coin == 3'b101) ? IDLE : IDLE;
			S4 : next_state = (coin == 3'b001) ? IDLE :
								(coin == 3'b011) ? S0 :
								(coin == 3'b101) ? S1 : IDLE;
			default : next_state = IDLE;
		endcase
	end

	/*时序逻辑进行输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			change <= 1'd0;
			refund <= 3'd0;
			shipping <= 1'd0;
		end else if((cur_state == S0 || cur_state == S1 || cur_state == S2 || cur_state == S3) && coin == 3'b000) begin
			//复位退钱代码实现
			case(cur_state)
				S0 : refund <= refunds[0];
				S1 : refund <= refunds[1];
				S2 : refund <= refunds[2];
				S3 : refund <= refunds[3];
				default : refund <= 3'd0;
			endcase
		end else if(cur_state == S3 && coin == 3'b101) begin
			//找钱操作
			shipping <= 1'd1;
			change <= 1'd1;
		end else if(cur_state == S4) begin
			shipping <= 1'd1;
		end else begin
			change <= 1'd0;
			refund <= 3'd0;
			shipping <= 1'd0;
		end
	end

endmodule