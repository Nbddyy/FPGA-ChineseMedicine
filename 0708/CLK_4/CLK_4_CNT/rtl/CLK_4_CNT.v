module CLK_4_CNT (
	input clk,
	input rst_n,
	output clk_4
);

	//3位宽寄存器
	reg [2:0] temp1;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp1 <= 3'd0;
		end else if(temp1 == 3'd3) begin
			temp1 <= 3'd0;
		end else begin
			temp1 <= temp1 + 1;
		end
	end


	//时序逻辑
	//方法一
	reg clk_4_1;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			clk_4_1 <= 1'd0;
		end else if(temp1 >= 3'd1 && temp1 <= 3'd2)begin
			clk_4_1 <= 1'd1;
		end else begin
			clk_4_1 <= 1'd0;
		end
	end

	//方法二
	reg clk_4_2;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			clk_4_2 <= 1'd0;
		end else if(temp1 % 2 == 3'd1)begin
			clk_4_2 <= ~clk_4_2;
		end else begin
			clk_4_2 <= clk_4_2;
		end
	end

	//方法三
	reg clk_4_3;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			clk_4_3 <= 1'd0;
		end else begin
			case(temp1)
				3'd1,3'd2: clk_4_3 <= 1'd1;
				default: clk_4_3 <= 1'd0;
			endcase
		end
	end

	//方法四
	reg clk_4_4;
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			clk_4_4 <= 1'd0;
		end else begin
			clk_4_4 <= (temp1 >= 3'd1 && temp1 <= 3'd2) ? 1'd1 : 1'd0; 
		end
	end

	//组合逻辑
	//方法五
	wire clk_4_5;
	assign clk_4_5 = (temp1 <= 3'd1) ? 1'd0 : 1'd1;

	//方法六
	reg clk_4_6;
	always@(*) begin
		if(temp1 >= 3'd2 && temp1 <= 3'd3) begin
			clk_4_6 <= 1'd1;	
		end else begin
			clk_4_6 <= 1'd0;
		end
	end

	//方法七
	reg clk_4_7;
	always@(*) begin
		case(temp1 >= 3'd2 && temp1 <= 3'd3) 
			1'd1: clk_4_7 <= 1'd1;
			default: clk_4_7 <= 1'd0;
		endcase
	end

	//更改寄存器的位宽为1,寄存器值到1取反即可
	reg temp2;
	reg clk_4_8;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			temp2 <= 1'd0;
			clk_4_8 <= 1'd0;
		end else if(temp2 == 1'd1) begin
			clk_4_8 <= ~clk_4_8;
			temp2 <= temp2 + 1'd1;	//溢出置0
		end else begin
			temp2 <= temp2 + 1'd1;	
		end
	end

endmodule