module TEST 
#(
	parameter max = 32'd24_999_999
)
(
	input clk,
	input rst_n, 
	output reg led_out
);

	reg [31:0] cnt [1023:0];


	genvar i;
	generate for(i = 0; i < 1024; i = i+ 1) begin : GENERATE_TEST

		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				cnt[i] <= 32'd0;
			end else if(cnt[i] == max) begin
				cnt[i] <= 32'd0;
			end else begin
				cnt[i] <= cnt[i] + 32'd1;
			end
		end



	end
	endgenerate

	/*通过上版signalTapⅡ分段两个窗口采样对信号led_out的边沿进行事件触发，发现每次亮灭的时间均为0.5s*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= 1'd1;
		end else if(cnt[666] == max) begin
			/*cnt[666]可以实现led_out灯0.5s亮灭，
			更改为cnt[i]会发生索引超出设置亮[1023:0]即1024
			更改为(i != 1024 && cnt[i] == max)报同样的索引溢出
			更改为(cnt[666] == max || cnt[667] == max) 仿真正确
			*/
			led_out <= ~led_out;
		end else begin
			led_out <= led_out;
		end
	end

	
	

endmodule