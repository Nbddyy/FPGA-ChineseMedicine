module Okay_module (
	input clk,
	input rst_n,
	input in1,
	input in2,
	input in3,
	input in4,
	output reg [1:0] result
);

	/*定义一个六位宽的寄存器用来校准电子锁密码*/
	reg [5:0] elec_lock_password;

	/*使用位拼接来固定按键顺序*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			elec_lock_password <= 6'd0;
		end else if(in1 == 1'd1) begin
			elec_lock_password <= {elec_lock_password[3:0],2'b01};
		end else if(in2 == 1'd1) begin
			elec_lock_password <= {elec_lock_password[3:0],2'b10};
		end else if(in3 == 1'd1) begin
			elec_lock_password <= {elec_lock_password[3:0],2'b11};
		end else begin
			elec_lock_password <= elec_lock_password;
		end
	end

	/*进行按键okay_key确认*/
	/*result输出0表示没有按键okay_key确认，输出1表示密码正确，输出2
	表示密码错误*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			result <= 2'd0;
		end else if(elec_lock_password == 6'b10_01_11 && in4) begin
			result <= 2'd1;
		end else if(in4) begin
			result <= 2'd2;
		end else begin
			result <= result;
		end
	end

endmodule