module SM (
	input clk,
	input rst_n,
	input wire data_in,
	output reg find_ok	
);

	reg [7:0] state;
	parameter IDLE = 8'd0;
	parameter S0 = 8'd1;
	parameter S1 = 8'd2;
	parameter S2 = 8'd3;
	parameter S3 = 8'd4;
	parameter S4 = 8'd5;

	/*六种状态机转换的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= 8'd0;
		end else begin
			case(state)
				IDLE: begin
					if(data_in) begin
						state <= S0;
					end else begin
						state <= IDLE;
					end
				end
				S0 : begin
					if(data_in) begin
						state <= S0;
					end else begin
						state <= S1;
					end
				end
				S1 : begin
					if(data_in) begin
						state <= S0;
					end else begin
						state <= S2;
					end
				end
				S2 : begin
					if(data_in) begin
						state <= S3;
					end else begin
						state <= IDLE;
					end
				end
				S3 : begin
					if(data_in) begin
						state <= S0;
					end else begin
						state <= S4;
					end
				end
				S4 : begin
					if(data_in) begin
						state <= S0;
					end else begin
						state <= S2;
					end
				end
				default : state <= IDLE;
			endcase
		end
	end

	/*当状态机state为S4时，则拉高find_ok*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			find_ok <= 1'd0;
		end else if(state == S4) begin
			find_ok <= 1'd1;
		end else begin
			find_ok <= 1'd0;
		end
	end

endmodule



