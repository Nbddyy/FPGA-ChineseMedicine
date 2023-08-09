module B_CODE_decode 
#(
	parameter   cnt_10ms_max = 32'd1_249_999
)
(
	input pll_c0,
	input pll_locked,
	input [7:0] moni_b_code_out,
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

	parameter IDLE = 8'h0;
    parameter BCODE_P = 8'h70;
    parameter BCODE_0 = 8'h30;
    parameter BCODE_1 = 8'h31;



    /*定义一个计数用来10ms*/
    reg [31:0] cnt_10ms;
    always @(posedge pll_c0 or negedge pll_locked) begin
    	if(~pll_locked) begin
    		cnt_10ms <= 32'd0;
    	end else if(!moni_b_code_out) begin
    		cnt_10ms <= 32'd0;
    	end else if(cnt_10ms == cnt_10ms_max) begin
    		cnt_10ms <= 32'd0;
    	end else begin
    		cnt_10ms <= cnt_10ms + 32'd1;
    	end
    end

	/*检测双P拉高start_flag标志*/
	reg [7:0] ex_bcode_type;
	reg start_flag;
	always @(posedge pll_c0 or negedge pll_locked) begin
		if(~pll_locked) begin
			ex_bcode_type <= IDLE;
			start_flag <= 1'd0;
		end else if(cnt_10ms == cnt_10ms_max) begin
			ex_bcode_type <= moni_b_code_out;
			if(moni_b_code_out == BCODE_P) begin
				start_flag <= 1'd1;
			end
		end else begin
			ex_bcode_type <= ex_bcode_type;
		end
	end 

	/*计数码元序号*/
	reg [6:0] cnt_100;
	always @(posedge pll_c0 or negedge pll_locked) begin
		if(~pll_locked) begin
			cnt_100 <= 7'd0;
		end else if(cnt_10ms == cnt_10ms_max && start_flag == 1'd1) begin
			cnt_100 <= cnt_100 + 7'd1;
		end else begin
			cnt_100 <= cnt_100;
		end
	end

	/*对码元进行解码，从而得到时分秒数据*/
	/*秒个位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			miao_gewei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd2 && cnt_100 <= 7'd5)) begin
			miao_gewei_temp <= {ex_bcode_type,{miao_gewei_temp[3:1]}};
		end else begin
			miao_gewei_temp <= miao_gewei_temp;
		end
	end

	/*秒十位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			miao_shiwei_temp <= 3'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd7 && cnt_100 <= 7'd9)) begin
			miao_shiwei_temp <= {ex_bcode_type,{miao_shiwei_temp[2:1]}};
		end else begin
			miao_shiwei_temp <= miao_shiwei_temp;
		end
	end

	/*分个位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			fen_gewei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd11 && cnt_100 <= 7'd14)) begin
			fen_gewei_temp <= {ex_bcode_type,{fen_gewei_temp[3:1]}};
		end else begin
			fen_gewei_temp <= fen_gewei_temp;
		end
	end
	
	/*分十位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			fen_shiwei_temp <= 3'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd16 && cnt_100 <= 7'd18)) begin
			fen_shiwei_temp <= {ex_bcode_type,{fen_shiwei_temp[2:1]}};
		end else begin
			fen_shiwei_temp <= fen_shiwei_temp;
		end
	end

	/*时个位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			shi_gewei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd21 && cnt_100 <= 7'd24)) begin
			shi_gewei_temp <= {ex_bcode_type,{shi_gewei_temp[3:1]}};
		end else begin
			shi_gewei_temp <= shi_gewei_temp;
		end
	end

	/*时十位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			shi_shiwei_temp <= 2'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd26 && cnt_100 <= 7'd27)) begin
			shi_shiwei_temp <= {ex_bcode_type,{shi_shiwei_temp[1]}};
		end else begin
			shi_shiwei_temp <= shi_shiwei_temp;
		end
	end

	/*天个位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			day_gewei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd31 && cnt_100 <= 7'd34)) begin
			day_gewei_temp <= {ex_bcode_type,{day_gewei_temp[3:1]}};
		end else begin
			day_gewei_temp <= day_gewei_temp;
		end
	end

	/*天十位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			day_shiwei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd36 && cnt_100 <= 7'd39)) begin
			day_shiwei_temp <= {ex_bcode_type,{day_shiwei_temp[3:1]}};
		end else begin
			day_shiwei_temp <= day_shiwei_temp;
		end
	end

	/*天百位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			day_baiwei_temp <= 2'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd41 && cnt_100 <= 7'd42)) begin
			day_baiwei_temp <= {ex_bcode_type,{day_baiwei_temp[1]}};
		end else begin
			day_baiwei_temp <= day_baiwei_temp;
		end
	end

	/*年个位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			year_gewei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd51 && cnt_100 <= 7'd54)) begin
			year_gewei_temp <= {ex_bcode_type,{year_gewei_temp[3:1]}};
		end else begin
			year_gewei_temp <= year_gewei_temp;
		end
	end

	/*年十位*/
	always @(posedge pll_c0 or negedge pll_locked) begin 
		if(~pll_locked) begin
			year_shiwei_temp <= 4'd0;
		end else if(cnt_10ms == 32'd1 && (cnt_100 >= 7'd56 && cnt_100 <= 7'd59)) begin
			year_shiwei_temp <= {ex_bcode_type,{year_shiwei_temp[3:1]}};
		end else begin
			year_shiwei_temp <= year_shiwei_temp;
		end
	end


	/*码元序号到达65时进行输出*/
	always @(posedge pll_c0 or negedge pll_locked) begin
		if(~pll_locked) begin
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