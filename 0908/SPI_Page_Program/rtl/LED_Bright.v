module LED_Bright (
	input clk,
	input rst_n,
	input led_flag,
	output reg [3:0] led_out
);

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= 4'b1111;
		end else begin
			led_out <= (led_flag) ? 4'b0000 : led_out;
		end
	end

endmodule