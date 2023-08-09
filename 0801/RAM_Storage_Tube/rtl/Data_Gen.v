module Data_Gen 
#(
	parameter cnt_1ms_max = 32'd49_999
)
(
	input clk,
	input rst_n,
	input wren,
	input rden,
	output reg [7:0] addr,
	output reg [5:0] sel,
	output reg [7:0] datas
);

	reg wtemp;
	reg rtemp;
	reg [15:0] cnt_1ms;
	reg [7:0] cnt_200;
	reg [7:0] cnt;
	reg [7:0] address;
	reg [7:0] data;
	wire [7:0] q;

	/*使用wtemp暂存wren*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wtemp <= 1'd0;
		end else if((cnt == 8'd255 && cnt_200 == 8'd199 && cnt_1ms == cnt_1ms_max) || rden) begin
			wtemp <= 1'd0;
		end else if(wren) begin
			wtemp <= 1'd1;
		end else begin
			wtemp <= wtemp;
		end
	end

	/*使用rtemp暂存rden*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rtemp <= 1'd0;
		end else if((cnt == 8'd255 && cnt_200 == 8'd199 && cnt_1ms == cnt_1ms_max) || wren) begin
			rtemp <= 1'd0;
		end else if(rden) begin
			rtemp <= 1'd1;
		end else begin
			rtemp <= rtemp;
		end
	end

	/*cnt_1ms计数，用于铺垫0.2s加1和每6ms中1ms循环记录sel*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1ms <= 16'd0;
		end else if(cnt_1ms == cnt_1ms_max || (wtemp == 1'd0 && rtemp == 1'd0)) begin
			cnt_1ms <= 16'd0;
		end else begin
			cnt_1ms <= cnt_1ms + 16'd1;
		end
	end

	/*cnt_200计数，用于记录0.2s，为加1作铺垫*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_200 <= 8'd0;
		end else if((wtemp == 1'd0 && rtemp == 1'd0) || (cnt_200 == 8'd199 && cnt_1ms == cnt_1ms_max) ) begin
			cnt_200 <= 8'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_200 <= cnt_200 + 8'd1;
		end else begin
			cnt_200 <= cnt_200;
		end
	end

	/*cnt计数，用于标记对应地址和数据输入*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else if(wren || rden) begin
			cnt <= 8'd0;
		end else if(cnt == 8'd255) begin
			cnt <= 8'd255;
		end else if(cnt_200 == 8'd199 && cnt_1ms == cnt_1ms_max) begin
			cnt <= cnt + 8'd1;
		end else begin
			cnt <= cnt;
		end
	end

	/*当读写操作触发时的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address <= 8'd0;
			data <= 8'd0;
		end else if(wtemp) begin
			address <= cnt;
			data <= cnt;
		end else if(rtemp) begin
			address <= cnt;
		end else begin
			address <= 8'd0;
			data <= 8'd0;
		end
	end


	/*输出addr和datas的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			addr <= 8'd0;
			datas <= 8'd0;
		end else begin
			if(wtemp) begin
				addr <= address;
				datas <= data;
			end else if(rtemp) begin
				addr <= address;
				datas <= q;
			end else begin
				addr <= 8'd0;
				datas <= 8'd0;
			end
		end
	end

	/*输出sel的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel <= 6'd0;
		end else if(wren || rden) begin
			sel <= 6'b000_001;	//注意优先级问题
		end else if(!wtemp && !rtemp) begin
			sel <= 6'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			sel <= {{sel[4:0]},sel[5]};
		end else begin
			sel <= sel;
		end
	end


	RAM_Single_8_256 RAM_Single_8_256_1 (
		.aclr(wren),	//根据题意，使用按键wren来实现对原先地址存储的数据异步清零操作：aclr为高电平有效
		.address(address),
		.clock(clk),
		.data(data),
		.rden(rtemp),
		.wren(wtemp),
		.q(q));
	
endmodule