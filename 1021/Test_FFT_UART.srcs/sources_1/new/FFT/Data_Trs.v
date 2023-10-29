// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : bddyy N (China) qq1877117587@outlook.com
// File   : Data_Trs.v
// Create : 2023-10-24 16:34:08
// Revise : 2023-10-24 16:34:08
// Editor : sublime text4, tab size (4)
// Descri : 100MHz, 9600Bps, so the clock num is 10,416
// -----------------------------------------------------------------------------
module Data_Trs (
	input clk,
	input rst_n,  // Asynchronous reset active low
	input dataout_valid,

	input signed [23:0] X0_real,
	input signed [23:0] X0_imaginary,
	input signed [23:0] X1_real,
	input signed [23:0] X1_imaginary,
	input signed [23:0] X2_real,
	input signed [23:0] X2_imaginary,
	input signed [23:0] X3_real,
	input signed [23:0] X3_imaginary,
	input signed [23:0] X4_real,
	input signed [23:0] X4_imaginary,
	input signed [23:0] X5_real,
	input signed [23:0] X5_imaginary,
	input signed [23:0] X6_real,
	input signed [23:0] X6_imaginary,
	input signed [23:0] X7_real,
	input signed [23:0] X7_imaginary,

	output reg ip_flag,
	output reg signed [7:0] ip_data
);

	reg [7:0] cnt_data_frame;	//用于记录已发送的数据帧
	reg [15:0] cnt_calculate;	//用于FFT算法的计算耗时
	reg [15:0] cnt_send_data;	//用于发送给UART_Tx模块的数据间隔计数

	reg dataout_valid_latch;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_calculate <= 16'd0;
		end else if(!dataout_valid_latch) begin
			cnt_calculate <= 16'd0;
		end else if(cnt_calculate == 16'd65535) begin
			cnt_calculate <= cnt_calculate;
		end else begin
			cnt_calculate <= cnt_calculate + 16'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			dataout_valid_latch <= 1'd0;
		end else if(cnt_data_frame == 8'd48) begin
			dataout_valid_latch <= 1'd0;
		end else if(dataout_valid) begin
			dataout_valid_latch <= 1'd1;
		end else begin
			dataout_valid_latch <= dataout_valid_latch;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_send_data <= 16'd0;
		end else if(!dataout_valid_latch) begin
			cnt_send_data <= 16'd0;
		end else if(cnt_send_data == 16'd11_000) begin
			cnt_send_data <= 16'd0;
		end else begin
			cnt_send_data <= cnt_send_data + 16'd1;
		end
	end

	/*output ip_flag and ip_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_flag <= 1'd0;
			ip_data <= 8'd0;
			cnt_data_frame <= 8'd0;
		end else if(cnt_data_frame == 8'd48) begin
			ip_flag <= 1'd0;
			ip_data <= ip_data;
			cnt_data_frame <= 8'd0;
		end else if(!dataout_valid_latch) begin
			ip_flag <= 1'd0;
			ip_data <= ip_data;
			cnt_data_frame <= 8'd0;
		end else if(cnt_calculate == 16'd65535 && dataout_valid_latch && cnt_send_data == 16'd11_000) begin
			ip_flag <= 1'd1;
			cnt_data_frame <= cnt_data_frame + 8'd1;
			case(cnt_data_frame)
				8'd0 : ip_data <= X0_real[23:16];
				8'd1 : ip_data <= X0_real[15:8];
				8'd2 : ip_data <= X0_real[7:0];
				8'd3 : ip_data <= X0_imaginary[23:16];
				8'd4 : ip_data <= X0_imaginary[15:8];
				8'd5 : ip_data <= X0_imaginary[7:0];

				8'd6 : ip_data <= X1_real[23:16];
				8'd7 : ip_data <= X1_real[15:8];
				8'd8 : ip_data <= X1_real[7:0];
				8'd9 : ip_data <= X1_imaginary[23:16]; 
				8'd10 : ip_data <= X1_imaginary[15:8]; 
				8'd11 : ip_data <= X1_imaginary[7:0]; 

				8'd12 : ip_data <= X2_real[23:16];
				8'd13 : ip_data <= X2_real[15:8];
				8'd14 : ip_data <= X2_real[7:0];
				8'd15 : ip_data <= X2_imaginary[23:16];
				8'd16 : ip_data <= X2_imaginary[15:8];
				8'd17 : ip_data <= X2_imaginary[7:0];

				8'd18 : ip_data <= X3_real[23:16];
				8'd19 : ip_data <= X3_real[15:8];
				8'd20 : ip_data <= X3_real[7:0];
				8'd21 : ip_data <= X3_imaginary[23:16];
				8'd22 : ip_data <= X3_imaginary[15:8];
				8'd23 : ip_data <= X3_imaginary[7:0];

				8'd24 : ip_data <= X4_real[23:16];
				8'd25 : ip_data <= X4_real[15:8];
				8'd26 : ip_data <= X4_real[7:0];
				8'd27 : ip_data <= X4_imaginary[23:16];
				8'd28 : ip_data <= X4_imaginary[15:8];
				8'd29 : ip_data <= X4_imaginary[7:0];

				8'd30 : ip_data <= X5_real[23:16];
				8'd31 : ip_data <= X5_real[15:8];
				8'd32 : ip_data <= X5_real[7:0];
				8'd33 : ip_data <= X5_imaginary[23:16];
				8'd34 : ip_data <= X5_imaginary[15:8];
				8'd35 : ip_data <= X5_imaginary[7:0];

				8'd36 : ip_data <= X6_real[23:16];
				8'd37 : ip_data <= X6_real[15:8];
				8'd38 : ip_data <= X6_real[7:0];
				8'd39 : ip_data <= X6_imaginary[23:16];
				8'd40 : ip_data <= X6_imaginary[15:8];
				8'd41 : ip_data <= X6_imaginary[7:0];

				8'd42 : ip_data <= X7_real[23:16];
				8'd43 : ip_data <= X7_real[15:8];
				8'd44 : ip_data <= X7_real[7:0];
				8'd45 : ip_data <= X7_imaginary[23:16];
				8'd46 : ip_data <= X7_imaginary[15:8];
				8'd47 : ip_data <= X7_imaginary[7:0];
				default : ip_data <= ip_data;
			endcase
		end else begin
			ip_flag <= 1'd0;
			ip_data <= ip_data;
			cnt_data_frame <= cnt_data_frame;
		end
	end

endmodule