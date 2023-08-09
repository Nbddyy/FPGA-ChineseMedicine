module Data_Control 
#(
	parameter cnt_500ms_max = 32'd49_999_999 	//为方便观察，更改为1s变换
)
(
	input clk,
	input rst_n,
	output reg [5:0] sel, 	//位选
	output reg [7:0] sec 	//段选
);

	reg [31:0] cnt_500ms;	//定义cnt_500ms
	reg [3:0] cnt_num;		//定义0-15六位八段数码管的循环累计

	/*计数实现间隔0.5循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_500ms <= 32'd0;
		end else if(cnt_500ms == cnt_500ms_max) begin
			cnt_500ms <= 32'd0;
		end else begin
			cnt_500ms <= cnt_500ms + 32'd1;
		end
	end

	/*0-f循环显示依赖cnt_num的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_num <= 4'd0;
		end else if(cnt_500ms == cnt_500ms_max) begin
			cnt_num <= cnt_num + 4'd1;
		end else begin
			cnt_num <= cnt_num;
		end
	end


	/*sel位选的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel <= 6'd0;
		end else if(sec) begin
			sel <= 6'b111_111;
		end else begin
			sel  <= 6'd0;
		end
	end

	/*实现输出sec[7:0]为0-f循环的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sec <= 8'd0;
		end else begin
			case(cnt_num)
				4'd0 : sec <= 8'b1100_0000;
				4'd1 : sec <= 8'b1111_1001;
				4'd2 : sec <= 8'b1010_0100;
				4'd3 : sec <= 8'b1011_0000;
				4'd4 : sec <= 8'b1001_1001;
				4'd5 : sec <= 8'b1001_0010;
				4'd6 : sec <= 8'b1000_0010;
				4'd7 : sec <= 8'b1111_1000;
				4'd8 : sec <= 8'b1000_0000;
				4'd9 : sec <= 8'b1001_0000;
				4'd10 : sec <= 8'b1000_1000;
				4'd11 : sec <= 8'b1000_0011;
				4'd12 : sec <= 8'b1100_0110;
				4'd13 : sec <= 8'b1010_0001;
				4'd14 : sec <= 8'b1000_0110;
				4'd15 : sec <= 8'b1000_1110;
				default : sec <= 8'd0;
			endcase
		end
	end
	


endmodule