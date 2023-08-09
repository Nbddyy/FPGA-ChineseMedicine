module Elec_Lock (
	input clk,
	input rst_n,
	input user_key_1,
	input user_key_2,
	input user_key_3,
	input okay_key,
	output reg [3:0] led_control
);

	wire out1;
	wire out2;
	wire out3;
	wire out4;

	wire [1:0] result;
	wire [4:0] led_out;
	wire [4:0] flash_out;

	Key_Filter Key_Filter_1 
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(user_key_1),
		.out(out1)
	);

	Key_Filter Key_Filter_2 
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(user_key_2),
		.out(out2)
	);

	Key_Filter Key_Filter_3
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(user_key_3),
		.out(out3)
	);

	Key_Filter Key_Filter_4
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(okay_key),
		.out(out4)
	);

	Okay_module Okay_module_1 (
		.clk(clk),
		.rst_n(rst_n),
		.in1(out1),
		.in2(out2),
		.in3(out3),
		.in4(out4),
		.result(result)
	);

	Led_Module Led_Module_1 (
		.clk(clk),
		.rst_n(rst_n),
		.led_in(result),
		.led_out(led_out)
	);

	Flash_Led Flash_Led_1 
	(
		.clk(clk),
		.rst_n(rst_n),  
		.flash_flag(led_out[0]),
		.flash_out(flash_out)
	);

	/*判断led_out[0]的真假确定是否进入Flash模块*/
	always @(posedge clk or negedge rst_n) begin

		if(~rst_n) begin
			led_control <= 4'b1111;
		end else if(led_out[0] == 1'd1) begin
			led_control <= flash_out;
		end else begin
			led_control <= led_out[4:1];
		end
		
	end

endmodule