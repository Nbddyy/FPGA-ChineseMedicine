module Double_Led 
#(
	parameter cnt_500ms_max = 32'd24_999_999
)
(
	input clk,
	input rst_n,
	input double_in,
	output reg [3:0] double_led
);

	/*使用独热码表示双向流水下的几种状态*/
	reg [4:0] double_led_state;
	parameter IDLE = 5'b00_001;
	parameter D6 = 5'b00_010;
	parameter D7 = 5'b00_100;
	parameter D8 = 5'b01_000;
	parameter D9 = 5'b10_000;

	/*定义一个计时0.5s的变量*/
	reg [31:0] cnt_500ms;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 32'd0;
		end else if(cnt_500ms == cnt_500ms_max && double_in) begin
			cnt_500ms <= 32'd0;
		end else if(double_in) begin
			cnt_500ms <= cnt_500ms + 32'd1;
		end else begin
			cnt_500ms <= 32'd0;
		end
	end

	/*描述触发双向流水时几种状态之间的转移*/
	/*定义变量direction用来表示流向*/
	reg direction;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_led_state <= IDLE;
			direction <= 1'd1;	//0表示右流水，1表示左流水
		end else begin
			case(double_led_state)
				IDLE : begin
					if(double_in) begin
						double_led_state <= D6;
						direction <= 1'd1;
					end else begin
						double_led_state <= IDLE;
					end
				end

				D6 : begin
					if(cnt_500ms == cnt_500ms_max) begin
						double_led_state <= D7;
						direction <= ~direction;
					end else if(double_in) begin
						double_led_state <= D6;
					end else begin
						double_led_state <= IDLE;
					end
				end

				D7 : begin
					if(cnt_500ms == cnt_500ms_max && direction == 1'd0) begin
						double_led_state <= D8;
					end else if(cnt_500ms == cnt_500ms_max && direction == 1'd1) begin
						double_led_state <= D6;
					end else if(double_in) begin
						double_led_state <= D7;
					end else begin
						double_led_state <= IDLE;
					end
				end

				D8 : begin
					if(cnt_500ms == cnt_500ms_max && direction == 1'd0) begin
						double_led_state <= D9;
					end else if(cnt_500ms == cnt_500ms_max && direction == 1'd1) begin
						double_led_state <= D7;
					end else if(double_in) begin
						double_led_state <= D8;
					end else begin
						double_led_state <= IDLE;
					end
				end

				D9 : begin
					if(cnt_500ms == cnt_500ms_max) begin
						double_led_state <= D8;
						direction <= ~direction;
					end else if(double_in) begin
						double_led_state <= D9;
					end else begin
						double_led_state <= IDLE;
					end
				end

				default : double_led_state <= IDLE;
			endcase
		end 
	end

	/*描述几种状态转移下single_led的输出结果*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_led <= 4'b1111;
		end else begin
			case(double_led_state)
				IDLE : double_led <= 4'b1111;
				D6 : double_led <= 4'b1110;
				D7 : double_led <= 4'b1101;
				D8 : double_led <= 4'b1011;
				D9 : double_led <= 4'b0111;
				default : double_led <= 4'b1111;
			endcase
		end
	end

endmodule