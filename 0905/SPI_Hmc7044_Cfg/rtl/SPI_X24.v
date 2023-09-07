module SPI_X24 
#(
	parameter cnt_max = 8'd24
)
(
	input clk,
	input rst_n,
	input spi_start,
	input [1:0] spi_cmd,
	input [23:0] spi_wrdata,
	input [7:0] spi_width,
	output spi_clk,
	output cs,
	output reg spi_mosi,
	output reg spi_done
);

	wire clk_n;
	reg [5:0] state;
	reg [7:0] cnt;
	wire clk_en;

	//定义输出判断存在的几种状态
	parameter IDLE = 6'b000_001;
	parameter S0 = 6'b000_010;
	parameter S1 = 6'b000_100;
	parameter S2 = 6'b001_000;
	parameter S3 = 6'b010_000;
	parameter S4 = 6'b100_000;

	assign clk_n = !clk;

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else begin
			case(state)
				IDLE : state <= (spi_start) ? S0 : IDLE;
				S0 : state <= S1;
				S1 : state <= (cnt == cnt_max) ? S2 : S1;
				S2 : state <= S3;
				S3 : state <= S4;
				S4 : state <= IDLE;
				default : state <= IDLE;
			endcase
		end
	end

	/*temp cnt*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 8'd0;
		end else begin
			case(state)
				S1 : cnt <= (cnt < cnt_max) ? cnt + 8'd1 : 8'd0;
				default : cnt <= 8'd0;
			endcase
		end
	end

	assign clk_en = (state == S1) ? 1'd1 : 1'd0;

	assign cs = (state == S1 || state == S2) ? 1'd0 : 1'd1;

	assign spi_clk = (state == S1 || state == S2) ? clk_n : 1'd0;

	always @(*) begin
		if(!rst_n) begin
			spi_mosi = 1'd1;
		end else begin
			// case(cnt) 
			// 	8'd1 : spi_mosi = spi_wrdata[cnt_max - 8'd1];	//读命令
			// 	8'd2 : spi_mosi = spi_wrdata[cnt_max - 8'd2];	//读取2位多字节字段
			// 	8'd3 : spi_mosi = spi_wrdata[cnt_max - 8'd3];

			// 	8'd4 : spi_mosi = spi_wrdata[cnt_max - 8'd4];	//读取13位地址字段
			// 	8'd5 : spi_mosi = spi_wrdata[cnt_max - 8'd5];
			// 	8'd6 : spi_mosi = spi_wrdata[cnt_max - 8'd6];
			// 	8'd7 : spi_mosi = spi_wrdata[cnt_max - 8'd7];
			// 	8'd8 : spi_mosi = spi_wrdata[cnt_max - 8'd8];
			// 	8'd9 : spi_mosi = spi_wrdata[cnt_max - 8'd9];
			// 	8'd10 : spi_mosi = spi_wrdata[cnt_max - 8'd10];
			// 	8'd11 : spi_mosi = spi_wrdata[cnt_max - 8'd11];
			// 	8'd12 : spi_mosi = spi_wrdata[cnt_max - 8'd12];
			// 	8'd13 : spi_mosi = spi_wrdata[cnt_max - 8'd13];
			// 	8'd14 : spi_mosi = spi_wrdata[cnt_max - 8'd14];
			// 	8'd15 : spi_mosi = spi_wrdata[cnt_max - 8'd15];
			// 	8'd16 : spi_mosi = spi_wrdata[cnt_max - 8'd16];

			// 	8'd17 : spi_mosi = spi_wrdata[cnt_max - 8'd17];	//读取8位数据字段
			// 	8'd18 : spi_mosi = spi_wrdata[cnt_max - 8'd18];
			// 	8'd19 : spi_mosi = spi_wrdata[cnt_max - 8'd19];
			// 	8'd20 : spi_mosi = spi_wrdata[cnt_max - 8'd20];
			// 	8'd21 : spi_mosi = spi_wrdata[cnt_max - 8'd21];
			// 	8'd22 : spi_mosi = spi_wrdata[cnt_max - 8'd22];
			// 	8'd23 : spi_mosi = spi_wrdata[cnt_max - 8'd23];
			// 	8'd24 : spi_mosi = spi_wrdata[cnt_max - 8'd24];
			// 	default : spi_mosi = 1'd1;
			// endcase

			spi_mosi = (cnt != 8'd0) ? spi_wrdata[cnt_max - cnt] : 1'd1;

		end
	end


	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			spi_done = 1'd1;
		end else begin
			spi_done = (state == S3) ? 1'd1 : 1'd0; 
		end
	end

endmodule
