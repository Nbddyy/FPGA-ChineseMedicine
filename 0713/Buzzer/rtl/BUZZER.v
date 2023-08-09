module BUZZER 
#(
	parameter max = 32'd24_999_999
)
(
	input clk,
	input rst_n,  
	output reg beep_out
);

	parameter max262 = 24'd190840 - 24'd1;
	parameter max294 = 24'd170068 - 24'd1;
	parameter max330 = 24'd151515 - 24'd1;
	parameter max349 = 24'd143266 - 24'd1;
	parameter max392 = 24'd127551 - 24'd1;
	parameter max440 = 24'd113636 - 24'd1;
	parameter max494 = 24'd101214 - 24'd1;


	reg [31:0] cnt;
	reg [2:0] cnt_500ms;
	reg [23:0] beep_option;
	wire [23:0] beep_half;
	reg [23:0] beep_flag;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 32'd0;
		end else if(cnt == max) begin
			cnt <= 32'd0;
		end else begin
			cnt <= cnt + 32'd1;
		end
	end

	//进行0.5s的计数统计对应不同频率的音频触发信号
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

	//对对应cnt_500ms下的beep_option进行音频信号赋值
	/*always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_option <= max262;
		end else if(cnt == max) begin
			case (cnt_500ms + 1)
				3'd1: beep_option <= max294;
				3'd2: beep_option <= max330;
				3'd3: beep_option <= max349;
				3'd4: beep_option <= max392;
				3'd5: beep_option <= max440;
				3'd6: beep_option <= max494;
				default : beep_option <= max262;
			endcase
		end else begin
			beep_option <= beep_option;
		end
	end*/

	//Second Method
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_option <= max262;
		end else begin
			case (cnt_500ms + 1)
				3'd1: beep_option <= max294;
				3'd2: beep_option <= max330;
				3'd3: beep_option <= max349;
				3'd4: beep_option <= max392;
				3'd5: beep_option <= max440;
				3'd6: beep_option <= max494;
				default : beep_option <= max262;
			endcase
		end 
	end
////////////////////////////

	assign beep_half = beep_option >> 1'b1;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_flag <= 24'd0;
		end else if(beep_flag == beep_option || cnt == max) begin
			beep_flag <= 24'd0;
		end else begin
			beep_flag <= beep_flag + 24'd1;
		end
	end

	//音频触发信号代码实现
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			beep_out <= 1'd0;
		end else if(beep_half > beep_flag) begin
			beep_out <= 1'd1;
		end else begin
			beep_out <= 1'd0;
		end
	end

endmodule