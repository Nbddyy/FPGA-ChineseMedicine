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

	/*实现cnt_4096的循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4096 <= 12'd0;
		end else begin
			cnt_4096 <= cnt_4096 + 12'd1;	//溢出置0
		end
	end

	/*10次计数，每种波形绘制十次然后绘制下一种波形，循环输出*/
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

	/*对应四种波形下的计数，循环输出不同的地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4 <= 2'd0;
		end else if(cnt_10 == 4'd9 && cnt_4096 == 12'd4095) begin
			cnt_4 <= cnt_4 + 2'd1;
		end else begin
			cnt_4 <= cnt_4;	//溢出置0
		end
	end

	/*不同的cnt_4下循环输出不同的地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 14'd0;
			rden <= 1'd0;
		end else begin
			rden <= 1'd1;
			case(cnt_4)
				2'd0 : begin
					address <= cnt_4096;
				end

				2'd1 : begin
					address <= cnt_4096 + 14'd4096;
				end

				2'd2 : begin
					address <= cnt_4096 + 14'd8192;
				end

				2'd3 : begin
					address <= cnt_4096 + 14'd12288;
				end

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