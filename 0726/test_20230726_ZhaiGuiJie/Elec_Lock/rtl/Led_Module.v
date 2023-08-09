module Led_Module (
	input clk,
	input rst_n,
	input [1:0] led_in,
	output reg [4:0] led_out
);

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= 5'b1111_0;
		end else if(led_in == 2'd0) begin
			led_out <= 5'b1111_0;
		end else if(led_in == 2'd1) begin
			led_out <= 5'b0000_0;
		end else if(led_in == 2'd2) begin
			led_out <= 5'b1111_1;
		end else begin
			led_out <= led_out;
		end
	end

endmodule 