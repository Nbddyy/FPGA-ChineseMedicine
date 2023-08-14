
`timescale 1ns/1ps
module tb_FIFO_4_TEST (); /* this is automatically generated */

	reg [7:0] cnt_20;
	reg [7:0] cnt_15;
	reg [7:0] cnt_50;
	reg [7:0] cnt_100;

	reg fifo_rdclk;

	reg rst_n;
	
	reg ch_wrclk [3:0];
	reg ch_wrreq [3:0];
	reg [31:0] ch_data [3:0];

	wire data_valid;
	wire [63:0] up_data;

	initial begin
		fifo_rdclk = 1'd0;
		rst_n = 1'd0;
		ch_wrclk[0] = 1'd0;
		ch_wrclk[1] = 1'd0;
		ch_wrclk[2] = 1'd0;
		ch_wrclk[3] = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #5 ch_wrclk[0] <= ~ch_wrclk[0];
	always #5 ch_wrclk[1] <= ~ch_wrclk[1];
	always #5 ch_wrclk[2] <= ~ch_wrclk[2];
	always #5 ch_wrclk[3] <= ~ch_wrclk[3];

	always #10 fifo_rdclk <= ~fifo_rdclk;

	/***********************************************************************/
	/*通道1-20计数*/
	always@(posedge ch_wrclk[0] or negedge rst_n) begin
		if(~rst_n) begin
			cnt_20 <= 8'd0;
		end else if(cnt_20 == 8'd19) begin
			cnt_20 <= 8'd0;
		end else begin
			cnt_20 <= cnt_20 + 8'd1;
		end
	end

	/*通道2-15计数*/
	always@(posedge ch_wrclk[1] or negedge rst_n) begin
		if(~rst_n) begin
			cnt_15 <= 8'd0;
		end else if(cnt_15 == 8'd14) begin
			cnt_15 <= 8'd0;
		end else begin
			cnt_15 <= cnt_15 + 8'd1;
		end
	end

	/*通道3-50计数*/
	always@(posedge ch_wrclk[2] or negedge rst_n) begin
		if(~rst_n) begin
			cnt_50 <= 8'd0;
		end else if(cnt_50 == 8'd49) begin
			cnt_50 <= 8'd0;
		end else begin
			cnt_50 <= cnt_50 + 8'd1;
		end
	end

	/*通道4-100计数*/
	always@(posedge ch_wrclk[3] or negedge rst_n) begin
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
	always @(posedge ch_wrclk[0] or negedge rst_n) begin
		if(~rst_n) begin
			ch_data[0] <= 32'd0;
			ch_wrreq[0] <= 1'd0;
		end else if(cnt_20 == 8'd19) begin
			ch_data[0] <= {$random} % 256;
			ch_wrreq[0] <= 1'd1;
		end else begin
			ch_data[0] <= 32'd0;
			ch_wrreq[0] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道2*/
	/*DCFIFO通道2的输入代码实现*/
	always @(posedge ch_wrclk[1] or negedge rst_n) begin
		if(~rst_n) begin
			ch_data[1] <= 32'd0;
			ch_wrreq[1] <= 1'd0;
		end else if(cnt_15 == 8'd14) begin
			ch_data[1] <= {$random} % 256;
			ch_wrreq[1] <= 1'd1;
		end else begin
			ch_data[1] <= 32'd0;
			ch_wrreq[1] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道3*/
	/*DCFIFO通道3的输入代码实现*/
	always @(posedge ch_wrclk[2] or negedge rst_n) begin
		if(~rst_n) begin
			ch_data[2] <= 32'd0;
			ch_wrreq[2] <= 1'd0;
		end else if(cnt_50 == 8'd49) begin
			ch_data[2] <= {$random} % 256;
			ch_wrreq[2] <= 1'd1;
		end else begin
			ch_data[2] <= 32'd0;
			ch_wrreq[2] <= 1'd0;
		end
	end


	/***********************************************************************/

	/*缓存FIFO通道4*/
	/*DCFIFO通道4的输入代码实现*/
	always @(posedge ch_wrclk[3] or negedge rst_n) begin
		if(~rst_n) begin
			ch_data[3] <= 32'd0;
			ch_wrreq[3] <= 1'd0;
		end else if(cnt_100 == 8'd99) begin
			ch_data[3] <= {$random} % 256;
			ch_wrreq[3] <= 1'd1;
		end else begin
			ch_data[3] <= 32'd0;
			ch_wrreq[3] <= 1'd0;
		end
	end

	/*********************************************************/

	FIFO_4_TEST FIFO_4_TEST_1 (
		.fifo_rdclk(fifo_rdclk),
		.rst_n(rst_n),
		.ch_wrclk(ch_wrclk),
		.ch_wrreq(ch_wrreq),
		.ch_data(ch_data),
		.data_valid(data_valid),
		.up_data(up_data)
);

endmodule
