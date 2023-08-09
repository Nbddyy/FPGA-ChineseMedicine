module Water_Lamp_Extension 
#(
	parameter max1 = 32'd24_999_999,
	parameter max2 = 32'd49_999_999,
	parameter max3 = 32'd74_999_999
)
(
	input clk,
	input rst_n,
	output reg [3:0] led_state
);

	reg [31:0] temp;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp <= 32'd0;
		end else if(temp == max3) begin
			temp <= 32'd0;
		end else begin
			temp <= temp + 32'd1;
		end
	end

	reg flag;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			flag <= 1'd0;
		end else if(temp == max3) begin
			flag <= ~flag;
		end else begin
			flag <= flag;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_state <= 4'b1110;
		end else if(temp == max1 || temp == max2 || temp == max3) begin
			case(flag) 
				1'd0: led_state <= {{led_state[2:0]},{led_state[3]}};
				1'd1: led_state <= {{led_state[0]},{led_state[3:1]}};
			endcase
		end else begin
			led_state <= led_state;
		end
	end

	

endmodule