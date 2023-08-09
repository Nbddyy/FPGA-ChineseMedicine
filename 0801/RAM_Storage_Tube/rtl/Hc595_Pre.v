module Hc595_Pre (
	input clk,
	input rst_n,
	input [5:0] sel,
	input [7:0] sec,
	output reg shcp,
	output reg stcp,
	output reg ds,
	output reg oe
);

	reg [1:0] cnt;	//用于记录4个50mhz周期
	reg [3:0] cnt_num;	//用于记录6个位选和8个段选的依次输入依赖

	/*0、1、2、3四个位宽的计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 2'd0;
		end else begin
			cnt <= cnt + 2'd1;	//溢出置0
		end
	end

	/*记录0-13的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_num <= 4'd0;
		end else if(cnt_num == 4'd13 && cnt == 2'd3) begin
			cnt_num <= 4'd0;
		end else if(cnt == 2'd3) begin
			cnt_num <= cnt_num + 4'd1;
		end
	end

	/*实现shcp12.5mhz的移位*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			shcp <= 1'd0;
		end else if(cnt == 2'd2 || cnt == 2'd3) begin
			shcp <= 1'd1;
		end else begin
			shcp <= 1'd0;
		end
	end

	/*8个段选已经全部进入移位寄存器
	此时拉高stcp，将这八位段选锁存在存储寄存器中*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			stcp <= 1'd0;
		end else if(cnt_num == 4'd13 && cnt == 2'd3) begin
			stcp <= 1'd1;
		end else begin
			stcp <= 1'd0;
		end
	end

	/*实现0-13先6个位选再8个段选的依次输入
	注意：先进入的位网高位移动*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ds <= 0;
		end else if(cnt_num <= 4'd5 && cnt == 2'd0) begin
			ds <= sel[cnt_num];
		end else if(cnt_num <= 4'd13 && cnt == 2'd0) begin
			if(cnt_num == 4'd13) begin
				ds <= sec[0];
			end else begin
				ds <= sec[4'd13 - cnt_num];
			end
		end else begin
			ds <= ds;
		end
	end

	/*oe：存储寄存器输出使能信号
	oe为低电平有效*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			oe <= 1'd1;
		end else if(!sel) begin
			oe <= 1'd1;
		end else begin
			oe <= 1'd0;
		end
	end

endmodule