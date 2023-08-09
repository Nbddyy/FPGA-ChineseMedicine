module KF 
#(
	parameter max = 24'd999_999,
	parameter inter_max = 32'd29_999_999	//双击判断间隔
)
(
	input clk,
	input rst_n,
	input [3:0] keys,

	output reg [7:0] kf_out
);

	reg [23:0] keys_cnt [3:0];
	reg [31:0] interval_cnt [3:0]; 
	reg [1:0] option_flag [3:0];
	
	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : keys_in_cnt
		
		/*对各自索引位上的key[i]进行按键消抖判断*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				keys_cnt[i] <= 24'd0;
			end else if(keys[i] == 1'd1) begin
				keys_cnt[i] <= 24'd0;
			end else if(keys_cnt[i] == max) begin
				keys_cnt[i] <= keys_cnt[i];
			end	else begin
				keys_cnt[i] <= keys_cnt[i] + 24'd1;
			end
		end

		/*对每次单击索引按键计数加一个延迟计数*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				interval_cnt[i] <= inter_max + 32'd2;
			end else if(keys_cnt[i] == max - 24'd1)begin
				interval_cnt[i] <= 32'd0;
			end else if(interval_cnt[i] == inter_max + 32'd2) begin
				interval_cnt[i] <= interval_cnt[i];
			end else begin
				interval_cnt[i] <= interval_cnt[i] + 32'd1;
			end
		end

		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				option_flag[i] <= 2'd0;
			end else if(option_flag[i] == 2'd1 && keys_cnt[i] == max - 24'd1 && interval_cnt[i] <= inter_max - 32'd1) begin
				option_flag[i] <= option_flag[i] + 2'd1;
			end	else if(keys_cnt[i] == max - 24'd1) begin
				option_flag[i] <= 2'd1;
			end else if(interval_cnt[i] == inter_max + 32'd1 || option_flag[i] == 2'd2) begin
				option_flag[i] <= 2'd0;
			end else begin
				option_flag[i] <= option_flag[i];
			end
		end

		/*单击输出判断
		对每个索引上的计数进行监控，当出现max-1时，则改变对应输出位位宽为1*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				kf_out[i] <= 1'b0;
			end else if(option_flag[i] == 2'd1 && interval_cnt[i] > inter_max) begin
				kf_out[i] <= 1'b1;
			end else begin
				kf_out[i] <= 1'b0;
			end
		end

		/*双击判断赋值对应[i+3]*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				kf_out[i + 4] <= 1'd0;
			end else if(option_flag[i] == 2'd2) begin
				//漏洞：当存在两位宽同时满足时，可能引发后续模块的判断优先级错误
				kf_out[i + 4] <= 1'd1;
			end else begin
				kf_out[i + 4] <= 1'd0;
			end
		end


	end endgenerate


endmodule