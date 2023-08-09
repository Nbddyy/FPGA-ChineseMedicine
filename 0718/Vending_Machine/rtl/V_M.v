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
// File   : V_M.v
// Create : 2023-07-18 16:01:14
// Revise : 2023-07-18 16:01:14
// Editor : sublime text4, tab size (4)
// Descri : 具有找钱，没有退钱功能的自动售货机
// -----------------------------------------------------------------------------

module V_M (
	input clk,
	input rst_n,
	input [1:0] coin,
	output reg change,	//找零标志0.5元
	output reg shipping	//出货标志
);

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
			cur_state <= IDLE;
		end else begin
			cur_state <= next_state;
		end
	end

	/*组合逻辑描述状态转移判断条件*/
	always @(*) begin
		case(cur_state)
			IDLE : begin
				// if(!coin) begin
				// 	next_state = IDLE;
				// end else if(coin == 2'd1) begin
				// 	next_state = S0;
				// end else begin
				// 	next_state = S1;
				// end

				next_state = (!coin) ? IDLE :
				 (coin == 2'd1) ? S0 : S1;
			end

			S0 : next_state = (!coin) ? S0 :
				 (coin == 2'd1) ? S1 : S2;
			S1 : next_state = (!coin) ? S1 :
				 (coin == 2'd1) ? S2 : S3;
			S2 : next_state = (!coin) ? S2 :
				 (coin == 2'd1) ? S3 : S4;
			S3 : next_state = (!coin) ? S3 :
				 (coin == 2'd1) ? S4 : IDLE;
			S4 : next_state = (!coin) ? IDLE :
				 (coin == 2'd1) ? S0 : S1;
			default : next_state = IDLE;
		endcase
	end

	/*时序逻辑进行结果输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			change <= 1'd0;
			shipping <= 1'd0;
		end else if(cur_state == S3 && coin == 2'b10) begin
			change <= 1'd1;
			shipping <= 1'd1;
		end else if(cur_state == S4) begin
			shipping <= 1'd1;
		end else begin
			change <= 1'd0;
			shipping <= 1'd0;
		end
	end

endmodule