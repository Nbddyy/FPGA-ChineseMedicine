module RAM_MAX 
(
	input clk,
	input rst_n,
	output reg [7:0] max,
	output reg [7:0] max_address
);

	reg [7:0] data;
	reg [7:0] rdaddress;
	reg rden;
	reg [7:0] wraddress;
	reg wren;
	wire [7:0] q;


	reg [7:0] cnt;
	reg [7:0] address_max; 	//用于标识写入数据时的地址

	/*记录cnt，便于后续的连续读写操作*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;
		end
	end

	/*模拟连续写入*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data <= 8'd0;
			wraddress <= 8'd0;
			wren <= 1'd0;
			address_max <= 8'd0;
		end else if(cnt >= 8'd0 && cnt <= 8'd99) begin
			data <= cnt % 9;
			wraddress <= address_max;
			wren <= 1'd1;
			address_max <= address_max + 8'd1;
		end else begin
			data <= 8'd0;
			wraddress <= 8'd0;
			wren <= 1'd0;
		end
	end

	/*对连续写入的数据取到最大值以及对应的存储地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rdaddress <= 8'd0;
			rden <= 1'd0;
		end else if(cnt >= 8'd120 && cnt <= 8'd120 + address_max) begin
			rdaddress <= cnt - 8'd120;
			rden <= 1'd1;
		end else begin
			rdaddress <= 8'd0;
			rden <= 1'd0;
		end
	end

	/*通过对比q分析得到最大值*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			max <= 8'd0;
			max_address <= 8'd0;
		end else begin
			if(q >= max) begin
				max <= q;
				max_address <= rdaddress ? rdaddress - 8'd1 : 8'd0;
			end else begin
				max <= max;
				max_address <= max_address;
			end
		end
	end



	RAM_8_256	RAM_8_256_inst (
	.clock ( clk ),
	.data ( data ),
	.rdaddress ( rdaddress ),
	.rden ( rden ),
	.wraddress ( wraddress ),
	.wren ( wren ),
	.q ( q )
	);

endmodule

