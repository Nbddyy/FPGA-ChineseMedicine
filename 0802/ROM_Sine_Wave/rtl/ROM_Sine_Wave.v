module ROM_Sine_Wave (
	input clk,
	input rst_n
);

	reg [11:0] address;
	reg rden;
	wire [7:0] q;
	reg [11:0] cnt_4096;

	/*遍历地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4096 <= 12'd0;
		end else begin
			cnt_4096 <= cnt_4096 + 12'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 12'd0;
			rden <= 1'd0;
		end else begin
			address <= cnt_4096;
			rden <= 1'd1;
		end
	end

	ROM_Single_8_4096 ROM_Single_8_4096_1 (
		.address(address),
		.clock(clk),
		.rden(rden),
		.q(q));


endmodule