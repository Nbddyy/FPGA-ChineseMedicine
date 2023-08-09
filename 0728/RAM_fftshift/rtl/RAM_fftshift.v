module RAM_fftshift (
	input clk,
	input rst_n
);

	reg [7:0] data;
	reg [7:0] rdaddress;
	reg rden;
	reg [7:0] wraddress;
	reg wren;
	wire [7:0] q;
	
	
	reg [7:0] cnt;	//用于记录寄存地址
	reg [7:0] cnt_num;	//记录写入时的数据个数
	reg [7:0] use_address;	//用于记录下一次该写入数据的地址
	reg [7:0] temp;		//用于暂存cnt_num的值，实现寄存器cnt_num的循环利用


	/*用于确定寄存地址*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;
		end
	end

	/*连续写入[1 2 3 4 5 6 7 8 9]*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data <= 8'd0;
			wren <= 1'd0;
			wraddress <= 8'd0;
			use_address <= 8'd0;
			cnt_num <= 8'd0;
			temp <= 8'd0;
		end else if(cnt >= 8'd1 && cnt <= 8'd9) begin
			data <= cnt;
			wren <= 1'd1;
			wraddress <= use_address;
			use_address <= use_address + 8'd1;
			cnt_num <= cnt_num + 8'd1;
			temp <= cnt_num + 8'd1;
		end else begin
			data <= 8'd0;
			wren <= 1'd0;
			wraddress <= 8'd0;
			cnt_num <= 8'd0;
		end
	end

	/*实现fftshift函数功能的代码体现
	格式整理连续输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rden <= 1'd0;
			rdaddress <= 8'd0;
		end else if(cnt >= 8'd12 && cnt <= 8'd11 + temp) begin
			rden <= 1'd1;
			/*判断temp奇偶数*/
			if(temp % 2 == 8'd0) begin 	//偶数
				case(cnt < 8'd12 + temp / 2)
					1'd1 : rdaddress <= cnt - temp + 8'd1;
					1'd0 : rdaddress <= cnt - 8'd12 - temp / 2;
					default : rdaddress <= 8'd0;
				endcase
			end else begin
				case(cnt < 8'd11 + (temp + 8'd1) / 2)
					1'd1 : rdaddress <= cnt - temp + 8'd2;
					1'd0 : rdaddress <= cnt - 8'd11 - (temp + 8'd1) / 2;
					default : rdaddress <= 8'd0;
				endcase
			end
		end else begin
			rden <= 1'd0;
			rdaddress <= 8'd0;
		end
	end

	RAM_8_256 RAM_8_256_1 (
		.clock(clk),
		.data(data),
		.rdaddress(rdaddress),
		.rden(rden),
		.wraddress(wraddress),
		.wren(wren),
		.q(q));

endmodule