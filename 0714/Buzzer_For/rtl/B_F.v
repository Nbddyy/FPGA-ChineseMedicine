module B_F 
#(
	parameter max = 32'd24_999_999
)
(
	input clk,
	input rst_n,
	output reg beep_out
);

	reg [31:0] cnt;
	reg [2:0] cnt_500ms;
	reg [23:0] beep_flag [6:0];

	wire [23:0] beep_option[6:0];
	assign beep_option[0] = 24'd190840 - 24'd1;
	assign beep_option[1] = 24'd170068 - 24'd1;
	assign beep_option[2] = 24'd151515 - 24'd1;
	assign beep_option[3] = 24'd143266 - 24'd1; 
	assign beep_option[4] = 24'd127551 - 24'd1;
	assign beep_option[5] = 24'd113636 - 24'd1;
	assign beep_option[6] = 24'd101214 - 24'd1; 


	/*积累20ns对应0.5s的周期数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 32'd0;
		end else if(cnt == max) begin
			cnt <= 32'd0;
		end else begin
			cnt <= cnt + 32'd1;
		end
	end

	/*使用cnt_500ms记录0.5s的间隔，其数字对应不同音频触发信号的编号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 3'd0;
		end else if(cnt == max && cnt_500ms == 3'd6) begin
			cnt_500ms <= 3'd0;
		end else if(cnt == max) begin
			cnt_500ms <= cnt_500ms + 3'd1;
		end else begin
			cnt_500ms <= cnt_500ms;
		end
	end


	//七段并行代码块，对应条件下执行代码块
	//每0.5s并行代码块中依次有序生效
	genvar i;
	generate for(i = 0; i < 7; i = i + 1) begin : for_buzzer
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				beep_flag[i] <= 24'd0;
			end else if(beep_flag[i] == beep_option[i] || cnt == max) begin
				beep_flag[i] <= 24'd0;
			end else begin
				beep_flag[i] <= beep_flag[i] + 24'd1;
			end
		end	
	end endgenerate



	/*通过上版操作实现了不同频率音频信号的循环输出*/
	always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				beep_out <= 1'd0;
			end else if((beep_option[cnt_500ms] >> 1) > beep_flag[cnt_500ms]) begin
				beep_out <= 1'd1;	//cnt_500ms不为constant，待定
			end else begin
				beep_out <= 1'd0;
			end
	end


endmodule