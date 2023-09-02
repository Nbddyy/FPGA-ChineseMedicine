module Buzzer 
#(
	parameter cnt_1s_max = 32'd124_999_999,
	parameter cnt_Do_max = 24'd238_549,	//各个蜂鸣器频率计数
	parameter cnt_Re_max = 24'd212_585,	
	parameter cnt_Mi_max = 24'd189_393,	
	parameter cnt_Fa_max = 24'd179_083,	
	parameter cnt_So_max = 24'd239_438,	
	parameter cnt_La_max = 24'd142_045,	
	parameter cnt_Si_max = 24'd126_518	
)
(
	input clk,
	input rst_n,
	input flag,
	output reg beep
);

	reg work_en;

	reg [31:0] cnt_1s; 
	reg [23:0] cnt_Do;
	reg [23:0] cnt_Re;
	reg [23:0] cnt_Mi;
	reg [23:0] cnt_Fa;
	reg [23:0] cnt_So;
	reg [23:0] cnt_La;
	reg [23:0] cnt_Si;
	reg [3:0] cnt_7;	//用来计数当前音调

	/*蜂鸣器输出为1计数期间的的使能信号*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(cnt_7 == 4'd7 && cnt_1s == cnt_1s_max) begin
			work_en <= 1'd0;
		end else if(flag) begin
			work_en <= 1'd1;
		end else begin
			work_en <= work_en;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1s <= 32'd0;
		end else if(!work_en || cnt_1s == cnt_1s_max) begin
			cnt_1s <= 32'd0;
		end else if(work_en) begin
			cnt_1s <= cnt_1s + 32'd1;
		end else begin
			cnt_1s <= 32'd0;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_Do <= 24'd0;
			cnt_Re <= 24'd0;
			cnt_Mi <= 24'd0;
			cnt_Fa <= 24'd0;
			cnt_So <= 24'd0;
			cnt_La <= 24'd0;
			cnt_Si <= 24'd0;
		end else if(work_en) begin
			cnt_Do <= (cnt_Do == cnt_Do_max || cnt_7 != 4'd1) ? 24'd0 : cnt_Do + 24'd1;
			cnt_Re <= (cnt_Re == cnt_Re_max || cnt_7 != 4'd2) ? 24'd0 : cnt_Re + 24'd1;
			cnt_Mi <= (cnt_Mi == cnt_Mi_max || cnt_7 != 4'd3) ? 24'd0 : cnt_Mi + 24'd1;
			cnt_Fa <= (cnt_Fa == cnt_Fa_max || cnt_7 != 4'd4) ? 24'd0 : cnt_Fa + 24'd1;
			cnt_So <= (cnt_So == cnt_So_max || cnt_7 != 4'd5) ? 24'd0 : cnt_So + 24'd1;
			cnt_La <= (cnt_La == cnt_La_max || cnt_7 != 4'd6) ? 24'd0 : cnt_La + 24'd1;
			cnt_Si <= (cnt_Si == cnt_Si_max || cnt_7 != 4'd7) ? 24'd0 : cnt_Si + 24'd1;
		end else begin
			cnt_Do <= 24'd0;
			cnt_Re <= 24'd0;
			cnt_Mi <= 24'd0;
			cnt_Fa <= 24'd0;
			cnt_So <= 24'd0;
			cnt_La <= 24'd0;
			cnt_Si <= 24'd0;
		end
	end

	/*temp cnt_7*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_7 <= 4'd0;
		end else if(flag) begin
			cnt_7 <= 4'd1;
		end else if(!work_en) begin
			cnt_7 <= 4'd0;
		end else if(cnt_1s == cnt_1s_max) begin
			cnt_7 <= cnt_7 + 4'd1;
		end else begin
			cnt_7 <= cnt_7;
		end
	end

	/*output beep*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep <= 1'd0;
		end else if(work_en) begin
			case(cnt_7)
				4'd1 : beep <= (cnt_Do == cnt_Do_max) ? !beep : beep;
				4'd2 : beep <= (cnt_Re == cnt_Re_max) ? !beep : beep;
				4'd3 : beep <= (cnt_Mi == cnt_Mi_max) ? !beep : beep;
				4'd4 : beep <= (cnt_Fa == cnt_Fa_max) ? !beep : beep;
				4'd5 : beep <= (cnt_So == cnt_So_max) ? !beep : beep;
				4'd6 : beep <= (cnt_La == cnt_La_max) ? !beep : beep;
				4'd7 : beep <= (cnt_Si == cnt_Si_max) ? !beep : beep;
				default : beep <= 1'd0;
			endcase
		end else begin
			beep <= 1'd0;
		end
	end


endmodule 