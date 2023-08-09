module KEY_DOUBLE (
	input sys_clk,    
	input sys_rst_n,  
	input key_in,
	output key_flag
);

	reg [1:0] count;
	reg [23:0] cnt_20ms;
	reg [31:0] interval_cnt;

	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			cnt_20ms <= 24'd0;
		end else if(key_in == 1'd1) begin
			cnt_20ms <= 24'd0;
		end else if(cnt_20ms == 24'd999_999 && key_in == 1'd0) begin
			cnt_20ms <= cnt_20ms;
		end else begin
			cnt_20ms <= cnt_20ms + 1;
		end
	end

	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			interval_cnt <= 32'd0;
		end else if(count >= 2'd1 && key_in == 1'd1) begin
			interval_cnt <= interval_cnt + 32'd1;
		end else begin
			interval_cnt <= 32'd0;
		end
	end

	/*使用变量count对其进行计数在稳定态内的按键个数进行统计，
	满足和为2则置输出端为1，为方便观察其现象，第二次按键不松开*/
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			count <= 2'd0;
		end else if(interval_cnt > 32'd29_999_999) begin
			count <= 2'd0;
		end else if (cnt_20ms == 24'd999_998) begin
			count <= count + 2'd1;
		end else begin
			count <= count;
		end
	end

	assign key_flag = (count >= 2'd2) ? 1'd0 : 1'd1;

endmodule