module B_F_EXT 
#(
	parameter max = 32'd24
)
(
	input clk,
	input rst_n,
	output reg beep_out
);

	wire [23:0] beep_option[6:0];
	reg [31:0] beep_cnt [6:0];

	assign beep_option[0] = 24'd95419;
	assign beep_option[1] = 24'd85033;
	assign beep_option[2] = 24'd75756;
	assign beep_option[3] = 24'd71632; 
	assign beep_option[4] = 24'd63774;
	assign beep_option[5] = 24'd56817;
	assign beep_option[6] = 24'd50606; 

	reg div_beep [6:0];
	reg [31:0] cnt;
	reg [2:0] cnt_500ms;

	genvar i;
	generate for(i = 0; i < 7; i = i + 1) begin : B_F_EXT
		
		/*对不同频率的音频触发信号进行递增用于判断低高电平时刻*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				beep_cnt[i] <= 32'd0;
			end else if(beep_cnt[i] == beep_option[i])begin
				beep_cnt[i] <= 32'd0;
			end else begin
				beep_cnt[i] <= beep_cnt[i] + 32'd1;
			end
		end

		/*通过上述计数输出各个无边界音频波形图*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				div_beep[i] <= 1'd0;
			end else if(beep_cnt[i] == beep_option[i]) begin
				div_beep[i] <= ~div_beep[i] ;
			end else begin
				div_beep[i] <= div_beep[i] ;
			end
		end

	end endgenerate

	/*统计0.5s下对应50MHz的周期数max = 24_999_999*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 32'd0;
		end else if(cnt == max) begin
			cnt <= 32'd0;
		end else begin
			cnt <= cnt + 32'd1;
		end
	end

	/*对cnt进行统计，从而实现对cnt_500ms的0-6计数，从而实现0.5s的音频输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 0;
		end else if(cnt_500ms == 3'd6 && cnt == max) begin
			cnt_500ms <= 3'd0;
		end else if(cnt == max) begin
			cnt_500ms <= cnt_500ms + 3'd1;
		end else begin
			cnt_500ms <= cnt_500ms;
		end
	end

	/*在0.5scnt_500ms计数内覆盖对应音频的波形图*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_out <= 1'd0;
		end else begin
			beep_out <= div_beep[cnt_500ms];
		end
	end

endmodule