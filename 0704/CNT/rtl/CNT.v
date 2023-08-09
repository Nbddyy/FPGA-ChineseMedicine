module CNT(
	input wire clk,
	input wire rst_n,
	output reg [7:0] counter
);

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			counter <= 8'd0;
		end else if (counter == 8'd59) begin
			counter <= 8'd0;
		end else begin
			counter <= counter + 8'd1;
		end

	end
	
	/* 特定时刻拉高电平：比如counter为23所在的周期 */
	//方法一
	reg test1;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			test1 <= 1'b0;
		end else if (counter == 8'd22) begin
			test1 <= 1'b1;
		end else begin
			test1 <= 1'b0;
		end
	end

	//方法二
	reg test2;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			test2 <= 1'b0;
		end else begin
			case(counter)
				8'd22: test2 <= 1'b1;
				default: test2 <= 1'b0;
			endcase
		end
	end

	//方法三
	wire test3;
	assign test3 = (counter == 8'd23) ? 1'b1 : 1'b0;
	
	/*在特定时刻拉高电平比如：24-30*/
	//方法一：上升沿
	reg test4;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			test4 <= 1'b0;
		end else begin
			if (counter >= 8'd23 && counter < 8'd30) begin
				test4 <= 1'b1;
			end else begin
				test4 <= 1'b0;
			end
		end
	end

	//方法二：下降沿
	reg test5;
	always @(negedge clk or negedge rst_n) begin
		if(~rst_n) begin
			test5 <= 0;
		end else begin
			if (counter >= 8'd23 && counter < 8'd30) begin
				test5 <= 1'b1;
			end else begin
				test5 <= 1'b0;
			end
		end
	end

endmodule