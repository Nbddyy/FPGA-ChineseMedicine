// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : yongchan jeon (Kris) poucot+m@gmail.com
// File   : Vending_Machine.v
// Create : 2023-07-21 15:04:56
// Revise : 2023-07-21 15:04:56
// Editor : sublime text4, tab size (4)
// Descri : 使用二段式描述状态转移和对应情况下的输出
// -----------------------------------------------------------------------------
module Vending_Machine 
#(
	
	parameter IDLE = 6'b000_001,	//闲置状态
	parameter S0 = 6'b000_010,		//投入0.5元
	parameter S1 = 6'b000_100,		//投入1元
	parameter S2 = 6'b001_000,		//投入1.5元
	parameter S3 = 6'b010_000,		//投入2元
	parameter S4 = 6'b100_000		//投入2.5元
)
(
	input clk,
	input rst_n,
	input [3:0] coins,
	output reg change,
	output reg shipping,
	output reg [2:0] refund
);


	/*定义几种状态下退钱的变量*/
	wire [2:0] refunds [3:0];
	assign refunds[0] = 3'd1;	//退钱0.5元
	assign refunds[1] = 3'd2;	//退钱1元
	assign refunds[2] = 3'd3;	//退钱1.5元
	assign refunds[3] = 3'd4;	//退钱2元

	/*定义状态*/
	reg [5:0] state;


	/*几种状态之间的转移*/
	
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state) 
				IDLE : begin
					if(coins == 4'b0000) begin
						state <= IDLE;
					end else if(coins == 4'b0110) begin
						state <= S0;
					end else if(coins == 4'b1010) begin
						state <= S1;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= IDLE;
					end
				end

				S0 : begin
					if(coins == 4'b0000) begin
						state <= IDLE;
					end else if(coins == 4'b0110) begin
						state <= S1;
					end else if(coins == 4'b1010) begin
						state <= S2;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= S0;
					end
				end

				S1 : begin
					if(coins == 4'b0000) begin
						state <= IDLE;
					end else if(coins == 4'b0110) begin
						state <= S2;
					end else if(coins == 4'b1010) begin
						state <= S3;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= S1;
					end
				end

				S2 : begin
					if(coins == 4'b0000) begin
						state <= IDLE;
					end else if(coins == 4'b0110) begin
						state <= S3;
					end else if(coins == 4'b1010) begin
						state <= S4;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= S2;
					end
				end

				S3 : begin
					if(coins == 4'b0000) begin
						state <= IDLE;
					end else if(coins == 4'b0110) begin
						state <= S4;
					end else if(coins == 4'b1010) begin
						state <= IDLE;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= S3;
					end
				end

				S4 : begin
					if(coins == 4'b0110) begin
						state <= S0;
					end else if(coins == 4'b1010) begin
						state <= S1;
					end else if(coins == 4'b0010) begin
						state <= IDLE;
					end else if(coins == 4'b0011) begin
						state <= IDLE;
					end else begin
						state <= S4;
					end
				end

				default : state <= IDLE;

			endcase
		end
	end

	/*对应状态各个输出的结果*/
	/*找钱change的输出情况*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			change <= 1'd0;
		end else if(state == S3 && coins == 4'b1010) begin
			change <= 1'd1;
		end else begin
			change <= 1'd0;
		end
	end

	/*出可口shipping输出的情况*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			shipping <= 1'd0;
		end else if(state == S3 && (coins == 4'b0110 || coins == 4'b1010)) begin
			shipping <= 1'd1;
		end else if(state == S2 && coins == 4'b1010) begin
			shipping <= 1'd1;
		end else begin
			shipping <= 1'd0;
		end
	end

	/*退钱refund输出的情况*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			refund <= 3'd0;
		end else if(state == S0 && (coins == 4'b0000 || coins == 4'b0011)) begin
			refund <= refunds[0];
		end else if(state == S1 && (coins == 4'b0000 || coins == 4'b0011)) begin
			refund <= refunds[1];
		end else if(state == S2 && (coins == 4'b0000 || coins == 4'b0011)) begin
			refund <= refunds[2];
		end else if(state == S3 && (coins == 4'b0000 || coins == 4'b0011)) begin
			refund <= refunds[3];
	    end else begin
			 refund <= 3'd0;
		end
	end

endmodule