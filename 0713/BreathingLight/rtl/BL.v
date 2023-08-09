module BL 
#(
	parameter max1 = 50,	//1us对应20ns的周期数
	parameter max2 = 1000	//1ms对应1us以及1s对应1ms的周期数
)
(
	input clk,
	input rst_n, 
	output reg led_out,
	output reg led_out_2 
);

	reg [5:0] cnt_1us;
	reg [9:0] cnt_1ms;
	reg [9:0] cnt_1s;
	reg led_state;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1us <= 6'd0;
		end else if(cnt_1us == max1 - 6'd1)begin
			cnt_1us <= 6'd0;
		end else begin
			cnt_1us <= cnt_1us + 6'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1ms <= 10'd0;
		end else if(cnt_1us == max1 - 6'd1 && cnt_1ms == max2 - 10'd1)begin
			cnt_1ms <= 10'd0;
		end else if(cnt_1us == max1 - 6'd1)begin
			cnt_1ms <= cnt_1ms + 10'd1;
		end else begin
			cnt_1ms <= cnt_1ms;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1s <= 10'd0;
		end else if(cnt_1us == max1 - 6'd1 && cnt_1ms == max2 - 10'd1 && cnt_1s == max2 - 10'd1) begin
			cnt_1s <= 10'd0;
		end else if(cnt_1ms == max2 - 10'd1 && cnt_1us == max1 - 6'd1)begin
			cnt_1s <= cnt_1s + 10'd1;
		end else begin
			cnt_1s <= cnt_1s;
		end
	end

	//进行led_state的判断：用于表示渐变渐灭表达式的选择
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_state <= 1'd0;
		end else if(cnt_1us == max1 - 6'd1 && cnt_1ms == max2 - 10'd1 && cnt_1s == max2 - 10'd1) begin
			led_state <= ~led_state;
		end else begin
			led_state <= led_state;
		end
	end

	//呼吸灯代码实现
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= 1'd0;
		end else if(cnt_1ms < cnt_1s) begin
			case(led_state) 
				1'd0: led_out <= 1'd1;
				1'd1: led_out <= 1'd0;
				default: led_out <= 1'bx;
			endcase
		end else if(cnt_1ms == cnt_1s) begin
			case (led_state)
				1'd0: led_out <= 1'd0;
				1'd1: led_out <= 1'd1;
				default : led_out <= 1'bx;
			endcase
		end else begin
			led_out <= led_out;
		end

		//代码优化，通过同时判断cnt_1ms与cnt_1s的大小以及led_state的状态对led_out进行赋值
		/*if(~rst_n) begin
			led_out <= 1'd0;
		end else if((cnt_1ms < cnt_1s && led_state == 1'd0) || (cnt_1ms > cnt_1s && led_state == 1'd1)) begin
			led_out <= 1'd1;
		end else begin
			led_out <= 1'd0;
		end*/
	end





	//两秒呼吸灯
	reg [31:0] cnt_2us;
	reg [31:0] cnt_2ms;
	reg [31:0] cnt_2s;
	reg led_state_2;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_2us <= 32'd0;
		end else if(cnt_2us == 2*max1 - 32'd1)begin
			cnt_2us <= 32'd0;
		end else begin
			cnt_2us <= cnt_2us + 32'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_2ms <= 32'd0;
		end else if(cnt_2us == 2*max1 - 32'd1 && cnt_2ms == max2 - 32'd1)begin
			cnt_2ms <= 32'd0;
		end else if(cnt_2us == 2*max1 - 32'd1)begin
			cnt_2ms <= cnt_2ms + 32'd1;
		end else begin
			cnt_2ms <= cnt_2ms;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_2s <= 32'd0;
		end else if(cnt_2us == 2*max1 - 32'd1 && cnt_2ms == max2 - 32'd1 && cnt_2s == max2 - 32'd1) begin
			cnt_2s <= 32'd0;
		end else if(cnt_2ms == max2 - 32'd1 && cnt_2us == 2*max1 - 32'd1)begin
			cnt_2s <= cnt_2s + 32'd1;
		end else begin
			cnt_2s <= cnt_2s;
		end
	end

	//进行led_state的判断：用于表示渐变渐灭表达式的选择
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_state_2 <= 1'd0;
		end else if(cnt_2us == 2*max1 - 32'd1 && cnt_2ms == max2 - 32'd1 && cnt_2s == max2 - 32'd1) begin
			led_state_2 <= ~led_state_2;
		end else begin
			led_state_2 <= led_state_2;
		end
	end

	//呼吸灯代码实现
	always @(posedge clk or negedge rst_n) begin

		//代码优化，通过同时判断cnt_1ms与cnt_1s的大小以及led_state的状态对led_out进行赋值
		if(~rst_n) begin
			led_out_2 <= 1'd0;
		end else if((cnt_2ms < cnt_2s && led_state_2 == 1'd0) || (cnt_2ms > cnt_2s && led_state_2 == 1'd1)) begin
			led_out_2 <= 1'd1;
		end else begin
			led_out_2 <= 1'd0;
		end
	end


endmodule