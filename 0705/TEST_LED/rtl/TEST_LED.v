module TEST_LED (
	input CLK,
	input RST_N,
	output CNT
);

	parameter M = 32'd4999_9999;
	reg [31:0] tmp;
	reg mode;
	always@(posedge CLK or negedge RST_N) begin
		if(!RST_N) begin
			tmp <= 32'd0;
			mode <= 1'b0;
		end else if (tmp == M) begin
			tmp <= 0;
			mode <= ~mode;
		end else begin
			tmp <= tmp + 1;
		end
	end
	
	assign CNT = mode;
	
endmodule