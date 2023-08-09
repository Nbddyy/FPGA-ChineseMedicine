module RAM_2_PORT_TEST2 (
	input clk,
	input rst_n	
);

	reg [15:0] data;
	reg [9:0] rdaddress;
	reg rden;
	reg [9:0] wraddress;
	reg wren;
	wire [15:0] q;

	/*用于标志记录cnt*/
	reg [15:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 16'd0;
		end else if(cnt == 16'd255) begin
			cnt <= 16'd0;
		end else begin
			cnt <= cnt + 16'd1;
		end
	end

	/*连续写入、写出的代码实现*/
	always @(posedge clk or negedge rst_n) begin

		if(~rst_n) begin
			data <= 16'd0;
			rdaddress <= 10'd0;
			rden <= 1'd0;
			wraddress <= 10'd0;
			wren <= 1'd0;
		end else if(cnt >= 16'd20 && cnt <= 16'd30) begin 	//连续写入
			data <= cnt;
			rdaddress <= 10'd0;
			rden <= 1'd0;
			wraddress <= cnt;
			wren <= 1'd1;
		end else if(cnt >= 16'd50 && cnt <= 16'd60) begin 	//连续写出
			data <= cnt;
			rdaddress <= cnt - 10'd30;
			rden <= 1'd1;
			wraddress <= 10'd0;
			wren <= 1'd0;
		end else begin
			data <= 16'd0;
			rdaddress <= 10'd0;
			rden <= 1'd0;
			wraddress <= 10'd0;
			wren <= 1'd0;
		end

	end

	RAM_16_1024	RAM_16_1024_inst (
		.clock ( clk ),
		.data ( data ),
		.rdaddress ( rdaddress ),
		.rden ( rden ),
		.wraddress ( wraddress ),
		.wren ( wren ),
		.q ( q )
	);


endmodule