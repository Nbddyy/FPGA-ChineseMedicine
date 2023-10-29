// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy qq1877117587@outlook.com
// File   : Bit_Splice_Detect_Pro.v
// Create : 2023-10-28 16:53:45
// Revise : 2023-10-28 16:53:45
// Editor : sublime text4, tab size (4)
// Descri : 通过位拼接对ADC处理的数据进行校准（延时相减）, the core logic code go to 59 or 87 rows.
// -----------------------------------------------------------------------------
module Bit_Splice_Detect_Pro (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input [4:0] CNTVALUEOUT,
	input detect_over,

	input D0,
	input D1,
	input D2,
	input D3,
	input D4,
	input D5,
	input D6,
	input D7,
	input D8,
	input D9,
	input D10,
	input D11,
	input D12,
	input D13,
	input D14,
	input D15,

	output reg [2:0] detect_com,
	output reg signed [15:0] D16
);
	
	reg signed [15:0] D16_clap;
	reg [15:0] cnt_4000;		//延拍相减2000次左右
	reg detect_com_latch;

	wire [16:0] detect_result;

	/*detect_com_latch用于锁存校准完成*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			detect_com_latch <= 1'd0;
		end else begin
			detect_com_latch <= (detect_over) ? 1'd1 : detect_com_latch;
		end
	end

	/*cnt_4000：
	① 如果校准正确（即延时相减一直满足差值为1或-65535，累计2000次），则cnt_4000停止计数
	② 校准中发现差值不满足1或65535，则认为IDELAY相位偏移有误，计数归零，将校准结果反馈给IDELAY模块
	*/
	// always @(posedge clk or negedge rst_n) begin
	// 	if(~rst_n) begin
	// 		cnt_4000 <= 16'd0;
	// 	end else if(detect_com_latch || detect_com[1]) begin
	// 		cnt_4000 <= 16'd0;
	// 	end else begin
	// 		cnt_4000 <= cnt_4000 + 16'd1;
	// 	end
	// end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			D16 <= 16'd0;
		end else begin
			D16 <= {D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0};
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			D16_clap <= 16'd0;
		end else begin
			D16_clap <= D16;
		end
	end

	/*detect_com[1:0]*/
	//[1] express the Bit_Splice_Detect_pro module detect result flag, [0] express detect result
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			detect_com <= 3'b000;
			cnt_4000 <= 16'd0;
		end else if(cnt_4000 == 16'd4000) begin
			detect_com <= (CNTVALUEOUT == 5'd31) ? 3'b111 : 3'b011;
			cnt_4000 <= 16'd0;
		end else if(cnt_4000 >= 16'd2000 && cnt_4000 < 16'd4000) begin
			detect_com <= (({1'b0,D16} - {1'b0,D16_clap}) == 1 || ({1'b0,D16} - {1'b0,D16_clap}) == 17'h10001) ? 3'b000 : 3'b010;
			cnt_4000 <= (({1'b0,D16} - {1'b0,D16_clap}) == 1 || ({1'b0,D16} - {1'b0,D16_clap}) == 17'h10001) ? cnt_4000 + 16'd1 : 16'd0;
		end else begin
			detect_com <= (detect_over) ? 3'b100 : 3'b000;
			cnt_4000 <= (!detect_com_latch) ? cnt_4000 + 16'd1 : 16'd0;
		end
	end

	/*方便观察相减结果*/
	assign detect_result = ({1'b0,D16} - {1'b0,D16_clap});

endmodule