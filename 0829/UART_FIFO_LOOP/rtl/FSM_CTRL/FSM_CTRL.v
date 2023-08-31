module FSM_CTRL 
#(
    parameter usedw_latch = 8'd4
)
(
	input clk,
	input rst_n, 
	input op_flag,
	input [7:0] op_data,
	input tx_flag,
	output reg ip_flag,
	output reg [7:0] ip_data
);

	wire [7:0] q;
	wire [7:0] usedw; 

	reg ip_flag_latch;

	reg tx_first_flag;

	/*temp ip_flag_latch*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_flag_latch <= 1'd0;
		end else if(usedw == 8'd0) begin
			ip_flag_latch <= 1'd0;
		end else if(usedw == usedw_latch) begin
			ip_flag_latch <= 1'd1;
		end else begin
			ip_flag_latch <= ip_flag_latch;
		end
	end

	/*output ip_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_flag <= 1'd0;
			tx_first_flag <= 1'd1;
		end else if((tx_flag || tx_first_flag) && ip_flag_latch) begin
			ip_flag <= 1'd1;
			tx_first_flag <= 1'd0;
		end else if(!usedw) begin
			ip_flag <= 1'd0;
			tx_first_flag <= 1'd1;
		end else begin
			ip_flag <= 1'd0;
			tx_first_flag <= tx_first_flag;
		end
	end

	/*output ip_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_data <= 8'd0;
		end else if(tx_flag && ip_flag_latch) begin
			ip_data <= q; 	//需要超前输出
		end else if(tx_first_flag) begin
			ip_data <= q;
		end else begin
			ip_data <= ip_data;
		end
	end

	SCFIFO_8_256 inst_SCFIFO_8_256 (
		.clock(clk),
		.data(op_data),
		.rdreq(ip_flag),
		.wrreq(op_flag),
		.q(q),
		.usedw(usedw));


endmodule 