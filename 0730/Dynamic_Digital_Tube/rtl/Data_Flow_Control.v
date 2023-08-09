module Data_Flow_Control (
	input clk,
	input rst_n,
	input [23:0] data_flow,
	input [5:0] sel_in,
	output reg [5:0] sel_out,
	output reg [7:0] sec
);

	/*定义0-9对应的8位段选*/
	parameter num_0 = 8'b1100_0000;
	parameter num_1 = 8'b1111_1001;
	parameter num_2 = 8'b1010_0100;
	parameter num_3 = 8'b1011_0000;
	parameter num_4 = 8'b1001_1001;
	parameter num_5 = 8'b1001_0010;
	parameter num_6 = 8'b1000_0010;
	parameter num_7 = 8'b1111_1000;
	parameter num_8 = 8'b1000_0000;
	parameter num_9 = 8'b1001_0000;

	/*使用将上述多种输出存入数组中进行代码优化*/
	//reg [7:0] nums [9:0];


	/*输出sel_out的代码实现
	注意：时序逻辑延迟一个clk周期*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel_out <= 6'd0;
		end else begin
			sel_out <= sel_in;
		end
	end

	/*输出sec的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sec <= 8'b1111_1111;
		end else begin
			case(sel_in)
				6'b000_001 : begin
					case(data_flow % 10)	//个位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase

					/*使用三目运算符根据对应位数取数组对应数据*/
					// sec <= nums[data_flow % 10];
				end

				6'b000_010 : begin
					case((data_flow / 10) % 10)	//十位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase
				end

				6'b000_100 : begin
					case((data_flow / 100) % 10)	//百位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase
				end

				6'b001_000 : begin
					case((data_flow / 1000) % 10)	//千位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase
				end

				6'b010_000 : begin
					case((data_flow / 10000) % 10)	//万位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase
				end

				6'b100_000 : begin
					case(data_flow / 100_000)	//十万位
						24'd0 : sec <= num_0;
						24'd1 : sec <= num_1;
						24'd2 : sec <= num_2;
						24'd3 : sec <= num_3;
						24'd4 : sec <= num_4;
						24'd5 : sec <= num_5;
						24'd6 : sec <= num_6;
						24'd7 : sec <= num_7;
						24'd8 : sec <= num_8;
						24'd9 : sec <= num_9;
						default : sec <= num_0;
					endcase
				end

				default : sec <= 8'b1111_1111;

			endcase
		end
	end


endmodule