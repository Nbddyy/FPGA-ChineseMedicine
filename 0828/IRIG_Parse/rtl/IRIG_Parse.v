module IRIG_Parse
#(
	parameter bcode_0_flag = 24'd99_999,
	parameter bcode_1_flag = 24'd249_999,
	parameter bcode_p_flag = 24'd399_999
)
(
	input clk,
	input rst_n,
	input ex_bcode_signal,
	output reg [3:0] second_units,
	output reg [2:0] second_tens,
	output reg [3:0] minute_units,
	output reg [2:0] minute_tens,
	output reg [3:0] hour_units,
	output reg [1:0] hour_tens,
	output reg [3:0] day_units,
	output reg [3:0] day_tens,
	output reg [1:0] day_hunds,
	output reg [3:0] year_units,
	output reg [3:0] year_tens,
	output reg time_flag
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
			second_units <= 4'd0;
			second_tens <= 3'd0;
			minute_units <= 4'd0;
			minute_tens <= 3'd0;
			hour_units <= 4'd0;
			hour_tens <= 2'd0;
			day_units <= 4'd0;
			day_tens <= 4'd0;
			day_hunds <= 2'd0;
			year_units <= 4'd0;
			year_tens <= 4'd0;
		end else if(cnt_100 == 8'd65) begin
			second_units <= second_units_temp;
			second_tens <= second_tens_temp;
			minute_units <= minute_units_temp;
			minute_tens <= minute_tens_temp;
			hour_units <= hour_units_temp;
			hour_tens <= hour_tens_temp;
			day_units <= day_units_temp;
			day_tens <= day_tens_temp;
			day_hunds <= day_hunds_temp;
			year_units <= year_units_temp;
			year_tens <= year_tens_temp;
		end else begin
			second_units <= second_units;
			second_tens <= second_tens;
			minute_units <= minute_units;
			minute_tens <= minute_tens;
			hour_units <= hour_units;
			hour_tens <= hour_tens;
			day_units <= day_units;
			day_tens <= day_tens;
			day_hunds <= day_hunds;
			year_units <= year_units;
			year_tens <= year_tens;
		end
	end

	/*output time_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			time_flag <= 1'd0;
		end else if(cnt_100 == 8'd65) begin
			time_flag <= 1'd1;
		end else begin
			time_flag <= 1'd0;
		end
	end
	
endmodule