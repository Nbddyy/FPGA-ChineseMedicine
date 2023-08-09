module Key_Filter 
#(
	parameter cnt_20ms_max = 32'd999_999
)
(
	input clk,
	input rst_n,
	input key,
	output reg out
);

	/*定义计数20ms的计数器*/
	reg [31:0] cnt_20ms;

	/*记录按键消抖稳定后的按键确认*/
	always @(posedge clk or negedge rst_n) begin

		if(~rst_n) begin
			cnt_20ms <= 32'd0;
		end else if(key) begin
			cnt_20ms <= 32'd0;
		end else if(cnt_20ms == cnt_20ms_max) begin
			cnt_20ms <= cnt_20ms;
		end else begin
			cnt_20ms <= cnt_20ms + 32'd1;
		end
		
	end

	/*当cnt_20ms记录到按键稳定后，则认为此按键有效*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			out <= 1'd0;
		end else if(cnt_20ms == cnt_20ms_max - 32'd1) begin
			out <= 1'd1;
		end else begin
			out <= 1'd0;
		end
	end

endmodule