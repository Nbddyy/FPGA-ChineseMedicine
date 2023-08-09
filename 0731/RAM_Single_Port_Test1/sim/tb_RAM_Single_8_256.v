`timescale 1ns/1ps
module tb_RAM_Single_8_256 (); /* this is automatically generated */

	reg clk;
	reg rst_n;
	reg [7:0] cnt;
	reg [7:0] address;
	reg [7:0] data;
	reg rden;
	reg wren;
	wire [7:0] q;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk = ~clk;

	/*实现cnt从0到255的循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;
		end
	end

	/*连续写入和连续写出的代码实现*/
	always @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			address <= 8'd0;
			data <= 8'd0;
			rden <= 1'd0;
			wren <= 1'd0;
		end else if(cnt >= 8'd10 && cnt <= 8'd19) begin 	//连续写入
			address <= cnt;
			data <= {$random} % 100;
			wren <= 1'd1;
		end else if(cnt >= 8'd30 && cnt <= 8'd39) begin 	//连续写出
			address <= cnt - 8'd20;
			rden <= 1'd1;
		end else begin
			address <= 8'd0;
			data <= 8'd0;
			rden <= 1'd0;
			wren <= 1'd0;
		end
	end

	RAM_Single_8_256 inst_RAM_Single_8_256 (.aclr(~rst_n), .address(address), .clock(clk), .data(data), .rden(rden), .wren(wren), .q(q));

	
endmodule
