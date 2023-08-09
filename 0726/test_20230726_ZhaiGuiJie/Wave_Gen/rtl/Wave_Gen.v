module Wave_Gen 
#(
	parameter cnt_18ms_max = 32'd1_799_999,
	parameter cnt_2ms_max = 32'd199_999,
	parameter cnt_4ms_max = 32'd399_999,
	parameter cnt_7ms_max = 32'd699_999,
	parameter cnt_10ms_max = 32'd999_999,
	parameter cnt_14ms_max = 32'd1_399_999
)
(
	input clk_100mhz,
	input rst_n, 
	output reg wave_out
);
	
	/*定义一个18ms的计数器*/
	reg [31:0] cnt_18ms;
	always @(posedge clk_100mhz or negedge rst_n) begin
		if(~rst_n) begin
			cnt_18ms <= 32'd0;
		end else if(cnt_18ms == cnt_18ms_max) begin
			cnt_18ms <= 32'd0;
		end else begin
			cnt_18ms <= cnt_18ms + 32'd1;
		end
	end

	/*循环绘制完整时序T的波形*/
	always @(posedge clk_100mhz or negedge rst_n) begin
		if(~rst_n) begin
			wave_out <= 1'd0;
		end else begin
			case(cnt_18ms)
				cnt_2ms_max : wave_out <= ~wave_out;
				cnt_4ms_max : wave_out <= ~wave_out;
				cnt_7ms_max : wave_out <= ~wave_out;
				cnt_10ms_max : wave_out <= ~wave_out;
				cnt_14ms_max : wave_out <= ~wave_out;
				cnt_18ms_max : wave_out <= ~wave_out;
				default : wave_out <= wave_out;
			endcase
		end
	end



endmodule