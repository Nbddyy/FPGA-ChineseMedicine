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
// File   : Buffer_Module.v
// Create : 2023-08-26 21:42:17
// Revise : 2023-08-26 21:42:17
// Editor : sublime text4, tab size (4)
// Descri : 由于解析波特的速度快于码元的间隔，所以该模块用来平衡两者，待100位B码解析完后再传输给IRIG_B模块
// -----------------------------------------------------------------------------
module Buffer_Module 
#(
	parameter cnt_10ms_max = 24'd499_999,
	parameter cnt_1s_max = 32'd49_999_999
)
(
	input clk,
	input rst_n,
	input [7:0] op_data,
	input op_flag,
	output reg [7:0] ex_sig_B_code
);
	
	reg [7:0] op_cnt;

	reg [7:0] ex_sig_B_code_array [99:0];

	reg output_flag;
	reg output_en;

	reg [23:0] cnt_10ms;
	reg [7:0] cnt;

	reg [31:0] cnt_1s;

	reg ex_sig_B_code_flag;	//该信号用于SignalTapⅡ窗口捕捉


	reg op_flag_latch;	//用于调整软件至正确的信号

	integer i;

	/*调整软件至正常*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_flag_latch <= 1'd0;
		end else if(cnt_1s > cnt_1s_max) begin
			op_flag_latch <= 1'd0;
		end else if(op_flag) begin
			op_flag_latch <= 1'd1;
		end else begin
			op_flag_latch <= op_flag_latch;
		end
	end

	/*cnt_1s计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1s <= 32'd0;
		end else if(!op_flag_latch) begin
			cnt_1s <= 32'd0;
		end else begin
			cnt_1s <= cnt_1s + 32'd1;
		end
	end

	/*用于记录UART_Rx模块传输的B码的个数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			op_cnt <= 8'd0;
		end else if(op_cnt == 8'd100 || cnt_1s > cnt_1s_max) begin
			op_cnt <= 8'd0;
		end else if(op_flag) begin
			op_cnt <= op_cnt + 8'd1;
		end else begin
			op_cnt <= op_cnt;
		end
	end

	/*用于将B码寄存在数组中*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 100; i = i + 1) begin
				ex_sig_B_code_array[i] <= 8'd0;
			end
		end else if(op_flag) begin
			ex_sig_B_code_array[op_cnt] <= op_data;
		end else begin
			for(i = 0; i < 100; i = i + 1) begin
				ex_sig_B_code_array[i] <= ex_sig_B_code_array[i];
			end
		end
	end
	
	/*缓冲100个B码码元完毕，开始向B码脉冲绘制模块发送的标志信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			output_flag <= 1'd0;
		end else if(op_cnt == 8'd99 && op_flag) begin
			output_flag <= 1'd1;
		end else begin
			output_flag <= 1'd0;
		end
	end

	/*整个将100个码元传输至Draw_Symbol的使能信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			output_en <= 1'd0;
		end else if(cnt == 8'd101 && cnt_10ms == cnt_10ms_max) begin
			output_en <= 1'd0;
		end else if(output_flag) begin
			output_en <= 1'd1;
		end else begin
			output_en <= output_en;
		end
	end

	/*计数码元间隔10ms*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_10ms <= 24'd0;
		end else if(!output_en || cnt_10ms == cnt_10ms_max) begin
			cnt_10ms <= 24'd0;
		end else begin
			cnt_10ms <= cnt_10ms + 24'd1;
		end
	end

	/*用于记录当前传输的码元位置*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(output_flag) begin
			cnt <= 8'd1;
		end else if(!output_en) begin
			cnt <= 8'd0;
		end else if(cnt_10ms == cnt_10ms_max) begin
			cnt <= cnt + 8'd1;
		end else begin
			cnt <= cnt;
		end
	end

	/*output ex_sig_B_code*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_B_code <= 8'd0;
		end else if(!cnt) begin
			ex_sig_B_code <= 8'd0;
		end else begin
			ex_sig_B_code <= ex_sig_B_code_array[cnt - 8'd1];
		end
	end

	/*SignalTapⅡ ex_sig_B_code_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_B_code_flag <= 1'd0;
		end else if(output_flag || cnt_10ms == cnt_10ms_max) begin
			ex_sig_B_code_flag <= 1'd1;
		end else begin
			ex_sig_B_code_flag <= 1'd0;
		end
	end

endmodule