module Data_Flow_Pre
#(
	parameter cnt_1ms_max = 32'd49_999,
	parameter data_flow_max = 32'd999_999
)
(
	input clk,
	input rst_n,
	output reg [23:0] data_flow,
	output reg [5:0] sel
);

	reg [31:0] cnt_1ms;	//计数1ms
	reg [2:0] cnt_6;	//6ms一循环计数
	reg [7:0] cnt_100;	//100ms计数，依赖于cnt_1ms


	/*1ms计数的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1ms <= 32'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_1ms <= 32'd0;
		end else begin
			cnt_1ms <= cnt_1ms + 32'd1;
		end
	end

	/*每1ms输出其中一个数码管的状态，每6ms一循环*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_6 <= 3'd0;
		end else if(cnt_6 == 3'd5 && cnt_1ms == cnt_1ms_max) begin
			cnt_6 <= 3'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_6 <= cnt_6 + 3'd1;
		end else begin
			cnt_6 <= cnt_6;
		end
	end

	/*100ms计数，用来供0.1s加1判断*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			cnt_100 <= 8'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_100 <= cnt_100 + 8'd1;
		end else begin
			cnt_100 <= cnt_100;
		end
	end

	/*输出data_flow的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data_flow <= 24'd0;
		end else if(data_flow == data_flow_max && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			data_flow <= 24'd0;
		end else if(cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			data_flow <= data_flow + 24'd1;
		end else begin
			data_flow <= data_flow;
		end
	end

	/*输出sel的代码实现，
	除了代码中的根据cnt_6判断sel，还可以使用：
	当cnt_1ms计数到最大值时将sel进行位拼接操作实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel <= 6'd0;
		end else begin 	//也可将变量cnt_6删除，通过对cnt_1ms判断进行移位操作
			case(cnt_6)
				3'd0 : sel <= 6'b000_001;
				3'd1 : sel <= 6'b000_010;
				3'd2 : sel <= 6'b000_100;
				3'd3 : sel <= 6'b001_000;
				3'd4 : sel <= 6'b010_000;
				3'd5 : sel <= 6'b100_000;
				default : sel <= 6'b000_000;
			endcase
		end
	end

endmodule