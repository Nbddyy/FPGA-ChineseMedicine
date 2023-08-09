module RAM_2_PORT (
	input clk,
	input rst_n
);

	reg [7:0] data;
	reg [7:0] rdaddress;
	reg [7:0] wraddress;
	reg wren;
	wire [7:0] q;

	/*定义一个cnt计数*/
	reg [7:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(cnt == 8'd255) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;
		end
	end

	/*单独写，单独读，连续写，连续读的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		
		if(~rst_n) begin
			data <= 8'd0;
			wraddress <= 8'd0;
			wren <= 1'd0;
			rdaddress <= 8'd0;
		end else if(cnt == 8'd20) begin 	//单独写
			data <= cnt;
			wren <= 1'd1;
			wraddress <= cnt;
			rdaddress <= 8'd0;
		end else if(cnt == 8'd30) begin 	//单独读
			data <= 8'd0;
			wren <= 1'd0;
			wraddress <= 8'd0;
			rdaddress <= cnt - 8'd10;
		end else if(cnt >= 8'd40 && cnt <= 8'd60) begin 	//连续写
			data <= cnt;
			wren <= 1'd1;
			wraddress <= cnt;
			rdaddress <= 8'd0;
		end else if(cnt >= 8'd70 && cnt <= 8'd80) begin 	//连续读
			data <= 8'd0;
			wren <= 1'd0;
			wraddress <= 8'd0;
			rdaddress <= cnt - 8'd30;
		end else begin
			data <= 8'd0;
			wraddress <= 8'd0;
			wren <= 1'd0;
			rdaddress <= 8'd0;
		end

	end

	MY_RAM	MY_RAM_1 (
		.clock ( clk ),
		.data ( data ),
		.rdaddress ( rdaddress ),
		.wraddress ( wraddress ),
		.wren ( wren ),
		.q ( q )
	);

endmodule