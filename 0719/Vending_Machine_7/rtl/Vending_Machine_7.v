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
// File   : Vending_Machine_7.v
// Create : 2023-07-19 10:52:33
// Revise : 2023-07-19 10:52:33
// Editor : sublime text4, tab size (4)
// Descri : 使用新二段式实现售价为3.5元的自动售货机
// -----------------------------------------------------------------------------
module Vending_Machine_7 (
	input clk,
	input rst_n,
	input [2:0] coins,
	output reg change,
	output reg ship,
	output reg [2:0] refund
);

	reg [31:0] state;
	parameter IDLE = "IDLE";
	parameter S0 = "S0";
	parameter S1 = "S1";
	parameter S2 = "S2";
	parameter S3 = "S3";
	parameter S4 = "S4";
	parameter S5 = "S5";

	wire [2:0] refunds [5:0];
	assign refunds[0] = 3'd1;	//退款0.5元
	assign refunds[1] = 3'd2;	//退款1元
	assign refunds[2] = 3'd3;	//退款1.5元
	assign refunds[3] = 3'd4;	//退款2元
	assign refunds[4] = 3'd5;	//退款2.5元
	assign refunds[5] = 3'd6;	//退款3元


	/*状态转移的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			state <= IDLE;
		end else begin
			case(state) 
				IDLE : state <= (coins == 3'b011) ? S0 :
								(coins == 3'b101) ? S1 : IDLE;
				S0 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? S1 :
								(coins == 3'b101) ? S2 : S0;
				S1 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? S2 :
								(coins == 3'b101) ? S3 : S1;
				S2 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? S3 :
								(coins == 3'b101) ? S4 : S2;
				S3 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? S4 :
								(coins == 3'b101) ? S5 : S3;
				S4 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? S5 :
								(coins == 3'b101) ? IDLE : S4;
				S5 : state <= (coins == 3'b000) ? IDLE :
								(coins == 3'b011) ? IDLE :
								(coins == 3'b101) ? IDLE : S5;
			endcase
		end
	end

	/*输出change找零五角的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			change <= 1'd0;
		end else if(state == S5 && coins == 3'b101) begin
			change <= 1'd1;
		end else begin
			change <= 1'd0;
		end
	end

	/*输出ship出货的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ship <= 1'd0;
		end else if(state == S4 && coins == 3'b101) begin
			ship <= 1'd1;
		end else if((state == S5 && coins == 3'b011) || (state == S5 && coins == 3'b101)) begin
			ship <= 1'd1;
		end else begin
			ship <= 1'd0;
		end
	end

	/*输出refund退款的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			refund <= 3'd0;
		end else if(coins == 3'b000) begin
			case(state) 
				S0 : refund <= refunds[0];
				S1 : refund <= refunds[1];
				S2 : refund <= refunds[2];
				S3 : refund <= refunds[3];
				S4 : refund <= refunds[4];
				S5 : refund <= refunds[5];
				default : refund <= 3'd0;
			endcase
		end else begin
			refund <= 3'd0;
		end
	end


endmodule