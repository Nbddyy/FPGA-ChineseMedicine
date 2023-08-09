module BUZZER 
#(
	parameter max_500ms = 32'd24_999_999
)
(
	input clk,
	input rst_n,
	input [7:0] pianos,

	output reg beep_out
);

	//设置一个temp变量当pianos发生变化时进行监控
	reg [7:0] temp;
	wire [23:0] signal_half [7:0];
	reg [23:0] signal_cnt [7:0];
	reg dis_singal_8 [7:0];
	reg [31:0] cnt_500ms;

	assign signal_half[0] = 24'd95420;
	assign signal_half[1] = 24'd85034;
	assign signal_half[2] = 24'd75757;
	assign signal_half[3] = 24'd71633;
	assign signal_half[4] = 24'd63775;
	assign signal_half[5] = 24'd56818;
	assign signal_half[6] = 24'd50607;
	assign signal_half[7] = 24'd0;


	genvar i;
	/*双击第四个按键波形输出为0，即无声*/
	generate for(i = 0; i < 7; i = i + 1) begin : signal_dis_8
		
		/*用于对七种音调的周期计数*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				signal_cnt[i] <= 24'd0;
			end else if(signal_cnt[i] == signal_half[i]) begin
				signal_cnt[i] <= 24'd0;
			end else begin
				signal_cnt[i] <= signal_cnt[i] + 24'd1;
			end
		end

		/*实现七种音调的波形图产出*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				dis_singal_8[i] <= 1'd0;
			end else if(signal_cnt[i] == signal_half[i]) begin
				dis_singal_8[i] <= ~dis_singal_8[i];
			end else begin
				dis_singal_8[i] <= dis_singal_8[i];
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
			case(temp)
				//单击按键依次对应音频：Do、Re、Mi、Fa
				8'b0000_0001: beep_out <= dis_singal_8[0];
				8'b0000_0010: beep_out <= dis_singal_8[1];
				8'b0000_0100: beep_out <= dis_singal_8[2];
				8'b0000_1000: beep_out <= dis_singal_8[3];
				//双击按键依次对应音频：So、La、Si、无声
				8'b0001_0000: beep_out <= dis_singal_8[4];
				8'b0010_0000: beep_out <= dis_singal_8[5];
				8'b0100_0000: beep_out <= dis_singal_8[6];
				8'b1000_0000: beep_out <= 1'd0;
				default: beep_out <= 1'd0;
			endcase // pianos
		end else begin
			beep_out <= 1'd0;
		end
	end



endmodule