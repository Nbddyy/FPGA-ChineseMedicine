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
// Create : 2023-08-10 21:29:25
// Revise : 2023-08-10 21:29:25
// Editor : sublime text4, tab size (4)
// Descri : 4FIFO-不带帧头-用generate
// -----------------------------------------------------------------------------
module FIFO_4_TEST (
	input rst_n,
	input [7:0] random_data,
	input wrclk,
	input rdclk,
	output data_valid,
	output [63:0] up_data
);
	

	reg [7:0] cnt_20;
	reg [7:0] cnt_15;
	reg [7:0] cnt_50;
	reg [7:0] cnt_100;

	//定义DCFIFO各变量
	//数据写入端
	reg wrreq [3:0];
	reg [31:0] data [3:0];
	wire [13:0] wrusedw [3:0];

	//数据读出端
	reg rdreq [3:0];
	wire [12:0] rdusedw [3:0];
	wire [63:0] q [3:0];

	


	/***********************************************************************/
	/*通道1-20计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_20 <= 8'd0;
		end else if(cnt_20 == 8'd19) begin
			cnt_20 <= 8'd0;
		end else begin
			cnt_20 <= cnt_20 + 8'd1;
		end
	end

	/*通道2-15计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_15 <= 8'd0;
		end else if(cnt_15 == 8'd14) begin
			cnt_15 <= 8'd0;
		end else begin
			cnt_15 <= cnt_15 + 8'd1;
		end
	end

	/*通道3-50计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_50 <= 8'd0;
		end else if(cnt_50 == 8'd49) begin
			cnt_50 <= 8'd0;
		end else begin
			cnt_50 <= cnt_50 + 8'd1;
		end
	end

	/*通道4-100计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(cnt_100 == 8'd99) begin
			cnt_100 <= 8'd0;
		end else begin
			cnt_100 <= cnt_100 + 8'd1;
		end
	end

	/***********************************************************************/

	/***********************************************************************/
	/*缓存FIFO通道1*/
	/*DCFIFO通道1的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[0] <= 32'd0;
			wrreq[0] <= 1'd0;
		end else if(cnt_20 == 8'd19) begin
			data[0] <= random_data;
			wrreq[0] <= 1'd1;
		end else begin
			data[0] <= 32'd0;
			wrreq[0] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道2*/
	/*DCFIFO通道2的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[1] <= 32'd0;
			wrreq[1] <= 1'd0;
		end else if(cnt_15 == 8'd14) begin
			data[1] <= random_data;
			wrreq[1] <= 1'd1;
		end else begin
			data[1] <= 32'd0;
			wrreq[1] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道3*/
	/*DCFIFO通道3的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[2] <= 32'd0;
			wrreq[2] <= 1'd0;
		end else if(cnt_50 == 8'd49) begin
			data[2] <= random_data;
			wrreq[2] <= 1'd1;
		end else begin
			data[2] <= 32'd0;
			wrreq[2] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道4*/
	/*DCFIFO通道4的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[3] <= 32'd0;
			wrreq[3] <= 1'd0;
		end else if(cnt_100 == 8'd99) begin
			data[3] <= random_data;
			wrreq[3] <= 1'd1;
		end else begin
			data[3] <= 32'd0;
			wrreq[3] <= 1'd0;
		end
	end


	/***********************************************************************/


	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : generate_4_dcfifo
		DCFIFO_32IN_64OUT_16384 inst_DCFIFO_32IN_64OUT_16384 (
			.data(data[i]),
			.rdclk(rdclk),
			.rdreq(rdreq[i]),
			.wrclk(wrclk),
			.wrreq(wrreq[i]),
			.q(q[i]),
			.rdusedw(rdusedw[i]),
			.wrusedw(wrusedw[i]));
	end endgenerate


	Poll_Detect Poll_Detect_1 (
		.rdclk(rdclk),    //时钟与DCFIFO的rdclk保持一致
		.rst_n(rst_n),
		.rdusedw(rdusedw[3:0]),
		.q(q[3:0]),
		.rdreq(rdreq[3:0]),
		.data_valid(data_valid),
		.up_data(up_data)
);

endmodule