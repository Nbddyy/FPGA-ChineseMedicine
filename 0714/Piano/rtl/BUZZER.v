module BUZZER 
#(
	parameter max_500ms = 32'd24_999_999
)
(
	input clk,
	input rst_n,
	input [3:0] pianos,

	output reg beep_out
);

	//设置一个temp变量当pianos发生变化时进行监控
	reg [3:0] temp;
	wire [23:0] signal_half [3:0];
	reg [23:0] signal_cnt [3:0];
	reg dis_singal_4 [3:0];
	reg [31:0] cnt_500ms;

	assign signal_half[0] = 24'd95420;
	assign signal_half[1] = 24'd85034;
	assign signal_half[2] = 24'd75757;
	assign signal_half[3] = 24'd71633;

	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : signal_dis_4
		
		/*用于对四种音调的周期计数*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				signal_cnt[i] <= 24'd0;
			end else if(signal_cnt[i] == signal_half[i]) begin
				signal_cnt[i] <= 24'd0;
			end else begin
				signal_cnt[i] <= signal_cnt[i] + 24'd1;
			end
		end

		/*实现四种音调的波形图产出*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				dis_singal_4[i] <= 1'd0;
			end else if(signal_cnt[i] == signal_half[i]) begin
				dis_singal_4[i] <= ~dis_singal_4[i];
			end else begin
				dis_singal_4[i] <= dis_singal_4[i];
			end
		end 


	end endgenerate


	/*计数控制蜂鸣器响0.5s
	0.5s = 0.5 * 10^9 = 500_000_000ns
	500_000_000 / 20 = 25_000_000周期计数
	该计数器只进行一次0.5s的计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 32'd0;
			temp <= 4'd0;
		end else if(pianos != 4'd0) begin
			/*Do:0001;Re:0010;Mi:0100;Fa:1000*/    
			//当没有按键输入或者按键输入与上一次状态不一样则触发重新计数
			cnt_500ms <= 32'd0;
			temp <= pianos;
		end else if(cnt_500ms != max_500ms + 32'd2) begin
			cnt_500ms <= cnt_500ms + 32'd1;
		end else begin
			cnt_500ms <= cnt_500ms;
			temp <= 4'd0;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_out <= 1'd0;
		end else if(cnt_500ms >= 32'd1 && cnt_500ms <= max_500ms + 32'd1) begin
			/*Do:0001;Re:0010;Mi:0100;Fa:1000*/  
			case(temp)
				4'b0001: beep_out <= dis_singal_4[0];
				4'b0010: beep_out <= dis_singal_4[1];
				4'b0100: beep_out <= dis_singal_4[2];
				4'b1000: beep_out <= dis_singal_4[3];
				default: beep_out <= 1'd0;
			endcase // pianos
		end else begin
			beep_out <= 1'd0;
		end
	end



endmodule