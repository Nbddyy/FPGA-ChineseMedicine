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
// File   : FIFO_4_TEST.v
// Create : 2023-08-10 16:54:25
// Revise : 2023-08-10 16:54:25
// Editor : sublime text4, tab size (4)
// Descri : 4FIFO-不带帧头-不用generate（Poll_Detect未用状态机）
// -----------------------------------------------------------------------------
module FIFO_4_TEST (
	input fifo_rdclk,

	input rst_n,
	input ch1_wrclk,
	input ch1_wrreq,
	input [31:0] ch1_data,

	input ch2_wrclk,
	input ch2_wrreq,
	input [31:0] ch2_data,

	input ch3_wrclk,
	input ch3_wrreq,
	input [31:0] ch3_data,

	input ch4_wrclk,
	input ch4_wrreq,
	input [31:0] ch4_data,

	output data_valid,
	output [63:0] up_data
);


	//定义FIFO端口变量
	reg ch1_rdreq;
	wire [63:0] ch1_q;
	wire [12:0] ch1_rdusedw;
	wire [13:0] ch1_wrusedw;

	reg ch2_rdreq;
	wire [63:0] ch2_q;
	wire [12:0] ch2_rdusedw;
	wire [13:0] ch2_wrusedw;

	reg ch3_rdreq;
	wire [63:0] ch3_q;
	wire [12:0] ch3_rdusedw;
	wire [13:0] ch3_wrusedw;

	reg ch4_rdreq;
	wire [63:0] ch4_q;
	wire [12:0] ch4_rdusedw;
	wire [13:0] ch4_wrusedw;

	reg [2:0] access;
	reg [63:0] q_in;

	//用于记录该通道上传数据的个数
	reg [7:0] ch1_cnt;
	reg [7:0] ch2_cnt;
	reg [7:0] ch3_cnt;
	reg [7:0] ch4_cnt;

	/***********************************************************************/
	/*缓存FIFO通道1*/
	/*通道1数据写出
	当检测到其他IP核输入到达阈值时，优先输出该IP核数据*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch1_rdreq <= 1'd0;
		end else if(ch1_rdusedw == 13'd128) begin
			ch1_rdreq <= 1'd1;
		end else if(ch1_cnt == 8'd127 || ch2_rdusedw == 13'd128 || ch3_rdusedw == 13'd128 || ch4_rdusedw == 13'd128) begin
			ch1_rdreq <= 1'd0;
		end else begin
			ch1_rdreq <= ch1_rdreq;
		end
	end

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch1_cnt <= 8'd0;
		end else if(ch1_rdreq) begin
			ch1_cnt <= ch1_cnt + 8'd1;
		end else begin
			ch1_cnt <= 8'd0;
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道2*/
	/*通道2数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch2_rdreq <= 1'd0;
		end else if(ch2_rdusedw == 13'd128) begin
			ch2_rdreq <= 1'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_cnt == 8'd127 || ch3_rdusedw == 13'd128 || ch4_rdusedw == 13'd128) begin
			ch2_rdreq <= 1'd0;
		end else begin
			ch2_rdreq <= ch2_rdreq;
		end
	end

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch2_cnt <= 8'd0;
		end else if(ch2_rdreq) begin
			ch2_cnt <= ch2_cnt + 8'd1;
		end else begin
			ch2_cnt <= 8'd0;
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道3*/
	/*通道3数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch3_rdreq <= 1'd0;
		end else if(ch3_rdusedw == 13'd128) begin
			ch3_rdreq <= 1'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_rdusedw == 13'd128 || ch3_cnt == 8'd127 || ch4_rdusedw == 13'd128) begin
			ch3_rdreq <= 1'd0;
		end else begin
			ch3_rdreq <= ch3_rdreq;
		end
	end

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch3_cnt <= 8'd0;
		end else if(ch3_rdreq) begin
			ch3_cnt <= ch3_cnt + 8'd1;
		end else begin
			ch3_cnt <= 8'd0;
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道4*/
	/*通道3数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch4_rdreq <= 1'd0;
		end else if(ch4_rdusedw == 13'd128) begin
			ch4_rdreq <= 1'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_rdusedw == 13'd128 || ch3_rdusedw == 13'd128 || ch4_cnt == 8'd127) begin
			ch4_rdreq <= 1'd0;
		end else begin
			ch4_rdreq <= ch4_rdreq;
		end
	end

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch4_cnt <= 8'd0;
		end else if(ch4_rdreq) begin
			ch4_cnt <= ch4_cnt + 8'd1;
		end else begin
			ch4_cnt <= 8'd0;
		end
	end

	/***********************************************************************/

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_1 (
		.data(ch1_data),
		.rdclk(fifo_rdclk),
		.rdreq(ch1_rdreq),
		.wrclk(ch1_wrclk),
		.wrreq(ch1_wrreq),
		.q(ch1_q),
		.rdusedw(ch1_rdusedw),
		.wrusedw(ch1_wrusedw));

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_2 (
		.data(ch2_data),
		.rdclk(fifo_rdclk),
		.rdreq(ch2_rdreq),
		.wrclk(ch2_wrclk),
		.wrreq(ch2_wrreq),
		.q(ch2_q),
		.rdusedw(ch2_rdusedw),
		.wrusedw(ch2_wrusedw));

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_3 (
		.data(ch3_data),
		.rdclk(fifo_rdclk),
		.rdreq(ch3_rdreq),
		.wrclk(ch3_wrclk),
		.wrreq(ch3_wrreq),
		.q(ch3_q),
		.rdusedw(ch3_rdusedw),
		.wrusedw(ch3_wrusedw));

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_4 (
		.data(ch4_data),
		.rdclk(fifo_rdclk),
		.rdreq(ch4_rdreq),
		.wrclk(ch4_wrclk),
		.wrreq(ch4_wrreq),
		.q(ch4_q),
		.rdusedw(ch4_rdusedw),
		.wrusedw(ch4_wrusedw));

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			access <= 3'd0;
			q_in <= 64'd0;
		end else begin
			if(ch1_rdusedw == 13'd128 && ch1_rdreq) begin
				access <= 3'd1;
				q_in <= ch1_q;
			end else if(ch2_rdusedw == 13'd128 && ch2_rdreq) begin
				access <= 3'd2;
				q_in <= ch2_q;
			end else if(ch3_rdusedw == 13'd128 && ch3_rdreq) begin
				access <= 3'd3;
				q_in <= ch3_q;
			end else if(ch4_rdusedw == 13'd128 && ch4_rdreq) begin
				access <= 3'd4;
				q_in <= ch4_q;
			end else if(ch1_cnt == 8'd128 || ch2_cnt == 8'd128 || ch3_cnt == 8'd128 || ch4_cnt == 8'd128) begin
				access <= 3'd0;
				q_in <= 64'd0;
			end else begin
				access <= access;
				case(access) 
					3'd1 : q_in <= ch1_q;
					3'd2 : q_in <= ch2_q;
					3'd3 : q_in <= ch3_q;
					3'd4 : q_in <= ch4_q;
					default : q_in <= 64'd0;
				endcase
			end
		end
	end

	Poll_Detect Poll_Detect_1 (
		.fifo_rdclk(fifo_rdclk),    
		.rst_n(rst_n),
		.access(access),
		.q_in(q_in),
		.data_valid(data_valid),
		.up_data(up_data)
);

endmodule