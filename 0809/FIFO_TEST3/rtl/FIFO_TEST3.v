module FIFO_TEST3 (
	input rst_n,
	input [7:0] random_data,
	input wrclk,
	input rdclk,
	output data_valid,
	output [63:0] up_data
);
	

	reg [7:0] cnt_20;
	reg [7:0] cnt_15;
	reg [7:0] cnt_50;
	reg [7:0] cnt_100;

	//定义DCFIFO各变量
	//数据写入端
	reg wrreq [3:0];
	reg [31:0] data [3:0];
	wire [13:0] wrusedw [3:0];

	//数据读出端
	reg rdreq [3:0];
	wire [12:0] rdusedw [3:0];
	wire [63:0] q [3:0];

	

	//Poll_Detect端口
	reg [2:0] access;	//用来标识输出数据来自哪个缓存FIFO通道
	reg [63:0] q_in;

	/***********************************************************************/
	/*通道1-20计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_20 <= 8'd0;
		end else if(cnt_20 == 8'd19) begin
			cnt_20 <= 8'd0;
		end else begin
			cnt_20 <= cnt_20 + 8'd1;
		end
	end

	/*通道2-15计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_15 <= 8'd0;
		end else if(cnt_15 == 8'd14) begin
			cnt_15 <= 8'd0;
		end else begin
			cnt_15 <= cnt_15 + 8'd1;
		end
	end

	/*通道3-50计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_50 <= 8'd0;
		end else if(cnt_50 == 8'd49) begin
			cnt_50 <= 8'd0;
		end else begin
			cnt_50 <= cnt_50 + 8'd1;
		end
	end

	/*通道4-100计数*/
	always@(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(cnt_100 == 8'd99) begin
			cnt_100 <= 8'd0;
		end else begin
			cnt_100 <= cnt_100 + 8'd1;
		end
	end

	/***********************************************************************/

	/***********************************************************************/
	/*缓存FIFO通道1*/
	/*DCFIFO通道1的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[0] <= 32'd0;
			wrreq[0] <= 1'd0;
		end else if(cnt_20 == 8'd19) begin
			data[0] <= random_data;
			wrreq[0] <= 1'd1;
		end else begin
			data[0] <= 32'd0;
			wrreq[0] <= 1'd0;
		end
	end

	/*通道1数据写出
	当检测到其他IP核输入到达阈值时，优先输出该IP核数据*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			rdreq[0] <= 1'd0;
		end else if(rdusedw[0] == 13'd128) begin
			rdreq[0] <= 1'd1;
		end else if(rdusedw[0] == 13'd0 || rdusedw[1] == 13'd128 || rdusedw[2] == 13'd128 || rdusedw[3] == 13'd128) begin
			rdreq[0] <= 1'd0;
		end else begin
			rdreq[0] <= rdreq[0];
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道2*/
	/*DCFIFO通道2的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[1] <= 32'd0;
			wrreq[1] <= 1'd0;
		end else if(cnt_15 == 8'd14) begin
			data[1] <= random_data;
			wrreq[1] <= 1'd1;
		end else begin
			data[1] <= 32'd0;
			wrreq[1] <= 1'd0;
		end
	end

	/*通道2数据写出*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			rdreq[1] <= 1'd0;
		end else if(rdusedw[1] == 13'd128) begin
			rdreq[1] <= 1'd1;
		end else if(rdusedw[0] == 13'd128 || rdusedw[1] == 13'd0 || rdusedw[2] == 13'd128 || rdusedw[3] == 13'd128) begin
			rdreq[1] <= 1'd0;
		end else begin
			rdreq[1] <= rdreq[1];
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道3*/
	/*DCFIFO通道3的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[2] <= 32'd0;
			wrreq[2] <= 1'd0;
		end else if(cnt_50 == 8'd49) begin
			data[2] <= random_data;
			wrreq[2] <= 1'd1;
		end else begin
			data[2] <= 32'd0;
			wrreq[2] <= 1'd0;
		end
	end

	/*通道3数据写出*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			rdreq[2] <= 1'd0;
		end else if(rdusedw[2] == 13'd128) begin
			rdreq[2] <= 1'd1;
		end else if(rdusedw[0] == 13'd128 || rdusedw[1] == 13'd128 || rdusedw[2] == 13'd0 || rdusedw[3] == 13'd128) begin
			rdreq[2] <= 1'd0;
		end else begin
			rdreq[2] <= rdreq[2];
		end
	end

	/***********************************************************************/

	/*缓存FIFO通道4*/
	/*DCFIFO通道4的输入代码实现*/
	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data[3] <= 32'd0;
			wrreq[3] <= 1'd0;
		end else if(cnt_100 == 8'd99) begin
			data[3] <= random_data;
			wrreq[3] <= 1'd1;
		end else begin
			data[3] <= 32'd0;
			wrreq[3] <= 1'd0;
		end
	end

	/*通道3数据写出*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			rdreq[3] <= 1'd0;
		end else if(rdusedw[3] == 13'd128) begin
			rdreq[3] <= 1'd1;
		end else if(rdusedw[0] == 13'd128 || rdusedw[1] == 13'd128 || rdusedw[2] == 13'd128 || rdusedw[3] == 13'd0) begin
			rdreq[3] <= 1'd0;
		end else begin
			rdreq[3] <= rdreq[3];
		end
	end

	/***********************************************************************/


	genvar i;
	generate for(i = 0; i < 4; i = i + 1) begin : generate_4_dcfifo
		DCFIFO_32IN_64OUT_16384 inst_DCFIFO_32IN_64OUT_16384 (
			.data(data[i]),
			.rdclk(rdclk),
			.rdreq(rdreq[i]),
			.wrclk(wrclk),
			.wrreq(wrreq[i]),
			.q(q[i]),
			.rdusedw(rdusedw[i]),
			.wrusedw(wrusedw[i]));
	end endgenerate


	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			access <= 3'd0;
			q_in <= 64'd0;
		end else begin
			if(rdusedw[0] == 13'd128) begin
				access <= 3'd1;
				q_in <= q[0];
			end else if(rdusedw[1] == 13'd128) begin
				access <= 3'd2;
				q_in <= q[1];
			end else if(rdusedw[2] == 13'd128) begin
				access <= 3'd3;
				q_in <= q[2];
			end else if(rdusedw[3] == 13'd128) begin
				access <= 3'd4;
				q_in <= q[3];
			end else if(rdusedw[0] == 13'd0 || rdusedw[1] == 13'd0 || rdusedw[2] == 13'd0 || rdusedw[3] == 13'd0) begin
				access <= 3'd0;
				q_in <= 64'd0;
			end else begin
				access <= access;
				q_in <= (access == 3'd0) ? 64'd0 : q[access - 3'd1];
			end
		end
	end

	Poll_Detect Poll_Detect_1 (
		.rdclk(rdclk),    //时钟与DCFIFO的rdclk保持一致
		.rst_n(rst_n),
		.access(access),
		.q_in(q_in),
		.data_valid(data_valid),
		.up_data(up_data)
);

endmodule
