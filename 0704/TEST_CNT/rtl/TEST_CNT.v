module TEST_CNT (
	input CLK, 
	input RST_N,
	output CNT
);

	//练习1
	reg [7:0] tmp1;
	always@(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			tmp1 <= 8'd0;
		end else begin
			tmp1 <= tmp1 + 8'd1;
		end
	end

	//练习2
	reg [7:0] tmp2;
	always@(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			tmp2 <= 8'd0;
		end else if (tmp2 == 8'd5) begin
			tmp2 <= 8'd0;
		end else begin
			tmp2 <= tmp2 + 8'd1;
		end
	end

	//练习3
	reg [7:0] tmp3;
	always@(posedge CLK or negedge RST_N) begin
		if (!RST_N) begin
			tmp3 <= 8'd0;
		end else if (&tmp3) begin
			tmp3 <= 8'd0;
		end else begin
			tmp3 <= tmp3 + 8'd1;
		end
	end

endmodule