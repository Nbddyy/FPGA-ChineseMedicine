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
// File   : Detect_Module.v
// Create : 2023-09-02 10:14:16
// Revise : 2023-09-02 10:14:16
// Editor : sublime text4, tab size (4)
// Descri : 本次使用三段式状态机进行逻辑描述
// -----------------------------------------------------------------------------
module Detect_Module (
	input clk,
	input rst_n,
	input op_flag,
	input [7:0] op_data,
	output reg flag
);

	reg [4:0] state;
	reg [4:0] next_state;

	//定义序列检测的几种状态
	parameter IDLE = 5'b00001;
	parameter AA = 5'b00010;
	parameter BB = 5'b00100;
	parameter CC = 5'b01000;
	parameter DD = 5'b10000;

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	/*next_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			next_state <= IDLE;
		end else begin
			if(op_flag) begin
				case(state)
					IDLE : next_state <= (op_flag && op_data == 8'haa) ? AA : IDLE;
					AA : next_state <= (op_flag && op_data == 8'hbb) ? BB : (op_flag && op_data != 8'hbb) ? IDLE : AA;
					BB : next_state <= (op_flag && op_data == 8'hcc) ? CC : (op_flag && op_data != 8'hcc) ? IDLE : BB;
					CC : next_state <= (op_flag && op_data == 8'hdd) ? DD : (op_flag && op_data != 8'hdd) ? IDLE : CC;
					DD : next_state <= IDLE;
					default : next_state <= IDLE;
				endcase
			end else begin
				next_state <= (state == DD) ? IDLE : next_state;
			end
			
		end
	end

	/*output flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			flag <= 1'd0;
		end else begin
			// flag <= (state == DD) ? 1'd1 : 1'd0; //Moore型
			flag <= (state == CC && op_flag && op_data == 8'hdd) ? 1'd1 : 1'd0;	//Mearly型
		end
	end

endmodule