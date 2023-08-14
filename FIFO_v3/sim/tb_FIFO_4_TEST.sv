
`timescale 1ns/1ps
module tb_FIFO_4_TEST (); /* this is automatically generated */

	// asynchronous reset
	reg rst_n;

	//定义每个通道数据来临的cnt
	reg [7:0] cnt_20;
	reg [7:0] cnt_15;
	reg [7:0] cnt_50;
	reg [7:0] cnt_100;

	// (*NOTE*) replace reset, clock, others
	reg        fifo_rdclk;
	reg        ch1_wrclk;
	reg        ch1_wrreq;
	reg [31:0] ch1_data;
	reg        ch2_wrclk;
	reg        ch2_wrreq;
	reg [31:0] ch2_data;
	reg        ch3_wrclk;
	reg        ch3_wrreq;
	reg [31:0] ch3_data;
	reg        ch4_wrclk;
	reg        ch4_wrreq;
	reg [31:0] ch4_data;
	reg        data_valid;
	reg [63:0] up_data;


	initial begin
		rst_n <= 1'd0;
		fifo_rdclk <= 1'd0;
		ch1_wrclk <= 1'd0;
		ch2_wrclk <= 1'd0;
		ch3_wrclk <= 1'd0;
		ch4_wrclk <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	always #10 fifo_rdclk <= ~fifo_rdclk;

	always #5 ch1_wrclk <= ~ch1_wrclk;	//100MHz
	always #5 ch2_wrclk <= ~ch2_wrclk;
	always #5 ch3_wrclk <= ~ch3_wrclk;
	always #5 ch4_wrclk <= ~ch4_wrclk;


	/*********************************************************/
	/*各个缓存通道cnt计数*/
	always@(posedge ch1_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_20 <= 8'd0;
		end else if(cnt_20 == 8'd19) begin
			cnt_20 <= 8'd0;
		end else begin
			cnt_20 <= cnt_20 + 8'd1;
		end
	end

	always@(posedge ch2_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_15 <= 8'd0;
		end else if(cnt_15 == 8'd14) begin
			cnt_15 <= 8'd0;
		end else begin
			cnt_15 <= cnt_15 + 8'd1;
		end
	end

	always@(posedge ch3_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_50 <= 8'd0;
		end else if(cnt_50 == 8'd49) begin
			cnt_50 <= 8'd0;
		end else begin
			cnt_50 <= cnt_50 + 8'd1;
		end
	end

	always@(posedge ch4_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(cnt_100 == 8'd99) begin
			cnt_100 <= 8'd0;
		end else begin
			cnt_100 <= cnt_100 + 8'd1;
		end
	end

	/*********************************************************/
	/*CH1_FIFO的输入代码体现*/
	always@(posedge ch1_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			ch1_wrreq <= 1'd0;
			ch1_data <= 32'd0;
		end else if(cnt_20 == 8'd19) begin
			ch1_wrreq <= 1'd1;
			ch1_data <= {$random} % 256;
		end else begin
			ch1_wrreq <= 1'd0;
			ch1_data <= 32'd0;
		end
	end 

	/*CH2_FIFO的输入代码体现*/
	always@(posedge ch2_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			ch2_wrreq <= 1'd0;
			ch2_data <= 32'd0;
		end else if(cnt_15 == 8'd14) begin
			ch2_wrreq <= 1'd1;
			ch2_data <= {$random} % 256;
		end else begin
			ch2_wrreq <= 1'd0;
			ch2_data <= 32'd0;
		end
	end 

	/*CH3_FIFO的输入代码体现*/
	always@(posedge ch3_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			ch3_wrreq <= 1'd0;
			ch3_data <= 32'd0;
		end else if(cnt_50 == 8'd49) begin
			ch3_wrreq <= 1'd1;
			ch3_data <= {$random} % 256;
		end else begin
			ch3_wrreq <= 1'd0;
			ch3_data <= 32'd0;
		end
	end 

	/*CH4_FIFO的输入代码体现*/
	always@(posedge ch4_wrclk or negedge rst_n) begin
		if(~rst_n) begin
			ch4_wrreq <= 1'd0;
			ch4_data <= 32'd0;
		end else if(cnt_100 == 8'd99) begin
			ch4_wrreq <= 1'd1;
			ch4_data <= {$random} % 256;
		end else begin
			ch4_wrreq <= 1'd0;
			ch4_data <= 32'd0;
		end
	end 

	/*********************************************************/

	FIFO_4_TEST inst_FIFO_4_TEST
		(
			.fifo_rdclk (fifo_rdclk),
			.rst_n      (rst_n),
			.ch1_wrclk  (ch1_wrclk),
			.ch1_wrreq  (ch1_wrreq),
			.ch1_data   (ch1_data),
			.ch2_wrclk  (ch2_wrclk),
			.ch2_wrreq  (ch2_wrreq),
			.ch2_data   (ch2_data),
			.ch3_wrclk  (ch3_wrclk),
			.ch3_wrreq  (ch3_wrreq),
			.ch3_data   (ch3_data),
			.ch4_wrclk  (ch4_wrclk),
			.ch4_wrreq  (ch4_wrreq),
			.ch4_data   (ch4_data),
			.data_valid (data_valid),
			.up_data    (up_data)
		);

endmodule
