// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : yongchan jeon (Kris) poucotm@gmail.com
// File   : FIFO_TEST.v
// Create : 2023-08-05 15:42:41
// Revise : 2023-08-05 15:42:41
// Editor : sublime text4, tab size (4)
// Descri : 三种输出形式，在第78行进行控制，分别验证奇数、偶数个输入和随机输入的情况
// -----------------------------------------------------------------------------
module FIFO_TEST (
	input clk,
	input rst_n,
	input [15:0] random_data
);
	
	/*定义FIFO端口变量*/
	reg [10:0] cnt_2048;

	reg [15:0] wr_data;
	reg wr_en;

	reg [10:0] data_num;		//当wr_data满足10-30时将其写入
	reg [10:0] data_num_latch;

	reg rd_en;
	wire [15:0] fifo_data_out;
	wire full;
	wire empty;
	wire [10:0] usedw;

	/*定义单端口RAM变量*/
	reg [10:0] addr_max;

	reg [10:0] one_port_ram_addr;
	reg one_port_ram_wren;
	reg one_port_ram_rden;
	wire [15:0] one_port_ram_dataout;

	/*定义双端口RAM变量*/
	reg [10:0] addr_count [2:0]; 

	reg double_ram1_wren [2:0];
	reg [10:0] double_ram1_wraddr [2:0];
	reg double_ram1_rden [2:0];

	reg double_ram1_rden_clap [2:0]; 
	wire double_ram1_aclr [2:0];

	reg [10:0] double_ram1_rdaddr [2:0];
	wire [15:0] double_ram1_dataout [2:0];
	
	/***********************************************************************/

	/*模块FIFO_16_2048的相关代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_2048 <= 11'd0;
		end else begin
			cnt_2048 <= cnt_2048 + 11'd1;
		end
	end

	
	

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wr_data <= 16'd0;
			wr_en <= 1'd0;
			data_num <= 11'd0;
			data_num_latch <= 11'd0;
		end else if(cnt_2048 >= 11'd10 && cnt_2048 <= 11'd20) begin
			wr_data <= random_data;
			wr_en <= 1'd1;
			data_num <= data_num + 11'd1;
			data_num_latch <= data_num + 11'd1;
		end else begin
			wr_data <= 16'd0;
			wr_en <= 1'd0;
			data_num <= 11'd0;
			data_num_latch <= data_num_latch;
		end
	end

	/*当wr_data满足50-70将其输出*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rd_en <= 1'd0;
		end else if(cnt_2048 >= 16'd60 && cnt_2048 < 16'd60 + data_num_latch) begin
			rd_en <= 1'd1;
		end else begin
			rd_en <= 1'd0;
		end
	end


	/*注意存储器特性：当没有读入数据时，一直保持输出最后的数据*/
	/***********************************************************************/

	/*模块RAM_Single_16_2048的代码实现*/
	/*当检测到fifo_data_out不为零时拉高wren*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			one_port_ram_wren <= 1'd0;
			one_port_ram_addr <= 11'd0;
			addr_max <= 11'd0;
		end else if(rd_en) begin
			one_port_ram_wren <= 1'd1;
			one_port_ram_addr <= cnt_2048;
			addr_max <= cnt_2048;
		end else if(cnt_2048 >= addr_max + 11'd2 && cnt_2048 <= addr_max + 11'd2 + data_num_latch) begin
			one_port_ram_addr <= cnt_2048 - 11'd1 - data_num_latch;
			one_port_ram_wren <= 1'd0;
		end	else begin
			one_port_ram_wren <= 1'd0;
			one_port_ram_addr <= 11'd0;
			addr_max <= addr_max;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			one_port_ram_rden <= 1'd0;
		end else if(cnt_2048 >= addr_max + 11'd2 && cnt_2048 <= addr_max + 11'd1 + data_num_latch) begin
			one_port_ram_rden <= 1'd1;
		end else begin
			one_port_ram_rden <= 1'd0;
		end
	end


	/***********************************************************************/

	/*模块generat_for的顶层设计*/

	/*实现对数据倒着读的模块调用*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_wren[0] <= 1'd0;
			double_ram1_wraddr[0] <= 11'd0;
		end else if(one_port_ram_rden) begin
			double_ram1_wren[0] <= 1'd1;
			double_ram1_wraddr[0] <= cnt_2048;
			addr_count[0] <= cnt_2048;
		end else begin
			double_ram1_wren[0] <= 1'd0;
			double_ram1_wraddr[0] <= 11'd0;
		end
	end

	/*倒序读的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden[0] <= 1'd0;
			double_ram1_rdaddr[0] <= 11'd0;
		end else if(cnt_2048 >= addr_count[0] + 11'd2 && cnt_2048 <= addr_count[0] + 11'd1 + data_num_latch) begin
			double_ram1_rden[0] <= 1'd1;
			double_ram1_rdaddr[0] <= addr_count[0] - (cnt_2048 - addr_count[0] - 11'd2);
		end else begin
			double_ram1_rden[0] <= 1'd0;
			double_ram1_rdaddr[0] <= 11'd0;
		end
	end

	/*对double_ram1_rden打拍*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden_clap[0] <= 1'd0;
		end else begin
			double_ram1_rden_clap[0] <= double_ram1_rden[0];
		end
	end

	assign double_ram1_aclr[0] = double_ram1_rden_clap[0] || double_ram1_rden[0];

	/***********************************************************************/

	/*实现找出数据最大值地址的模块调用*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_wren[1] <= 1'd0;
			double_ram1_wraddr[1] <= 11'd0;
		end else if(one_port_ram_rden) begin
			double_ram1_wren[1] <= 1'd1;
			double_ram1_wraddr[1] <= cnt_2048;
			addr_count[1] <= cnt_2048;
		end else begin
			double_ram1_wren[1] <= 1'd0;
			double_ram1_wraddr[1] <= 11'd0;
		end
	end

	/*对数据读的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden[1] <= 1'd0;
			double_ram1_rdaddr[1] <= 11'd0;
		end else if(cnt_2048 >= addr_count[1] + 11'd2 && cnt_2048 <= addr_count[1] + 11'd1 + data_num_latch) begin
			double_ram1_rden[1] <= 1'd1;
			double_ram1_rdaddr[1] <= cnt_2048 - 11'd1 - data_num_latch;
		end else begin
			double_ram1_rden[1] <= 1'd0;
			double_ram1_rdaddr[1] <= double_ram1_rdaddr[1];
		end
	end

	/*对double_ram1_rden打拍*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden_clap[1] <= 1'd0;
		end else begin
			double_ram1_rden_clap[1] <= double_ram1_rden[1];
		end
	end

	assign double_ram1_aclr[1] = double_ram1_rden_clap[1] || double_ram1_rden[1];

	/*最大值比较并拿到对应地址*/
	reg [15:0] temp;
	reg [10:0] max_addr;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			temp <= 16'd0;
			max_addr <= 11'd0;
		end else if(double_ram1_aclr[1] && double_ram1_dataout[1]) begin
			if(temp <= double_ram1_dataout[1]) begin
				temp <= double_ram1_dataout[1];
				if(~double_ram1_rden[1]) begin
					max_addr <= double_ram1_rdaddr[1];
				end else begin
					max_addr <= double_ram1_rdaddr[1] - 11'd1;
				end
			end
		end else begin
			temp <= 16'd0;
			max_addr <= 11'd0;
		end
	end


	/***********************************************************************/

	/*FFTSHIFT函数功能的代码实现*/
	reg [10:0] addr_num;	//用于记录存储的数据个数
	reg [10:0] addr_num_latch;	//用于锁存上述变量

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_wren[2] <= 1'd0;
			double_ram1_wraddr[2] <= 11'd0;
			addr_num <= 11'd0;
			addr_num_latch <= 11'd0;
		end else if(one_port_ram_rden) begin
			double_ram1_wren[2] <= 1'd1;
			double_ram1_wraddr[2] <= cnt_2048;
			addr_count[2] <= cnt_2048;
			addr_num <= addr_num + 11'd1;
			addr_num_latch <= addr_num + 11'd1;
		end else begin
			double_ram1_wren[2] <= 1'd0;
			double_ram1_wraddr[2] <= 11'd0;
			addr_num <= 11'd0;
			addr_num_latch <= addr_num_latch;
		end
	end

	/*对数据读的代码实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden[2] <= 1'd0;
			double_ram1_rdaddr[2] <= 11'd0;
		end else if(cnt_2048 >= addr_count[2] + 11'd2 && cnt_2048 <= addr_count[2] + 11'd1 + data_num_latch) begin
			double_ram1_rden[2] <= 1'd1;
			
			//实现对写入数据fftshift的输出格式
			case(addr_num_latch % 2)
				1'd0 : begin
					if(cnt_2048 <= addr_count[2] + 11'd1 + addr_num_latch / 2) begin
						double_ram1_rdaddr[2] <= cnt_2048 - 11'd1 - (addr_num_latch / 2);
					end else begin
						double_ram1_rdaddr[2] <= cnt_2048 - 11'd1 -  (addr_num_latch / 2) - (addr_num_latch);
					end
				end

				1'd1 : begin
					if(cnt_2048 <= addr_count[2] + (addr_num_latch + 1) / 2) begin
						double_ram1_rdaddr[2] <= cnt_2048 - (addr_num_latch + 1) / 2;
					end else begin
						double_ram1_rdaddr[2] <= cnt_2048 - (addr_num_latch + 1) / 2 - (addr_num_latch);
					end
				end

				default : double_ram1_rdaddr[2] <= 11'd0;
			endcase

		end else begin
			double_ram1_rden[2] <= 1'd0;
			double_ram1_rdaddr[2] <= 11'd0;
		end
	end

	/*对double_ram1_rden打拍*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			double_ram1_rden_clap[2] <= 1'd0;
		end else begin
			double_ram1_rden_clap[2] <= double_ram1_rden[2];
		end
	end

	assign double_ram1_aclr[2] = double_ram1_rden_clap[2] || double_ram1_rden[2];



	/***********************************************************************/

	/*模块实例化*/
	genvar i;
	generate for(i = 0; i < 3; i = i + 1) begin : RAM_Double_16_2048_ctrl
		RAM_Double_16_2048 inst_RAM_Double_16_2048 (
			.aclr(~double_ram1_aclr[i]),
			.clock(clk),
			.data(one_port_ram_dataout),
			.rdaddress(double_ram1_rdaddr[i]),
			.rden(double_ram1_rden[i]),
			.wraddress(double_ram1_wraddr[i]),
			.wren(double_ram1_wren[i]),
			.q(double_ram1_dataout[i]));
	end endgenerate

	FIFO_16_2048 FIFO_16_2048_1 (
		.clock(clk),
		.data(wr_data),
		.rdreq(rd_en),
		.wrreq(wr_en),
		.empty(empty),
		.full(full),
		.q(fifo_data_out),
		.usedw(usedw));

	RAM_Single_16_2048 RAM_Single_16_2048_1 (
		.address(one_port_ram_addr),
		.clock(clk),
		.data(fifo_data_out),
		.rden(one_port_ram_rden),
		.wren(one_port_ram_wren),
		.q(one_port_ram_dataout));

endmodule