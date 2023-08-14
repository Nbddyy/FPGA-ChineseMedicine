module Poll_Detect (
	input rdclk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [12:0] rdusedw [3:0],
	input [63:0] q [3:0],
	output reg rdreq [3:0],
	output reg data_valid,
	output reg [63:0] up_data
);

	reg data_valid_pre;

	//使用独热码表示五种状态
	parameter IDLE = 5'b00_001;
	parameter CH1 = 5'b00_010;
	parameter CH2 = 5'b00_100;
	parameter CH3 = 5'b01_000;
	parameter CH4 = 5'b10_000;

	reg [4:0] state;
	reg [4:0] state_latch; 	//锁存state状态便于打拍输出

	integer i,j,k;

	//用于表示每个数据帧包含128个数据
	reg [7:0] cnt_data [3:0];

	/*状态转移的代码实现*/
	always@(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
			state_latch <= IDLE;
		end else begin
			case(state) 
				IDLE : begin
					if(rdusedw[0] == 8'd128) begin
						state <= CH1;
						state_latch <= CH1;
					end else if(rdusedw[1] == 8'd128) begin
						state <= CH2;
						state_latch <= CH2;
					end else if(rdusedw[2] == 8'd128) begin
						state <= CH3;
						state_latch <= CH3;
					end else if(rdusedw[3] == 8'd128) begin
						state <= CH4;
						state_latch <= CH4;
					end else begin
						state <= IDLE;
						state_latch <= state_latch;
					end
				end

				CH1 : begin
					if(rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(cnt_data[0] != 8'd127) begin
						state <= CH1;
					end else begin
						state <= IDLE;
					end
				end

				CH2 : begin
					if(rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(cnt_data[1] != 8'd127) begin
						state <= CH2;
					end else begin
						state <= IDLE;
					end
				end

				CH3 : begin
					if(rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(rdusedw[3] == 8'd128) begin
						state <= CH4;
					end else if(cnt_data[2] != 8'd127) begin
						state <= CH3;
					end else begin
						state <= IDLE;
					end
				end

				CH4 : begin
					if(rdusedw[0] == 8'd128) begin
						state <= CH1;
					end else if(rdusedw[1] == 8'd128) begin
						state <= CH2;
					end else if(rdusedw[2] == 8'd128) begin
						state <= CH3;
					end else if(cnt_data[3] != 8'd127) begin
						state <= CH4;
					end else begin
						state <= IDLE;
					end
				end

			endcase
		end
	end

	/*中间变量data_valid_pre的代码实现*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid_pre <= 1'd0;
		end else if(state != IDLE) begin
			data_valid_pre <= 1'd1;
		end else begin
			data_valid_pre <= 1'd0;
		end
	end

	/*对应状态下data_valid的输出*/
	always@(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid <= 1'd0;
		end else begin
			data_valid <= data_valid_pre;
		end
	end

	/*对应状态下rdreq的输出*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 4; i = i + 1) begin
				rdreq[i] <= 1'd0;
				cnt_data[i] <= 8'd0;
			end
		end else begin
			case(state) 
				IDLE : begin
					for(j = 0; j < 4; j = j + 1) begin
						rdreq[j] <= 1'd0;
						cnt_data[i] <= 8'd0;
					end
				end

				CH1 : begin
					rdreq[0] <= 1'd1;
					cnt_data[0] <= cnt_data[0] + 8'd1;
				end

				CH2 : begin
					rdreq[1] <= 1'd1;
					cnt_data[1] <= cnt_data[1] + 8'd1;
				end 
				CH3 : begin
					rdreq[2] <= 1'd1;
					cnt_data[2] <= cnt_data[2] + 8'd1;
				end 
				CH4 : begin
					rdreq[3] <= 1'd1;
					cnt_data[3] <= cnt_data[3] + 8'd1;
				end 

				default : begin
					for(k = 0; k < 4; k = k + 1) begin
						rdreq[k] <= 1'd0;
						cnt_data[i] <= 8'd0;
					end
				end
			endcase
		end
	end

	/*对应状态下up_data的输出*/
	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			up_data <= 64'd0;
		end else if(data_valid_pre) begin
			case(state_latch)
				CH1 : up_data <= q[0];
				CH2 : up_data <= q[1];
				CH3 : up_data <= q[2];
				CH4 : up_data <= q[3];
				default : up_data <= 64'd0;
			endcase
		end else begin
			up_data <= 64'd0;
		end
	end

endmodule