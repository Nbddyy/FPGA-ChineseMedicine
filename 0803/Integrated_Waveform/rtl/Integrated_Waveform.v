module Integrated_Waveform (
	input clk,
	input rst_n
);

	reg [13:0] address;
	reg rden;
	wire [7:0] q;
	reg [13:0] cnt_16384;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_16384 <= 14'd0;
		end else begin
			cnt_16384 <= cnt_16384 + 14'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 14'd0;
			rden <= 1'd0;
		end else begin
			address <= cnt_16384;
			rden <= 1'd1;
		end
	end

	ROM_Single_8_16384 ROM_Single_8_16384 (
		.address(address),
		.clock(clk),
		.rden(rden),
		.q(q));

endmodule