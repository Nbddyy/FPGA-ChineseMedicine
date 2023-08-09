`timescale 1ns/1ps
module tb_RAM_Single_Port_Test2 ();

	reg clk;
	reg rst_n;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= ~clk;

	reg [9:0] address;
	reg [15:0] data;
	reg wren;
	wire [15:0] q;

	reg [9:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 10'd0;
		end else begin
			cnt <= cnt + 10'd1;
		end
	end

	/*连续写入和写出的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wren <= 1'd0;
			address <= 10'd0;
			data <= 16'd0;
		end else if(cnt >= 10'd20 && cnt <= 10'd40) begin 	//连续写入
			wren <= 1'd1;
			address <= cnt;
			data <= {$random} % 100;
		end else if(cnt >= 10'd50 && cnt <= 10'd70) begin
			wren <= 1'd0;
			address <= cnt - 10'd30;
		end else begin
			wren <= 1'd0;
			address <= 10'd0;
			data <= 16'd0;
		end
	end

	RAM_Single_Port_Test2 RAM_Single_Port_Test2_1 (
		.aclr(~rst_n),
		.address(address),
		.clock(clk),
		.data(data),
		.wren(wren),
		.q(q));

endmodule