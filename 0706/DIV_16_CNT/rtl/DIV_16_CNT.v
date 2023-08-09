module DIV_16_CNT (
	input clk,
	input rst_n,
	output wire div_16
);

	//方法一
	reg div_16_1;
	reg [2:0] temp1;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp1 <= 3'd0;
			div_16_1 <= 1'd0;
		end else if (temp1 == 3'd7) begin
			div_16_1 <= ~div_16_1;
			temp1 <= 3'd0;
		end else begin
			temp1 <= temp1 + 3'd1;
		end
	end

	//方法二
	reg [3:0] temp2;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			temp2 <= 4'd0;
		end else begin
			temp2 <= temp2 + 4'd1;
		end
	end

	//方法2.1
	wire div_16_2;
	assign div_16_2 = (temp2 >= 4'd8 && temp2 <= 15) ? 1'd1 : 1'd0;
	//assign div_16_2 = (temp2 <= 4'd7) ? 1'd0 : 1'd1;

	//方法2.2
	reg div_16_3;
	always@(*) begin
		div_16_3 = (temp2 >= 4'd8 && temp2 <= 15) ? 1'd1 : 1'd0;
	end

	//方法2.3
	reg div_16_4;
	always@(*) begin
		if(temp2 <= 4'd7) begin
			div_16_4 <= 1'd0;
		end else begin
			div_16_4 <= 1'd1;
		end
	end

	//方法2.4
	reg div_16_5;
	always@(*) begin
		if(temp2 >= 4'd8 && temp2 <= 4'd15) begin
			div_16_5 <= 1'd1;
		end else begin
			div_16_5 <= 1'd0;
		end
	end

	//方法2.5
	reg div_16_6;
	always@(*) begin
		case(temp2 <= 4'd7)
			1'd1: div_16_6 <= 1'd0;
			default: div_16_6 <= 1'd1;
		endcase
	end

	//方法三
	//方法3.1
	/* 
	注意：时序逻辑等值判断注意可能出现无法跳出判断
	*/
	reg [3:0] temp3;
	reg div_16_7;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			div_16_7 <= 1'd0;
			temp3 <= 4'd0;
		end else if(temp3 == 4'd7 || temp3 == 4'd15) begin
			div_16_7 <= ~div_16_7;
			temp3 <= temp3 + 4'd1;
		end else begin
			temp3 <= temp3 + 4'd1;
		end
	end

	//方法3.2
	reg div_16_8;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			div_16_8 <= 1'd0;
			temp3 <= 4'd0;
		end else if(temp3 >= 4'd7 && temp3 <= 4'd14) begin
			div_16_8 <= 1'd1;
		end else begin
			temp3 <= temp3 + 4'd1;
			div_16_8 <= 1'd0;
		end
	end

	//方法3.3
	reg div_16_9;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			div_16_9 <= 1'd0;
		end else begin
			div_16_9 = (temp2 >= 4'd7 && temp2 <= 14) ? 1'd1 : 1'd0;
		end
	end

	//方法3.4
	reg div_16_10;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			div_16_10 <= 1'd0;
		end else begin
			case(temp2)
				4'd7,4'd8,4'd9,4'd10,4'd11,4'd12,4'd13,4'd14: div_16_10 <= 1'd1;
				default: div_16_10 <= 1'd0;
			endcase
		end
	end

endmodule