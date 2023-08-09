module Vending_Machine_Extension (
	input clk,
	input rst_n,
	input [2:0] keys,
	output change,
	output ship,
	output [2:0] refund,
	output reg [3:0] led_control
);

	wire [3:0] kf_out;
	wire [5:0] led_out;
	wire [3:0] single_led;
	wire [3:0] double_led;

	Key_Filter Key_Filter_1 (
		.clk(clk),
		.rst_n(rst_n),
		.keys(keys),
		.kf_out(kf_out)
	);

	Vending_Machine	Vending_Machine_1 (
		.clk(clk),
		.rst_n(rst_n),
		.coins(kf_out),
		.change(change),
		.shipping(ship),
		.refund(refund)
	);

	Led_Machine  Led_Machine_1 (
		.clk(clk),
		.rst_n(rst_n),
		.coins(kf_out),
		.led_out(led_out) 
	);


	Single_Led Single_Led_1 (
		.clk(clk),
		.rst_n(rst_n),
		.single_in(led_out[4]),
		.single_led(single_led)
	);

	Double_Led Double_Led_1 
	(
		.clk(clk),
		.rst_n(rst_n),
		.double_in(led_out[5]),
		.double_led(double_led)
	);

	/*对led_out进行判断，用来确定led_control该进入哪个模块或者直接进行输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_control <= 4'b1111;
		end else begin
			case(led_out[5:4])
				2'b00 : led_control <= led_out[3:0];
				2'b01 : led_control <= single_led;
				2'b10 : led_control <= double_led;
				default : led_control <= 4'b1111;
			endcase
		end
	end

endmodule