module SIGNAL_DET
(
	input clk,
	input rst_n,
	input signal,	//通过仿真控制反转时间控制输入信号的频率

	output reg [31:0] input_time,	//时间单位为ns
	output reg [31:0] frequency	//频率单位为Hz
);

	reg ex_sig_r1;
	reg ex_sig_r2;
	reg ex_sig_r1_n;
	reg ex_sig_r2_n;
	wire signal_rise_det;
	wire signal_fall_det;
	wire signal_edge_det;
	reg [31:0] time_s;

	//对输入信号偏移一个周期得到r1，对r1偏移一个周期得到r2
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_r1 <= 1'd0;
			ex_sig_r2 <= 1'd0;
		end else begin
			ex_sig_r1 <= signal;
			ex_sig_r2 <= ex_sig_r1;
		end
	end

	/*对r1，r2进行反转*/
	always@(*) begin
		if(~rst_n) begin
			ex_sig_r1_n = 1'd0;
			ex_sig_r2_n = 1'd0;
		end else begin
			ex_sig_r1_n = ~ex_sig_r1;
			ex_sig_r2_n = ~ex_sig_r2;
		end
	end

	/*
	signal_rise_det = ex_sig_r1 && !ex_sig_r2
	signal_fall_det = ex_sig_r2 && !ex_sig_r1
	*/
	assign signal_rise_det = ex_sig_r1 && ex_sig_r2_n;
	assign signal_fall_det = ex_sig_r2 && ex_sig_r1_n;

	//对两个取反信号变量进行异或得到新的波形图
	assign signal_edge_det = signal_rise_det ^ signal_fall_det;

	/*实现对输入信号的高电平时间计算*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			time_s <= 32'd0;
			input_time <= 32'd0;
		end else if(signal_edge_det == 1'd1)begin
			input_time <= time_s + 32'd20;
			time_s <= 32'd0;
		end else begin
			time_s <= time_s + 20;
			input_time <= input_time;
		end
	end

	/*计算输入信号的频率*/
	always@(*) begin
		if(!rst_n) begin
			frequency = 32'd0;
		end else begin
			frequency = (1_000_000_000 / input_time) >> 1;
		end
	end

endmodule