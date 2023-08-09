module Flash_Led 
#(
	parameter cnt_300ms_max = 32'd14_999_999
)
(
	input clk,
	input rst_n,  
	input flash_flag,
	output reg [3:0] flash_out
);


	/*定义一个300ms计数器*/
	reg [31:0] cnt_300ms;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_300ms <= 32'd0;
		end else if(!flash_flag) begin
			cnt_300ms <= 32'd0;
		end else if(cnt_300ms == cnt_300ms_max) begin
			cnt_300ms <= 32'd0;
		end else begin
			cnt_300ms <= cnt_300ms + 32'd1;
		end
	end

	/*设计优化：由于只有在输入错误或者按键okay时才会进入该模块
	所以为了让用户更加清晰的观察到密码错误的提示，复位状态和未进入该模块时的输出应该全为0*/

	/*每当cnt_300ms记录至最大值，对flash_out进行取反*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			flash_out <= 4'b0000;
		end else if(!flash_flag) begin
			flash_out <= 4'b0000;
		end else if(cnt_300ms == cnt_300ms_max) begin
			flash_out <= ~flash_out;
		end else begin
			flash_out <= flash_out;
		end
	end

endmodule