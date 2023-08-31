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
// File   : IRIG_Parse.v
// Create : 2023-08-29 16:37:34
// Revise : 2023-08-29 16:37:34
// Editor : sublime text4, tab size (4)
// Descri : 不采取寄存，而是利用cnt计数10ms间隔将数据帧有效数据依次发送给UART_Tx模块，详见280行
// -----------------------------------------------------------------------------
module IRIG_Parse
#(
	parameter bcode_0_flag = 24'd249_999,
	parameter bcode_1_flag = 24'd624_999,
	parameter bcode_p_flag = 24'd999_999
)
(
	input clk,
	input rst_n,
	input ex_bcode_signal,
	output reg [7:0] ip_data,
	output reg ip_flag
);

	reg [3:0] second_units_temp;
	reg [2:0] second_tens_temp;
	reg [3:0] minute_units_temp;
	reg [2:0] minute_tens_temp;
	reg [3:0] hour_units_temp;
	reg [1:0] hour_tens_temp;
	reg [3:0] day_units_temp;
	reg [3:0] day_tens_temp;
	reg [1:0] day_hunds_temp;
	reg [3:0] year_units_temp;
	reg [3:0] year_tens_temp;

	/*1 首先需要检测双"P"信号开始读取码元
	2 对码元进行计数
	3 判断码元类型
	4 输出对应的时分秒*/

	/*打两拍拿到上升沿和下降沿检测信号*/
	reg ex_bcode_signal_clap_1;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_bcode_signal_clap_1 <= 1'd0;
		end else begin
			ex_bcode_signal_clap_1 <= ex_bcode_signal;
		end
	end

	reg ex_bcode_signal_clap_2;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ex_bcode_signal_clap_2 <= 1'd0;
		end else begin
			ex_bcode_signal_clap_2 <= ex_bcode_signal_clap_1;
		end
	end

	/*延时一个clk得到的上升沿和下降沿*/
	wire sig_rise_det;
	wire sig_fall_det;
	assign sig_rise_det = ex_bcode_signal_clap_1 && !ex_bcode_signal_clap_2;
	assign sig_fall_det = ex_bcode_signal_clap_2 && !ex_bcode_signal_clap_1;

	/*对sig_fall_det进行打拍用于记录码元序号*/
	reg sig_fall_det_2;
	reg sig_fall_det_3;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sig_fall_det_2 <= 1'd0;
			sig_fall_det_3 <= 1'd0;
		end else begin
			sig_fall_det_2 <= sig_fall_det;
			sig_fall_det_3 <= sig_fall_det_2;
		end
	end

	/*进行码元锁存用来判断双"P"码元*/
	reg [7:0] bcode_latch;
	reg start_flag;

	/*用来记录码元高电平时间从而判断码元类型，低电平处理数据*/
	reg [23:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 24'd0;
		end else if(ex_bcode_signal_clap_1) begin
			cnt <= cnt + 24'd1;
		end else begin
			cnt <= 24'd0;
		end
	end


	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bcode_latch <= 8'd0;
		end else if(sig_fall_det) begin
			// case(cnt) 
			// 	bcode_0_flag : bcode_latch <= 8'd48;
			// 	bcode_1_flag : bcode_latch <= 8'd49;
			// 	bcode_p_flag : bcode_latch <= 8'd112;
			// 	default : bcode_latch <= 8'd0;
			// endcase

			//引入误差概念
			if(cnt >= bcode_p_flag - 24'd3 && cnt <= bcode_p_flag + 24'd3) begin
				bcode_latch <= 8'd112;
			end else if(cnt >= bcode_1_flag - 24'd3 && cnt <= bcode_1_flag + 24'd3) begin
				bcode_latch <= 8'd49;
			end else if(cnt >= bcode_0_flag - 24'd3 && cnt <= bcode_0_flag + 24'd3) begin
				bcode_latch <= 8'd48;
			end else begin
				bcode_latch <= 8'd0;
			end

		end else begin
			bcode_latch <= bcode_latch;
		end
	end

	/*开始编码标志*/
	reg [7:0] cnt_100;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			start_flag <= 1'd0;
		end else if(cnt_100 == 8'd98) begin
			start_flag <= 1'd0;
		end else if(bcode_latch == 8'd112 && cnt >= bcode_p_flag - 24'd3 && cnt <= bcode_p_flag + 24'd3) begin
			start_flag <= 1'd1;
		end else begin
			start_flag <= start_flag;
		end
	end

	/*码元序号计数，用于后续对时分秒的计算*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(!start_flag) begin
			cnt_100 <= 8'd0;
		end else if(start_flag == 1'd1 && sig_fall_det_2) begin
			cnt_100 <= cnt_100 + 8'd1;
		end else begin
			cnt_100 <= cnt_100;
		end
	end

	/*对码元进行解码，从而得到时分秒数据*/
	/*秒个位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			second_units_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd2 && cnt_100 <= 8'd5)) begin
			second_units_temp <= {bcode_latch,{second_units_temp[3:1]}};
		end else begin
			second_units_temp <= second_units_temp;
		end
	end

	/*秒十位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			second_tens_temp <= 3'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd7 && cnt_100 <= 8'd9)) begin
			second_tens_temp <= {bcode_latch,{second_tens_temp[2:1]}};
		end else begin
			second_tens_temp <= second_tens_temp;
		end
	end

	/*分个位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			minute_units_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd11 && cnt_100 <= 8'd14)) begin
			minute_units_temp <= {bcode_latch,{minute_units_temp[3:1]}};
		end else begin
			minute_units_temp <= minute_units_temp;
		end
	end
	
	/*分十位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			minute_tens_temp <= 3'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd16 && cnt_100 <= 8'd18)) begin
			minute_tens_temp <= {bcode_latch,{minute_tens_temp[2:1]}};
		end else begin
			minute_tens_temp <= minute_tens_temp;
		end
	end

	/*时个位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			hour_units_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd21 && cnt_100 <= 8'd24)) begin
			hour_units_temp <= {bcode_latch,{hour_units_temp[3:1]}};
		end else begin
			hour_units_temp <= hour_units_temp;
		end
	end

	/*时十位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			hour_tens_temp <= 2'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd26 && cnt_100 <= 8'd27)) begin
			hour_tens_temp <= {bcode_latch,{hour_tens_temp[1]}};
		end else begin
			hour_tens_temp <= hour_tens_temp;
		end
	end

	/*天个位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			day_units_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd31 && cnt_100 <= 8'd34)) begin
			day_units_temp <= {bcode_latch,{day_units_temp[3:1]}};
		end else begin
			day_units_temp <= day_units_temp;
		end
	end

	/*天十位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			day_tens_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd36 && cnt_100 <= 8'd39)) begin
			day_tens_temp <= {bcode_latch,{day_tens_temp[3:1]}};
		end else begin
			day_tens_temp <= day_tens_temp;
		end
	end

	/*天百位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			day_hunds_temp <= 2'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd41 && cnt_100 <= 8'd42)) begin
			day_hunds_temp <= {bcode_latch,{day_hunds_temp[1]}};
		end else begin
			day_hunds_temp <= day_hunds_temp;
		end
	end

	/*年个位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			year_units_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd51 && cnt_100 <= 8'd54)) begin
			year_units_temp <= {bcode_latch,{year_units_temp[3:1]}};
		end else begin
			year_units_temp <= year_units_temp;
		end
	end

	/*年十位*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			year_tens_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 8'd56 && cnt_100 <= 8'd59)) begin
			year_tens_temp <= {bcode_latch,{year_tens_temp[3:1]}};
		end else begin
			year_tens_temp <= year_tens_temp;
		end
	end


	/*码元序号到达65时进行输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_data <= 8'd0;
			ip_flag <= 1'd0;
		end else if(cnt_100 == 8'd61 && sig_fall_det_3) begin 	//T
			ip_flag <= 1'd1;
			ip_data <= 8'h54;
		end else if(cnt_100 == 8'd62 && sig_fall_det_3) begin 	//I
			ip_flag <= 1'd1;
			ip_data <= 8'h49;
		end else if(cnt_100 == 8'd63 && sig_fall_det_3) begin 	//M
			ip_flag <= 1'd1;
			ip_data <= 8'h4D;
		end else if(cnt_100 == 8'd64 && sig_fall_det_3) begin 	//E
			ip_flag <= 1'd1;
			ip_data <= 8'h45;
		end else if(cnt_100 == 8'd65 && sig_fall_det_3) begin 	//:
			ip_flag <= 1'd1;
			ip_data <= 8'h3A;
		end else if(cnt_100 == 8'd66 && sig_fall_det_3) begin 	//2
			ip_flag <= 1'd1;
			ip_data <= 8'h32;
		end else if(cnt_100 == 8'd67 && sig_fall_det_3) begin 	//0
			ip_flag <= 1'd1;
			ip_data <= 8'h30;
		end else if(cnt_100 == 8'd68 && sig_fall_det_3) begin 	//year_tens_temp
			ip_flag <= 1'd1; 
			case(year_tens_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd69 && sig_fall_det_3) begin 	//year_units_temp
			ip_flag <= 1'd1;
			case(year_units_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd70 && sig_fall_det_3) begin 	//-
			ip_flag <= 1'd1;
			ip_data <= 8'h2D;
		end else if(cnt_100 == 8'd71 && sig_fall_det_3) begin 	//day_hunds_temp
			ip_flag <= 1'd1;
			case(day_hunds_temp) 
				2'd0 : ip_data <= 8'h30;
				2'd1 : ip_data <= 8'h31;
				2'd2 : ip_data <= 8'h32;
				2'd3 : ip_data <= 8'h33;
				2'd4 : ip_data <= 8'h34;
				2'd5 : ip_data <= 8'h35;
				2'd6 : ip_data <= 8'h36;
				2'd7 : ip_data <= 8'h37;
				2'd8 : ip_data <= 8'h38;
				2'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd72 && sig_fall_det_3) begin 	//day_tens_temp
			ip_flag <= 1'd1;
			case(day_tens_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd73 && sig_fall_det_3) begin 	//day_units_temp
			ip_flag <= 1'd1;
			case(day_units_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd74 && sig_fall_det_3) begin 	//d
			ip_flag <= 1'd1;
			ip_data <= 8'h64;
		end else if(cnt_100 == 8'd75 && sig_fall_det_3) begin 	//a
			ip_flag <= 1'd1;
			ip_data <= 8'h61;
		end else if(cnt_100 == 8'd76 && sig_fall_det_3) begin 	//y
			ip_flag <= 1'd1;
			ip_data <= 8'h79;
		end else if(cnt_100 == 8'd77 && sig_fall_det_3) begin 	//-
			ip_flag <= 1'd1;
			ip_data <= 8'h2D;
		end else if(cnt_100 == 8'd78 && sig_fall_det_3) begin 	//hour_tens_temp
			ip_flag <= 1'd1;
			case(hour_tens_temp) 
				2'd0 : ip_data <= 8'h30;
				2'd1 : ip_data <= 8'h31;
				2'd2 : ip_data <= 8'h32;
				2'd3 : ip_data <= 8'h33;
				2'd4 : ip_data <= 8'h34;
				2'd5 : ip_data <= 8'h35;
				2'd6 : ip_data <= 8'h36;
				2'd7 : ip_data <= 8'h37;
				2'd8 : ip_data <= 8'h38;
				2'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd79 && sig_fall_det_3) begin 	//hour_units_temp
			ip_flag <= 1'd1;
			case(hour_units_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd80 && sig_fall_det_3) begin 	//:
			ip_flag <= 1'd1;
			ip_data <= 8'h3A;
		end else if(cnt_100 == 8'd81 && sig_fall_det_3) begin 	//minute_tens_temp
			ip_flag <= 1'd1;
			case(minute_tens_temp) 
				3'd0 : ip_data <= 8'h30;
				3'd1 : ip_data <= 8'h31;
				3'd2 : ip_data <= 8'h32;
				3'd3 : ip_data <= 8'h33;
				3'd4 : ip_data <= 8'h34;
				3'd5 : ip_data <= 8'h35;
				3'd6 : ip_data <= 8'h36;
				3'd7 : ip_data <= 8'h37;
				3'd8 : ip_data <= 8'h38;
				3'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd82 && sig_fall_det_3) begin 	//minute_units_temp
			ip_flag <= 1'd1;
			case(minute_units_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd83 && sig_fall_det_3) begin 	//:
			ip_flag <= 1'd1;
			ip_data <= 8'h3A;
		end else if(cnt_100 == 8'd84 && sig_fall_det_3) begin 	//second_tens_temp
			ip_flag <= 1'd1;
			case(second_tens_temp) 
				3'd0 : ip_data <= 8'h30;
				3'd1 : ip_data <= 8'h31;
				3'd2 : ip_data <= 8'h32;
				3'd3 : ip_data <= 8'h33;
				3'd4 : ip_data <= 8'h34;
				3'd5 : ip_data <= 8'h35;
				3'd6 : ip_data <= 8'h36;
				3'd7 : ip_data <= 8'h37;
				3'd8 : ip_data <= 8'h38;
				3'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else if(cnt_100 == 8'd85 && sig_fall_det_3) begin 	//second_units_temp
			ip_flag <= 1'd1;
			case(second_units_temp) 
				4'd0 : ip_data <= 8'h30;
				4'd1 : ip_data <= 8'h31;
				4'd2 : ip_data <= 8'h32;
				4'd3 : ip_data <= 8'h33;
				4'd4 : ip_data <= 8'h34;
				4'd5 : ip_data <= 8'h35;
				4'd6 : ip_data <= 8'h36;
				4'd7 : ip_data <= 8'h37;
				4'd8 : ip_data <= 8'h38;
				4'd9 : ip_data <= 8'h39;
				default : ip_data <= 8'd0;
			endcase
		end else begin
			ip_data <= ip_data;
			ip_flag <= 1'd0;
		end
	end

	
endmodule