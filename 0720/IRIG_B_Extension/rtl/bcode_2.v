module bcode_2 
#(
	parameter bcode_0_flag = 32'd249_999,
	parameter bcode_1_flag = 32'd624_999,
	parameter bcode_p_flag = 32'd999_999
)
(
	input clk_125mhz,
	input rst_n,
	input ex_bcode_signal,
	output reg [3:0] miao_gewei,
	output reg [2:0] miao_shiwei,
	output reg [3:0] fen_gewei,
	output reg [2:0] fen_shiwei,
	output reg [3:0] shi_gewei,
	output reg [1:0] shi_shiwei,
	output reg [3:0] day_gewei,
	output reg [3:0] day_shiwei,
	output reg [1:0] day_baiwei,
	output reg [3:0] year_gewei,
	output reg [3:0] year_shiwei
);

	reg [3:0] miao_gewei_temp;
	reg [2:0] miao_shiwei_temp;
	reg [3:0] fen_gewei_temp;
	reg [2:0] fen_shiwei_temp;
	reg [3:0] shi_gewei_temp;
	reg [1:0] shi_shiwei_temp;
	reg [3:0] day_gewei_temp;
	reg [3:0] day_shiwei_temp;
	reg [1:0] day_baiwei_temp;
	reg [3:0] year_gewei_temp;
	reg [3:0] year_shiwei_temp;

	/*1 首先需要检测双"P"信号开始读取码元
	2 对码元进行计数
	3 判断码元类型
	4 输出对应的时分秒*/

	/*打两拍拿到上升沿和下降沿检测信号*/
	reg ex_sig_clap_1;
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_clap_1 <= 1'd0;
		end else begin
			ex_sig_clap_1 <= ex_bcode_signal;
		end
	end

	reg ex_sig_clap_2;
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			ex_sig_clap_2 <= 1'd0;
		end else begin
			ex_sig_clap_2 <= ex_sig_clap_1;
		end
	end

	/*延时一个clk得到的上升沿和下降沿*/
	wire sig_rise_det;
	wire sig_fall_det;
	assign sig_rise_det = ex_sig_clap_1 && !ex_sig_clap_2;
	assign sig_fall_det = ex_sig_clap_2 && !ex_sig_clap_1;

	/*对sig_fall_det进行打拍用于记录码元序号*/
	reg sig_fall_det_2;
	reg sig_fall_det_3;
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			sig_fall_det_2 <= 1'd0;
			sig_fall_det_3 <= 1'd0;
		end else begin
			sig_fall_det_2 <= sig_fall_det;
			sig_fall_det_3 <= sig_fall_det_2;
		end
	end

	/*进行码元锁存用来判断双"P"码元*/
	reg [31:0] bcode_latch;
	reg start_flag;

	/*用来记录码元高电平时间从而判断码元类型，低电平处理数据*/
	reg [31:0] cnt_flag;
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			cnt_flag <= 32'd0;
		end else if(ex_sig_clap_1) begin
			cnt_flag <= cnt_flag + 32'd1;
		end else begin
			cnt_flag <= 32'd0;
		end
	end


	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			bcode_latch <= 32'd0;
		end else if(sig_fall_det) begin
			case(cnt_flag) 
				bcode_0_flag : bcode_latch <= 32'd48;
				bcode_1_flag : bcode_latch <= 32'd49;
				bcode_p_flag : bcode_latch <= 32'd112;
				default : bcode_latch <= 32'd0;
			endcase
		end else begin
			bcode_latch <= bcode_latch;
		end
	end

	/*开始编码标志*/
	reg [6:0] cnt_100;
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			start_flag <= 1'd0;
		end else if(cnt_100 == 7'd70) begin
			start_flag <= 1'd0;
		end else if(bcode_latch == 32'd112 && cnt_flag == bcode_p_flag) begin
			start_flag <= 1'd1;
		end else begin
			start_flag <= start_flag;
		end
	end

	/*码元序号计数，用于后续对时分秒的计算*/
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 7'd0;
		end else if(!start_flag) begin
			cnt_100 <= 7'd0;
		end else if(start_flag == 1'd1 && sig_fall_det_2) begin
			cnt_100 <= cnt_100 + 7'd1;
		end else begin
			cnt_100 <= cnt_100;
		end
	end

	/*对码元进行解码，从而得到时分秒数据*/
	/*秒个位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			miao_gewei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd2 && cnt_100 <= 7'd5)) begin
			miao_gewei_temp <= {bcode_latch,{miao_gewei_temp[3:1]}};
		end else begin
			miao_gewei_temp <= miao_gewei_temp;
		end
	end

	/*秒十位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			miao_shiwei_temp <= 3'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd7 && cnt_100 <= 7'd9)) begin
			miao_shiwei_temp <= {bcode_latch,{miao_shiwei_temp[2:1]}};
		end else begin
			miao_shiwei_temp <= miao_shiwei_temp;
		end
	end

	/*分个位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			fen_gewei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd11 && cnt_100 <= 7'd14)) begin
			fen_gewei_temp <= {bcode_latch,{fen_gewei_temp[3:1]}};
		end else begin
			fen_gewei_temp <= fen_gewei_temp;
		end
	end
	
	/*分十位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			fen_shiwei_temp <= 3'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd16 && cnt_100 <= 7'd18)) begin
			fen_shiwei_temp <= {bcode_latch,{fen_shiwei_temp[2:1]}};
		end else begin
			fen_shiwei_temp <= fen_shiwei_temp;
		end
	end

	/*时个位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			shi_gewei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd21 && cnt_100 <= 7'd24)) begin
			shi_gewei_temp <= {bcode_latch,{shi_gewei_temp[3:1]}};
		end else begin
			shi_gewei_temp <= shi_gewei_temp;
		end
	end

	/*时十位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			shi_shiwei_temp <= 2'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd26 && cnt_100 <= 7'd27)) begin
			shi_shiwei_temp <= {bcode_latch,{shi_shiwei_temp[1]}};
		end else begin
			shi_shiwei_temp <= shi_shiwei_temp;
		end
	end

	/*天个位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			day_gewei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd31 && cnt_100 <= 7'd34)) begin
			day_gewei_temp <= {bcode_latch,{day_gewei_temp[3:1]}};
		end else begin
			day_gewei_temp <= day_gewei_temp;
		end
	end

	/*天十位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			day_shiwei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd36 && cnt_100 <= 7'd39)) begin
			day_shiwei_temp <= {bcode_latch,{day_shiwei_temp[3:1]}};
		end else begin
			day_shiwei_temp <= day_shiwei_temp;
		end
	end

	/*天百位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			day_baiwei_temp <= 2'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd41 && cnt_100 <= 7'd42)) begin
			day_baiwei_temp <= {bcode_latch,{day_baiwei_temp[1]}};
		end else begin
			day_baiwei_temp <= day_baiwei_temp;
		end
	end

	/*年个位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			year_gewei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd51 && cnt_100 <= 7'd54)) begin
			year_gewei_temp <= {bcode_latch,{year_gewei_temp[3:1]}};
		end else begin
			year_gewei_temp <= year_gewei_temp;
		end
	end

	/*年十位*/
	always @(posedge clk_125mhz or negedge rst_n) begin 
		if(~rst_n) begin
			year_shiwei_temp <= 4'd0;
		end else if(sig_fall_det_3 && (cnt_100 >= 7'd56 && cnt_100 <= 7'd59)) begin
			year_shiwei_temp <= {bcode_latch,{year_shiwei_temp[3:1]}};
		end else begin
			year_shiwei_temp <= year_shiwei_temp;
		end
	end


	/*码元序号到达65时进行输出*/
	always @(posedge clk_125mhz or negedge rst_n) begin
		if(~rst_n) begin
			miao_gewei <= 4'd0;
			miao_shiwei <= 3'd0;
			fen_gewei <= 4'd0;
			fen_shiwei <= 3'd0;
			shi_gewei <= 4'd0;
			shi_shiwei <= 2'd0;
			day_gewei <= 4'd0;
			day_shiwei <= 4'd0;
			day_baiwei <= 2'd0;
			year_gewei <= 4'd0;
			year_shiwei <= 4'd0;
		end else if(cnt_100 == 7'd65) begin
			miao_gewei <= miao_gewei_temp;
			miao_shiwei <= miao_shiwei_temp;
			fen_gewei <= fen_gewei_temp;
			fen_shiwei <= fen_shiwei_temp;
			shi_gewei <= shi_gewei_temp;
			shi_shiwei <= shi_shiwei_temp;
			day_gewei <= day_gewei_temp;
			day_shiwei <= day_shiwei_temp;
			day_baiwei <= day_baiwei_temp;
			year_gewei <= year_gewei_temp;
			year_shiwei <= year_shiwei_temp;
		end else begin
			miao_gewei <= miao_gewei;
			miao_shiwei <= miao_shiwei;
			fen_gewei <= fen_gewei;
			fen_shiwei <= fen_shiwei;
			shi_gewei <= shi_gewei;
			shi_shiwei <= shi_shiwei;
			day_gewei <= day_gewei;
			day_shiwei <= day_shiwei;
			day_baiwei <= day_baiwei;
			year_gewei <= year_gewei;
			year_shiwei <= year_shiwei;
		end
			

	end
	
endmodule