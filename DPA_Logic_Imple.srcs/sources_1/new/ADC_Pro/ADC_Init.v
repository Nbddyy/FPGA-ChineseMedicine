// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy jeon (Kris) qq1877117587@outlook.com
// File   : ADC_Init.v
// Create : 2023-10-28 09:21:44
// Revise : 2023-10-28 09:21:44
// Editor : sublime text4, tab size (4)
// Descri : 等待ADS42LB69上电后进行软复位操作，该ADC芯片工作频率为250MHz
// -----------------------------------------------------------------------------
module ADC_Init 
#(	//ADC芯片要求执行的最小时序要求
	parameter pow_on_delay = 24'd260_000,
	parameter reset_wid = 24'd260_100,	// 10ns <= time <= 1us
	parameter regist_delay = 24'd260_200
)
(
	input clk,    			// Clock
	input rst_n,  			// Asynchronous reset active low
	output init_comple,	//对ADC芯片初始软复位的完成标志
	output reset			//控制复位
);

	reg [23:0] cnt_time_min;

	//定义状态
	parameter IDLE = 4'b0001;
	parameter RESET = 4'b0010;
	parameter WRDELAY = 4'b0100;
	parameter COMPLE = 4'b1000;

	reg [3:0] init_status;

	/*cnt_time_min计数用于状态跳转判断*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_time_min <= 0;
		end else if(init_status == COMPLE) begin
			cnt_time_min <= cnt_time_min;
		end else begin
			cnt_time_min <= cnt_time_min + 24'd1;
		end
	end

	/*init_status transition*/
	always @(posedge clk or negedge rst_n) begin : proc_init_status
		if(~rst_n) begin
			init_status <= IDLE;
		end else begin
			case(init_status)
				IDLE : init_status <= (cnt_time_min == pow_on_delay) ? RESET : init_status;
				RESET : init_status <= (cnt_time_min == reset_wid) ? WRDELAY : init_status;
				WRDELAY : init_status <= (cnt_time_min == regist_delay) ? COMPLE : init_status;
				COMPLE : init_status <= init_status;
				default : init_status <= init_status;
			endcase
		end
	end

	/*output reset*/
	assign reset = (init_status == RESET) ? 1'd1 : 1'd0;

	/*output init_comple*/
	assign init_comple = (init_status == COMPLE) ? 1'd1 : 1'd0;

endmodule