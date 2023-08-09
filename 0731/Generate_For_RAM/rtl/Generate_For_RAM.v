module Generate_For_RAM (
	input clk,
	input rst_n
);

	reg [7:0] address [9:0];
	reg [7:0] data [9:0];
	reg wren [9:0];
	wire [7:0] q [9:0];

	reg [7:0] cnt;	//用于对地址进行赋值

	/*计数cnt从0-255的循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			cnt <= cnt + 8'd1;	//溢出置0
		end
	end

	/*任务一*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			address[0] <= 8'd0;
			data[0] <= 8'd0;
			wren[0] <= 1'd0;	//默认写出
		end else if(cnt == 8'd10) begin 	//单个数据写入
			wren[0] <= 1'd1;
			address[0] <= cnt;
			data[0] <= cnt;
		end else if(cnt == 8'd20) begin 	//单个数据读出
			wren[0] <= 1'd0;
			address[0] <= 8'd10;
		end else begin 						//读的操作
			address[0] <= 8'd0;
			data[0] <= 8'd0;
			wren[0] <= 1'd0;
		end
	end



	/****************************************************************************************************************************/


	/*任务二*/
	/*实现连续写入和写出*/
	






	/****************************************************************************************************************************/



	/*任务三*/







	/****************************************************************************************************************************/


	/*任务四*/







	/****************************************************************************************************************************/


	/*任务五*/







	/****************************************************************************************************************************/


	genvar i;
	generate for(i = 0; i < 10; i = i + 1) begin : for_10_ram_single_8_256
		RAM_Single_8_256 inst_RAM_Single_8_256 (
			.address(address[i]),
			.clock(clk),
			.data(data[i]),
			.wren(wren[i]),
			.q(q[i]));
	end endgenerate

endmodule