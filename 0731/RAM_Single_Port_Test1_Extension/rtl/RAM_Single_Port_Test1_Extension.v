module RAM_Single_Port_Test1_Extension (
	input clk,
	input rst_n	
);

	reg [7:0] address;
	reg [7:0] data;
	reg rden;
	reg wren;
	wire [7:0] q;

	reg [7:0] cnt;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;
		end
	end

	/*写操作*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wren <= 1'd0;
			rden <= 1'd0;
			address <= 8'd0;
			data <= 8'd0;
		end else if(cnt >= 8'd10 && cnt <= 8'd20) begin
			wren <= 1'd1;
			address <= cnt;
			data <= cnt;
		end else if(cnt >= 8'd30 && cnt <= 8'd40) begin
			rden <= 1'd1;
			address <= cnt - 8'd20;
		end else begin
			wren <= 1'd0;
			address <= 8'd0;
			data <= 8'd0;
			rden <= 1'd0;
		end
	end


	RAM_Single_8_256	RAM_Single_8_256_inst (
		.address ( address ),
		.clock ( clk ),
		.data ( data ),
		.rden ( rden ),
		.wren ( wren ),
		.q ( q )
	);

endmodule