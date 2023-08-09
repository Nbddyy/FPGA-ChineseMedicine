module For_10_Integrated_Wave_4 (
	input clk,
	input rst_n
	
);

	reg [13:0] address;
	reg rden;
	wire [7:0] q;

	reg [11:0] cnt_4096;
	reg [3:0] cnt_10;
	reg [1:0] cnt_4;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4096 <= 12'd0;
		end else begin
			cnt_4096 <= cnt_4096 + 12'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_10 <= 4'd0;
		end else if(cnt_10 == 4'd9 && cnt_4096 == 12'd4095) begin
			cnt_10 <= 4'd0;
		end else if(cnt_4096 == 12'd4095) begin
			cnt_10 <= cnt_10 + 4'd1;
		end else begin
			cnt_10 <= cnt_10;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4 <= 2'd0;
		end else if(cnt_10 == 4'd9 && cnt_4096 == 12'd4095) begin
			cnt_4 <= cnt_4 + 2'd1;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 14'd0;
			rden <= 1'd0;
		end else begin
			rden <= 1'd1;
			case(cnt_4) 
			 	2'd0 : address <= cnt_4096;
			 	2'd1 : address <= cnt_4096 + 14'd4096;
			 	2'd2 : address <= cnt_4096 + 14'd8192;
			 	2'd3 : address <= cnt_4096 + 14'd12288;
			 	default : address <= 14'd0;
			endcase
		end
	end


	ROM_Single_8_16384 ROM_Single_8_16384_1 (
		.address(address),
		.clock(clk),
		.rden(rden),
		.q(q));

endmodule