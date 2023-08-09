`timescale 1ns/1ns

module SIGNAL_DET_tb ();

	reg clk;
	reg rst_n;
	reg signal;
	wire time_s;
	wire frequency;

	initial begin
		clk <= 1'd0;
		signal <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;	
	end


	always #10 clk <= ~clk;

	/*该边沿检测存在漏洞，只有当输入信号的周期为20ns的整数倍时其计算结果才正确，需优化*/
	always #130 signal <= ~signal;

	SIGNAL_DET SIGNAL_DET_1
	(
		.clk(clk),
		.rst_n(rst_n),
		.signal(signal),	//通过仿真控制反转时间控制输入信号的频率
		.input_time(input_time),	//时间单位为ns
		.frequency(frequency)	//频率单位为Hz
	);


endmodule