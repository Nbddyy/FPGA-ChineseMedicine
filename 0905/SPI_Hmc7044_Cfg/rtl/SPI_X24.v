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

	assign spi_clk = (state == S1 && (cnt >= 8'd1 && cnt <= 8'd24)) ? clk_n : 1'd0;

	always @(*) begin
		if(!rst_n) begin
			spi_mosi = 1'd0;
		end else begin
			spi_mosi = (state == S1 && (cnt >= 8'd1 && cnt <= 8'd24)) ? spi_wrdata[cnt_max - cnt] : 1'd0;
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