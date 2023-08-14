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

	wire [13:0] ch1_wrusedw;

	reg ch1_rdreq;
	wire [12:0] ch1_rdusedw;
	reg [63:0] cnt_ch1;
	wire [63:0] ch1_q;
	
	
	wire [13:0] ch2_wrusedw;

	reg ch2_rdreq;
	wire [12:0] ch2_rdusedw;
	reg [63:0] cnt_ch2;
	wire [63:0] ch2_q;

	wire [13:0] ch3_wrusedw;

	reg ch3_rdreq;
	wire [12:0] ch3_rdusedw;
	reg [63:0] cnt_ch3;
	wire [63:0] ch3_q;

	wire [13:0] ch4_wrusedw;

	reg ch4_rdreq;
	wire [12:0] ch4_rdusedw;
	reg [63:0] cnt_ch4;
	wire [63:0] ch4_q;

	reg [2:0] access;
	reg [63:0] q_in;
	

	reg [63:0] cnt_ch;

	/***********************************************************************/
	/*缓存FIFO通道1*/
	/*通道1数据写出
	当检测到其他IP核输入到达阈值时，优先输出该IP核数据*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch1_rdreq <= 1'd0;
			cnt_ch1 <= 64'd0;
		end else if(ch1_rdusedw == 13'd128) begin
			ch1_rdreq <= 1'd1;
			cnt_ch1 <= cnt_ch1 + 64'd1;
		end else if(ch1_rdusedw == 13'd0 || ch2_rdusedw == 13'd128 || ch3_rdusedw == 13'd128 || ch4_rdusedw == 13'd128) begin
			ch1_rdreq <= 1'd0;
			cnt_ch1 <= cnt_ch1;
		end else if(cnt_ch1 % 128 == 64'd0) begin
			ch1_rdreq <= 1'd0;
			cnt_ch1 <= cnt_ch1;
		end else begin
			ch1_rdreq <= ch1_rdreq;
			if(ch1_rdreq) begin
				cnt_ch1 <= cnt_ch1 + 64'd1;
			end else begin
				cnt_ch1 <= cnt_ch1;
			end
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道2*/
	/*通道2数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch2_rdreq <= 1'd0;
			cnt_ch2 <= 64'd0;
		end else if(ch2_rdusedw == 13'd128) begin
			ch2_rdreq <= 1'd1;
			cnt_ch2 <= cnt_ch2 + 64'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_rdusedw == 13'd0 || ch3_rdusedw == 13'd128 || ch4_rdusedw == 13'd128) begin
			ch2_rdreq <= 1'd0;
			cnt_ch2 <= cnt_ch2;
		end else if(cnt_ch2 % 128 == 64'd0) begin
			ch2_rdreq <= 1'd0;
			cnt_ch2 <= cnt_ch2;
		end else begin
			ch2_rdreq <= ch2_rdreq;
			if(ch2_rdreq) begin
				cnt_ch2 <= cnt_ch2 + 64'd1;
			end else begin
				cnt_ch2 <= cnt_ch2;
			end
			
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道3*/
	/*通道3数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch3_rdreq <= 1'd0;
			cnt_ch3 <= 64'd0;
		end else if(ch3_rdusedw == 13'd128) begin
			ch3_rdreq <= 1'd1;
			cnt_ch3 <= cnt_ch3 + 64'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_rdusedw == 13'd128 || ch3_rdusedw == 13'd0 || ch4_rdusedw == 13'd128) begin
			ch3_rdreq <= 1'd0;
			cnt_ch3 <= cnt_ch3;
		end else if(cnt_ch3 % 128 == 64'd0) begin
			ch3_rdreq <= 1'd0;
			cnt_ch3 <= cnt_ch3;
		end else begin
			ch3_rdreq <= ch3_rdreq;
			if(ch3_rdreq) begin
				cnt_ch3 <= cnt_ch3 + 64'd1;
			end else begin
				cnt_ch3 <= cnt_ch3;
			end
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道4*/
	/*通道3数据写出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			ch4_rdreq <= 1'd0;
			cnt_ch4 <= 64'd0;
		end else if(ch4_rdusedw == 13'd128) begin
			ch4_rdreq <= 1'd1;
			cnt_ch4 <= cnt_ch4 + 64'd1;
		end else if(ch1_rdusedw == 13'd128 || ch2_rdusedw == 13'd128 || ch3_rdusedw == 13'd128 || ch4_rdusedw == 13'd0) begin
			ch4_rdreq <= 1'd0;
			cnt_ch4 <= cnt_ch4;
		end else if(cnt_ch4 % 128 == 64'd0) begin
			ch4_rdreq <= 1'd0;
			cnt_ch4 <= cnt_ch4;
		end else begin
			ch4_rdreq <= ch4_rdreq;
			if(ch4_rdreq) begin
				cnt_ch4 <= cnt_ch4 + 64'd1;
			end else begin
				cnt_ch4 <= cnt_ch4;
			end
		end
	end

	/***********************************************************************/

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_1 (
		.rdclk(fifo_rdclk),
		.rdreq(ch1_rdreq),
		.rdusedw(ch1_rdusedw),
		.q(ch1_q),
		.wrclk(ch1_wrclk),
		.wrreq(ch1_wrreq),
		.wrusedw(ch1_wrusedw),
		.data(ch1_data)
		);

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_2 (
		.rdclk(fifo_rdclk),
		.rdreq(ch2_rdreq),
		.rdusedw(ch2_rdusedw),
		.q(ch2_q),
		.wrclk(ch2_wrclk),
		.wrreq(ch2_wrreq),
		.wrusedw(ch2_wrusedw),
		.data(ch2_data));

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_3 (
		.rdclk(fifo_rdclk),
		.rdreq(ch3_rdreq),
		.rdusedw(ch3_rdusedw),
		.q(ch3_q),
		.wrclk(ch3_wrclk),
		.wrreq(ch3_wrreq),
		.wrusedw(ch3_wrusedw),
		.data(ch3_data));

	DCFIFO_32IN_64OUT_16384 DCFIFO_32IN_64OUT_16384_4 (
		.rdclk(fifo_rdclk),
		.rdreq(ch4_rdreq),
		.rdusedw(ch4_rdusedw),
		.q(ch4_q),
		.wrclk(ch4_wrclk),
		.wrreq(ch4_wrreq),
		.wrusedw(ch4_wrusedw),
		.data(ch4_data));

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			access <= 3'd0;
			q_in <= 64'd0;
			cnt_ch <= 64'd0;
		end else begin
			if(ch1_rdreq) begin
				access <= 3'd1;
				q_in <= ch1_q;
				cnt_ch <= cnt_ch1;
			end else if(ch2_rdreq) begin
				access <= 3'd2;
				q_in <= ch2_q;
				cnt_ch <= cnt_ch2;
			end else if(ch3_rdreq) begin
				access <= 3'd3;
				q_in <= ch3_q;
				cnt_ch <= cnt_ch3;
			end else if(ch4_rdreq) begin
				access <= 3'd4;
				q_in <= ch4_q;
				cnt_ch <= cnt_ch4;
			end else if(ch1_rdreq == 1'd0 && ch2_rdreq == 1'd0 && ch3_rdreq == 1'd0 && ch4_rdreq == 1'd0) begin
				access <= 3'd0;
				q_in <= 64'd0;
				cnt_ch <= 64'd0;
			end else begin
				access <= access;
				case(access) 
					3'd1 : begin
						q_in <= ch1_q;
						cnt_ch <= cnt_ch1;
					end 
					3'd2 : begin
						q_in <= ch2_q;
						cnt_ch <= cnt_ch2;
					end 
					3'd3 : begin
						q_in <= ch3_q;
						cnt_ch <= cnt_ch3;
					end 
					3'd4 : begin
						q_in <= ch4_q;
						cnt_ch <= cnt_ch4;
					end 
					default : begin
						q_in <= 64'd0;
						cnt_ch <= 64'd0;
					end 
				endcase
			end
		end
	end

	Poll_Detect Poll_Detect_1 (
		.fifo_rdclk(fifo_rdclk),    
		.rst_n(rst_n),
		.access(access),
		.q_in(q_in),
		.cnt_ch(cnt_ch),
		.data_valid(data_valid),
		.up_data(up_data)
);

endmodule