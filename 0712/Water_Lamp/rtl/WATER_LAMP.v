module WATER_LAMP 
#(
	parameter temp_max = 32'd24
)
(
	input clk,
	input rst_n, 
	output [3:0] n_led_state
);

	reg [31:0] temp;
	// reg [3:0] led_state;
	wire [3:0] led_state;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp <= 32'd0;
		end else if(temp == temp_max) begin
			temp <= 32'd0;
		end else begin
			temp <= temp + 32'd1;
		end
	end

	
	// always @(posedge clk or negedge rst_n) begin
	// 	if(~rst_n) begin
	// 		led_state <= 4'b0001;
	// 	end else if(led_state == 4'b1000 && temp == 32'd24_999_999) begin
	// 		led_state <= 4'b0001;
	// 	end else if(temp == 32'd24_999_999) begin
	// 		led_state <= led_state << 1;
	// 	end else begin
	// 		led_state <= led_state;

	// 	end
	// end


	always @(*) begin
		led_state = (rst_n == 1'd0) ? 4'b0001 :
						(led_state == 4'b1000 && temp == temp_max) ? 4'b0001 :
						(temp == temp_max) ? led_state << 1 :
						led_state
						;
	end

	//使用三目运算符
	//敏感变量，组合逻辑单元的输出作为下一个组合逻辑单元的判断条件，回环
	/*assign led_state = (~rst_n) ? 4'b0001 :
						(led_state == 4'b1000 && temp == temp_max) ? 4'b0001 :
						(temp == temp_max) ? led_state << 1 :
						led_state
						;*/



	//使用位拼接实现移位

	// always@(posedge clk or negedge rst_n) begin
	// 	if(!rst_n) begin
	// 		led_state <= 4'b0001;
 // 		end else if(temp == 32'd24_999_999) begin
 // 			led_state <= {{led_state[2:0]},{led_state[3]}};
 // 		end else begin
 // 			led_state <= led_state;
 // 		end
	// end

	assign n_led_state = ~led_state;

endmodule