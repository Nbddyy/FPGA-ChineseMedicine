module KF 
#(
	parameter max = 24'd999_999
)
(
	input clk,
	input rst_n,
	input [3:0] keys,

	output reg [3:0] kf_out
);

	reg [23:0] keys_cnt [3:0];

	
	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : keys_in_cnt
		
		/*对各自索引位上的key[i]进行按键消抖判断*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				keys_cnt[i] <= 24'd0;
			end else if(keys[i] == 1'd1) begin
				keys_cnt[i] <= 24'd0;
			end else begin
				keys_cnt[i] <= keys_cnt[i] + 24'd1;
			end
		end

		/*对每个索引上的计数进行监控，当出现max-1时，则改变对应输出位位宽为1*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				kf_out[i] <= 1'b0;
			end else if(keys_cnt[i] == max - 24'd1) begin
				kf_out[i] <= 1'b1;
			end else begin
				kf_out[i] <= 1'b0;
			end
		end

	end endgenerate


endmodule