// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : Poll_Detect.sv
// Create : 2023-08-11 14:28:12
// Revise : 2023-08-11 20:39:03
// Editor : sublime text4, tab size (4)
// Descri : 进行判断时，避免对一个累加的数据进行条件判断；IP核为超前进位输出
// -----------------------------------------------------------------------------
module Poll_Detect (
	input fifo_rdclk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [12:0] ch_rdusedw [3:0],
	input [63:0] ch_q [3:0],
	output reg ch_rdreq [3:0],
	output reg data_valid,
	output reg [63:0] up_data
);

	reg data_valid_pre;	//定义读使能信号下的输出data_valid_pre

	//使用独热码表示一下五种状态
	parameter IDLE = 5'b00_001;
	parameter CH1 = 5'b00_010;
	parameter CH2 = 5'b00_100;
	parameter CH3 = 5'b01_000;
	parameter CH4 = 5'b10_000;

	reg [4:0] state;

	//定义寄存各个缓存通道的发包个数
	reg [63:0] cnt_ch [3:0];
	reg [63:0] ch_cnt; 	//用于锁存每次读请求下的数据个数

	integer i,j,k,l,m;

	/*状态转移的代码实现*/
	always@(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state) 
				IDLE : begin
					if(ch_rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(ch_rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(ch_rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(ch_rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else begin
						state <= IDLE;
					end
				end

				CH1 : begin
					if(ch_rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(ch_rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(ch_rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(ch_cnt == 64'd126) begin 	//由于控制输出rdreq，其状态转移又依赖于输出后q的读数，掐头去尾后需要减2
						state <= IDLE;
					end else if(ch_rdusedw[0] != 8'd0) begin
						state <= CH1;
					end else begin
						state <= IDLE;
					end
				end

				CH2 : begin
					if(ch_rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(ch_rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(ch_rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(ch_cnt == 64'd126) begin
						state <= IDLE;
					end else if(ch_rdusedw[1] != 8'd0) begin
						state <= CH2;
					end else begin
						state <= IDLE;
					end
				end

				CH3 : begin
					if(ch_rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(ch_rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(ch_rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(ch_cnt == 64'd126) begin
						state <= IDLE;
					end else if(ch_rdusedw[2] != 8'd0) begin
						state <= CH3;
					end else begin
						state <= IDLE;
					end
				end

				CH4 : begin
					if(ch_rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(ch_rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(ch_rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(ch_cnt == 64'd126) begin
						state <= IDLE;
					end else if(ch_rdusedw[3] != 8'd0) begin
						state <= CH4;
					end else begin
						state <= IDLE;
					end
				end

			endcase
		end
	end

	/*对应状态下rdreq的输出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 4; i = i + 1) begin
				ch_rdreq[i] <= 1'd0;
			end
		end else begin
			case(state) 
				IDLE : begin
					for(j = 0; j < 4; j = j + 1) begin
						ch_rdreq[j] <= 1'd0;
					end
				end

				CH1 : begin
					ch_rdreq[0] <= 1'd1;
				end

				CH2 : begin
					ch_rdreq[1] <= 1'd1;
				end 
				CH3 : begin
					ch_rdreq[2] <= 1'd1;
				end 
				CH4 : begin
					ch_rdreq[3] <= 1'd1;
				end 

				default : begin
					for(k = 0; k < 4; k = k + 1) begin
						ch_rdreq[k] <= 1'd0;
					end
				end
			endcase
		end
	end

	/*当ch_rdreq拉高是的cnt_ch代码实现*/
	always@(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			for(l = 0; l < 4; l = l + 1) begin
				cnt_ch[l] <= 64'd0;
			end
			ch_cnt <= 64'd0;
		end else begin
			if(ch_rdreq[0]) begin
				cnt_ch[0] <= cnt_ch[0] + 64'd1;
				ch_cnt <= ch_cnt + 64'd1;
			end else if(ch_rdreq[1]) begin
				cnt_ch[1] <= cnt_ch[1] + 64'd1;
				ch_cnt <= ch_cnt + 64'd1;
			end else if(ch_rdreq[2]) begin
				cnt_ch[2] <= cnt_ch[2] + 64'd1;
				ch_cnt <= ch_cnt + 64'd1;
			end else if(ch_rdreq[3]) begin
				cnt_ch[3] <= cnt_ch[3] + 64'd1;
				ch_cnt <= ch_cnt + 64'd1;
			end else begin
				for(m = 0; m < 4; m = m + 1) begin
					cnt_ch[m] <= cnt_ch[m];
				end
				ch_cnt <= 64'd0;
			end
		end
	end

	/*对应状态下data_valid的输出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid_pre <= 1'd0;
		end else if(ch_rdreq[0] == 1'd1 || ch_rdreq[1] == 1'd1 || ch_rdreq[2] == 1'd1 || ch_rdreq[3] == 1'd1) begin
			data_valid_pre <= 1'd1;
		end else begin
			data_valid_pre <= 1'd0;
		end
	end

	assign data_valid = data_valid_pre || (state != IDLE) ? 1'd1 : 1'd0 ;

	/*对应状态下up_data的输出*/
	always @(posedge fifo_rdclk or negedge rst_n) begin
		if(~rst_n) begin
			up_data <= 64'd0;
		end else begin
			if(ch_rdreq[0] == 1'd1) begin
				up_data <= ch_q[0];
			end else if(ch_rdreq[1] == 1'd1) begin
				up_data <= ch_q[1];
			end else if(ch_rdreq[2] == 1'd1) begin
				up_data <= ch_q[2];
			end else if(ch_rdreq[3] == 1'd1) begin
				up_data <= ch_q[3];
			end else if(state == IDLE) begin
				if(ch_rdusedw[0] == 8'd128) begin
					up_data <= {32'hadf90c00,32'h1};
				end else if(ch_rdusedw[1] == 8'd128) begin
					up_data <= {32'hadf90c00,32'h2};
				end else if(ch_rdusedw[2] == 8'd128) begin
					up_data <= {32'hadf90c00,32'h3};
				end else if(ch_rdusedw[3] == 8'd128) begin
					up_data <= {32'hadf90c00,32'h4};
				end else begin
					up_data <= 64'd0;
				end
			end else if(state != IDLE) begin
				case(state) 
					CH1 : up_data <= cnt_ch[0] / 128;
					CH2 : up_data <= cnt_ch[1] / 128;
					CH1 : up_data <= cnt_ch[2] / 128;
					CH2 : up_data <= cnt_ch[3] / 128;
					default : up_data <= 64'd0;
				endcase
			end else begin
				up_data <= 64'd0;
			end		
		end
	end

endmodule