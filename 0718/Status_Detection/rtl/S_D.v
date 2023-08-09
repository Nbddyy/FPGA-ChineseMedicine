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
// Descri : 使用二段式实现重复性检测的状态机转换
// -----------------------------------------------------------------------------
module S_D (
	input clk,
	input rst_n,  
	input data_in,
	output reg find_10010
);

	
	reg [5:0] state;


	/*使用独热码进行表示各个状态，仅仅需要比较一位，简化译码逻辑，减少
	了出现毛刺的概率，几种状态对应几个位宽*/
	parameter IDLE = 6'b000_001;
	parameter S0 = 6'b000_010;
	parameter S1 = 6'b000_100;
	parameter S2 = 6'b001_000;
	parameter S3 = 6'b010_000;
	parameter S4 = 6'b100_000;



	//二段式：第一段
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
			IDLE : begin
				/*if(data_in) begin
					next_state = S0;
				end else begin
					next_state = IDLE;
				end*/
				state <= (data_in) ? S0 : IDLE;
			end
			S0 : state <= (data_in) ? S0 : S1;
			S1 : state <= (data_in) ? S0 : S2;
			S2 : state <= (data_in) ? S3 : IDLE;
			S3 : begin
				if(data_in) begin
					state <= S0;
				end else begin
					state <= S4;
				end
				// state = (data_in) ? S0 : S4;
			end
			S4 : begin
				if(data_in) begin
					state <= S0;
				end else begin
					state <= S2;
				end
			end 
			// state = (data_in) ? S0 : S2;
			default: state <= state;
		endcase // state
		end
		
	end

	//二段式：第二段
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			find_10010 <= 1'd0;
		end else if(state == S3 && data_in == 1'd0) begin
			find_10010 <= 1'b1;
		end else begin
			find_10010 <= 1'd0;
		end
	end


endmodule