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
// File   : Poll_Detect.v
// Create : 2023-08-11 14:28:12
// Revise : 2023-08-11 14:28:12
// Editor : sublime text4, tab size (4)
// Descri : 对输入access进行打拍，从而在原有access基础上增加两拍，数据也进行两次打拍操作
// -----------------------------------------------------------------------------
module Poll_Detect (
	input fifo_rdclk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [2:0] access,
	input [63:0] q_in,
	input [63:0] cnt_ch,
	output reg data_valid,
	output reg [63:0] up_data
);

	reg [2:0] detect_clap_1;
	reg [2:0] detect_clap_2;

	reg [63:0] q_in_clap_1;
	reg [63:0] q_in_clap_2;

	reg [63:0] cnt_ch_clap_1;

	/*对access和q_in进行打拍,为数据帧头空出两个fifo_rdclk*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			detect_clap_1 <= 1'd0;
			detect_clap_2 <= 1'd0;
			q_in_clap_1 <= 64'd0;
			q_in_clap_2 <= 64'd0;
			cnt_ch_clap_1 <= 64'd0;
		end else begin
			detect_clap_1 <= access;
			detect_clap_2 <= detect_clap_1;
			q_in_clap_1 <= q_in;
			q_in_clap_2 <= q_in_clap_1;
			cnt_ch_clap_1 <= cnt_ch;
		end
	end

	assign data_valid_pre = access || detect_clap_1 || detect_clap_2;


	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end else if(data_valid_pre != 3'd0) begin
			data_valid <= 1'd1;
			if(!(detect_clap_1 || detect_clap_2)) begin
				up_data <= {32'hadf90c00,29'd0,access};
			end else if(!detect_clap_2) begin
				up_data <= (cnt_ch_clap_1 - 1) / 128;	//数据帧中的发包统计指的是总共上传了几个数据包（数据串）
			end else begin
				up_data <= q_in_clap_2;
			end
			
		end else begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end
	end

endmodule