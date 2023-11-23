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
// File   : DCFIFO_30_Pro.v
// Create : 2023-11-07 23:12:15
// Revise : 2023-11-07 23:12:15
// Editor : sublime text4, tab size (4)
// Descri : 30FIFO-带帧头-用generate（Poll_Detect未用状态机）
// -----------------------------------------------------------------------------
module DCFIFO_30_Pro (
	input main_clk,
	input rd_clk,
	input rst_n,  // Asynchronous reset active low
	
	input signed [15:0] subband_ch1_data_real,
	input signed [15:0] subband_ch1_data_imaginary,
	input signed [15:0] subband_ch2_data_real,
	input signed [15:0] subband_ch2_data_imaginary,
	input signed [15:0] subband_ch3_data_real,
	input signed [15:0] subband_ch3_data_imaginary,
	input signed [15:0] subband_ch4_data_real,
	input signed [15:0] subband_ch4_data_imaginary,
	input signed [15:0] subband_ch5_data_real,
	input signed [15:0] subband_ch5_data_imaginary,
	input signed [15:0] subband_ch6_data_real,
	input signed [15:0] subband_ch6_data_imaginary,
	input signed [15:0] subband_ch7_data_real,
	input signed [15:0] subband_ch7_data_imaginary,
	input signed [15:0] subband_ch8_data_real,
	input signed [15:0] subband_ch8_data_imaginary,
	input signed [15:0] subband_ch9_data_real,
	input signed [15:0] subband_ch9_data_imaginary,
	input signed [15:0] subband_ch10_data_real,
	input signed [15:0] subband_ch10_data_imaginary,
	input signed [15:0] subband_ch11_data_real,
	input signed [15:0] subband_ch11_data_imaginary,
	input signed [15:0] subband_ch12_data_real,
	input signed [15:0] subband_ch12_data_imaginary,
	input signed [15:0] subband_ch13_data_real,
	input signed [15:0] subband_ch13_data_imaginary,
	input signed [15:0] subband_ch14_data_real,
	input signed [15:0] subband_ch14_data_imaginary,
	input signed [15:0] subband_ch15_data_real,
	input signed [15:0] subband_ch15_data_imaginary,
	input signed [15:0] subband_ch16_data_real,
	input signed [15:0] subband_ch16_data_imaginary,
	input signed [15:0] subband_ch17_data_real,
	input signed [15:0] subband_ch17_data_imaginary,
	input signed [15:0] subband_ch18_data_real,
	input signed [15:0] subband_ch18_data_imaginary,
	input signed [15:0] subband_ch19_data_real,
	input signed [15:0] subband_ch19_data_imaginary,
	input signed [15:0] subband_ch20_data_real,
	input signed [15:0] subband_ch20_data_imaginary,
	input signed [15:0] subband_ch21_data_real,
	input signed [15:0] subband_ch21_data_imaginary,
	input signed [15:0] subband_ch22_data_real,
	input signed [15:0] subband_ch22_data_imaginary,
	input signed [15:0] subband_ch23_data_real,
	input signed [15:0] subband_ch23_data_imaginary,
	input signed [15:0] subband_ch24_data_real,
	input signed [15:0] subband_ch24_data_imaginary,
	input signed [15:0] subband_ch25_data_real,
	input signed [15:0] subband_ch25_data_imaginary,
	input signed [15:0] subband_ch26_data_real,
	input signed [15:0] subband_ch26_data_imaginary,
	input signed [15:0] subband_ch27_data_real,
	input signed [15:0] subband_ch27_data_imaginary,
	input signed [15:0] subband_ch28_data_real,
	input signed [15:0] subband_ch28_data_imaginary,
	input signed [15:0] subband_ch29_data_real,
	input signed [15:0] subband_ch29_data_imaginary,
	input signed [15:0] subband_ch30_data_real,
	input signed [15:0] subband_ch30_data_imaginary,

	input reg subband_dataout_valid,
 
	output reg data_valid,
	output [63:0] up_data
);

	reg [3:0] cnt_16;				//用于实现16:1抽取

	wire [31:0] fifo_din [0:29];	//由于DSP地址原因，只能处理前27个信道

	reg din_valid;

	wire [63:0] dout [0:29];		//记录各个通道的输出	
	wire dout_valid [0:29];
	wire [10:0] rd_data_count [0:29]; 

	/*计数判断，实现16：1*/
	always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_16 <= 4'd0;
		end else begin
			if(cnt_16 == 4'd15 && subband_dataout_valid) begin
				cnt_16 <= 4'd0;
			end else if(subband_dataout_valid) begin
				cnt_16 <= cnt_16 + 4'd1;
			end else begin
				cnt_16 <= cnt_16;
			end
		end
	end

	integer i;

	/*将实部虚部拼接存储处理*/
	always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin 	//此段代码符合要求
			for(i = 0; i < 27; i = i + 1) begin
				fifo_din[i] <= 32'd0;
			end

			din_valid <= 1'd0;
		end else begin
			fifo_din[0] <= {subband_ch1_data_real,subband_ch1_data_imaginary};
			fifo_din[1] <= {subband_ch2_data_real,subband_ch2_data_imaginary};
			fifo_din[2] <= {subband_ch3_data_real,subband_ch3_data_imaginary};
			fifo_din[3] <= {subband_ch4_data_real,subband_ch4_data_imaginary};
			fifo_din[4] <= {subband_ch5_data_real,subband_ch5_data_imaginary};
			fifo_din[5] <= {subband_ch6_data_real,subband_ch6_data_imaginary};
			fifo_din[6] <= {subband_ch7_data_real,subband_ch7_data_imaginary};
			fifo_din[7] <= {subband_ch8_data_real,subband_ch8_data_imaginary};
			fifo_din[8] <= {subband_ch9_data_real,subband_ch9_data_imaginary};
			fifo_din[9] <= {subband_ch10_data_real,subband_ch10_data_imaginary};
			fifo_din[10] <= {subband_ch11_data_real,subband_ch11_data_imaginary};
			fifo_din[11] <= {subband_ch12_data_real,subband_ch12_data_imaginary};
			fifo_din[12] <= {subband_ch13_data_real,subband_ch13_data_imaginary};
			fifo_din[13] <= {subband_ch14_data_real,subband_ch14_data_imaginary};
			fifo_din[14] <= {subband_ch15_data_real,subband_ch15_data_imaginary};
			fifo_din[15] <= {subband_ch16_data_real,subband_ch16_data_imaginary};
			fifo_din[16] <= {subband_ch17_data_real,subband_ch17_data_imaginary};
			fifo_din[17] <= {subband_ch18_data_real,subband_ch18_data_imaginary};
			fifo_din[18] <= {subband_ch19_data_real,subband_ch19_data_imaginary};
			fifo_din[19] <= {subband_ch20_data_real,subband_ch20_data_imaginary};
			fifo_din[20] <= {subband_ch21_data_real,subband_ch21_data_imaginary};
			fifo_din[21] <= {subband_ch22_data_real,subband_ch22_data_imaginary};
			fifo_din[22] <= {subband_ch23_data_real,subband_ch23_data_imaginary};
			fifo_din[23] <= {subband_ch24_data_real,subband_ch24_data_imaginary};
			fifo_din[24] <= {subband_ch25_data_real,subband_ch25_data_imaginary};
			fifo_din[25] <= {subband_ch26_data_real,subband_ch26_data_imaginary};
			fifo_din[26] <= {subband_ch27_data_real,subband_ch27_data_imaginary};
			fifo_din[27] <= {subband_ch28_data_real,subband_ch28_data_imaginary};
			fifo_din[28] <= {subband_ch29_data_real,subband_ch29_data_imaginary};
			fifo_din[29] <= {subband_ch30_data_real,subband_ch30_data_imaginary};

			din_valid <= (cnt_16 == 4'd15 && subband_dataout_valid) ? 1'd1 : 1'd0;
		end
	end

	genvar j;
	generate for(j = 0; j < 27; j = j + 1) begin : generate_30_dcfifo_channel

		IBS_DATAFIFO_32IN_64OUT_4096DEPTH inst_IBS_DATAFIFO_32IN_64OUT_4096DEPTH (
			.wr_clk(main_clk),                // input wire wr_clk
			.rd_clk(rd_clk),                // input wire rd_clk
			.din(fifo_din[j]),                      // input wire [31 : 0] din
			.wr_en(din_valid),                  // input wire wr_en
			.rd_en(dout_valid[j]),                  // input wire rd_en
			.dout(dout[j]),                    // output wire [63 : 0] dout
			.full(),                    // output wire full
			.empty(),                  // output wire empty
			.rd_data_count(rd_data_count[j]),  // output wire [10 : 0] rd_data_count
			.wr_data_count()  // output wire [11 : 0] wr_data_count
		);

	end endgenerate

	Poll_Detect inst_Poll_Detect (
		.rd_clk(rd_clk),    //时钟与DCFIFO的rdclk保持一致
		.rst_n(rst_n),
		.rd_data_count(rd_data_count[0:29]),
		.dout(dout[0:29]),
		.dout_valid(dout_valid[0:29]),
		.data_valid(data_valid),
		.up_data(up_data)
	);

endmodule