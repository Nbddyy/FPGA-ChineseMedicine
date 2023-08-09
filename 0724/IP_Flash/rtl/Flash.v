module Flash 
#(
	parameter cnt_1s_max = 32'd199_999_999 
)
(
	input clk_200mhz,
	input rst,
	output reg led_out  
);

	/*
	1s等于1_000_000_000 / 5 = 200_000_000个周期*/
	reg [31:0] cnt_1s;
	always @(posedge clk_200mhz or negedge rst) begin
		if(~rst) begin
			cnt_1s <= 32'd0;
		end else if(cnt_1s == cnt_1s_max) begin
			cnt_1s <= 32'd0;
		end else begin
			cnt_1s <= cnt_1s + 32'd1;
		end
	end

	/*定义LED灯的三种状态*/
	reg [2:0] state;
	parameter IDLE = 3'b001;
	parameter BRIGHT = 3'b010;
	parameter EXTINGUISH = 3'b100;

	/*D6三种状态转移的代码实现*/
	always @(posedge clk_200mhz or negedge rst) begin
		if(~rst) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : begin
					state <= BRIGHT;
				end 
				BRIGHT : state <= (cnt_1s == cnt_1s_max) ? EXTINGUISH : BRIGHT;
				EXTINGUISH : state <= (cnt_1s == cnt_1s_max) ? BRIGHT : EXTINGUISH;
			endcase
		end
	end

	/*对应状态下led_out的输出情况*/
	always @(posedge clk_200mhz or negedge rst) begin
		if(~rst) begin
			led_out <= 1'd1;
		end else begin
			case(state) 
				IDLE : led_out <= 1'd1;
				BRIGHT : led_out <= 1'd0;
				EXTINGUISH : led_out <= 1'd1;
				default : led_out <= 1'd1;
			endcase
		end
	end

endmodule