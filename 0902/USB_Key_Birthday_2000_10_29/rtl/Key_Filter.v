module Key_Filter 
#(
	parameter cnt_20ms_max = 24'd999_999
)
(
	input clk,
	input rst_n, 
	input key,
	output reg key_flag
);

	reg [23:0] cnt_20ms;	//用于记录按键稳定时的计数

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_20ms <= 24'd0;
		end else if(key) begin
			cnt_20ms <= 24'd0;
		end else if(cnt_20ms == cnt_20ms_max) begin
			cnt_20ms <= cnt_20ms;
		end else begin
			cnt_20ms <= cnt_20ms + 24'd1;
		end
	end

	/*output key_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			key_flag <= 1'd0;
		end else if(cnt_20ms == cnt_20ms_max - 24'd1) begin
			key_flag <= 1'd1;
		end else begin
			key_flag <= 1'd0;
		end
	end

endmodule