module Poll_Detect (
	input fifo_rdclk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [2:0] access,
	input [63:0] q_in,
	output reg data_valid,
	output reg [63:0] up_data
);

	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end else if(access != 3'd0) begin
			data_valid <= 1'd1;
			up_data <= q_in;
		end else begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end
	end

endmodule