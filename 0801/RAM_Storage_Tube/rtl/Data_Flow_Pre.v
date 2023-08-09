module Data_Flow_Pre (
	input clk,
	input rst_n,
	input [7:0] addr,
	input [5:0] sel,
	input [7:0] data,
	output reg [5:0] sel_out,
	output reg [7:0] sec
);

	/*定义0-9对应的8位段选*/
	wire [7:0] nums [9:0];
	assign nums[0] = 8'b1100_0000;
	assign nums[1] = 8'b1111_1001;
	assign nums[2] = 8'b1010_0100;
	assign nums[3] = 8'b1011_0000;
	assign nums[4] = 8'b1001_1001;
	assign nums[5] = 8'b1001_0010;
	assign nums[6] = 8'b1000_0010;
	assign nums[7] = 8'b1111_1000;
	assign nums[8] = 8'b1000_0000;
	assign nums[9] = 8'b1001_0000;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel_out <= 6'd0;
		end else begin
			sel_out <= sel;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sec <= 8'd0;
		end else if(sel == 6'd0) begin
			sec <= 8'd0;
		end else begin
			case(sel) 
				6'b000_001 : sec <= nums[data % 10];
				6'b000_010 : sec <= nums[(data / 10) % 10];
				6'b000_100 : sec <= nums[(data / 100) % 10];
				6'b001_000 : sec <= {1'b0,nums[addr % 10][6:0]};	//将第三位的数码管的dp点亮，起到区分地址和数据的作用
				6'b010_000 : sec <= nums[(addr / 10) % 10];
				6'b100_000 : sec <= nums[(addr / 100) % 10];
				default : sec <= 8'd0;
			endcase
		end
	end

endmodule