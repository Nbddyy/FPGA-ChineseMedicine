module DIV_7 (
	input sys_clk,
	input sys_rst_n,
	input [3:0] R,S,
	output clk_7
);

	//上升沿寄存器
	reg [2:0] temp1;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			temp1 <= 3'd0;
		end else if(temp1 == 3'd6) begin
			temp1 <= 3'd0;
		end else begin
			temp1 <= temp1 + 3'd1;
		end
	end

	//下降沿寄存器
	reg [2:0] temp2;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			temp2 <= 3'd0;
		end else if(temp2 == 3'd6) begin
			temp2 <= 3'd0;
		end else begin
			temp2 <= temp2 + 3'd1;
		end
	end

	//方法一
	//或||
	reg rise_temp_1;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_1 <= 1'd0;
		end else if(temp1 >= 3'd3 && temp1 <= 3'd5) begin
			rise_temp_1 <= 1'd1;
		end else begin
			rise_temp_1 <= 1'd0;
		end
	end

	reg fall_temp_1;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			fall_temp_1 <= 1'd0;
		end else if(temp2 >= 3'd3 && temp2 <= 3'd5) begin
			fall_temp_1 <= 1'd1;
		end else begin
			fall_temp_1 <= 1'd0;
		end
	end

	wire clk_7_1;
	assign clk_7_1 = rise_temp_1 || fall_temp_1;


	//方法二
	//与&
	reg rise_temp_2;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_2 <= 1'd0;
		end else if(temp1 >= 3'd2 && temp1 <= 3'd5) begin
			rise_temp_2 <= 1'd1;
		end else begin
			rise_temp_2 <= 1'd0;
		end
	end

	reg fall_temp_2;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			fall_temp_2 <= 1'd0;
		end else if(temp2 >= 3'd2 && temp2 <= 3'd5) begin
			fall_temp_2 <= 1'd1;
		end else begin
			fall_temp_2 <= 1'd0;
		end
	end

	wire clk_7_2;
	assign clk_7_2 = rise_temp_2 && fall_temp_2;

	//方法三
	//方法3.1：^
	reg rise_temp_3;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_3 <= 1'd0;
		end else if(temp1 >= 3'd2 && temp1 <= 3'd5) begin
			rise_temp_3 <= 1'd1;
		end else begin
			rise_temp_3 <= 1'd0;
		end
	end

	reg fall_temp_3;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			fall_temp_3 <= 1'd0;
		end else if(temp2 == 3'd2) begin
			fall_temp_3 <= 1'd1;
		end else begin
			fall_temp_3 <= 1'd0;
		end
	end

	wire edge_temp_3;
	assign edge_temp_3 = rise_temp_3 && fall_temp_3;

	wire clk_7_3;
	assign clk_7_3 = rise_temp_3 ^ edge_temp_3;

	//方法3.2
	reg rise_temp_4;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_4 <= 1'd0;
		end else if(temp1 == 3'd6) begin
			rise_temp_4 <= ~rise_temp_4;
		end else begin
			rise_temp_4 <= rise_temp_4;
		end
	end

	reg fall_temp_4;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			fall_temp_4 <= 1'd0;
		end else if(temp2 == 3'd3) begin
			fall_temp_4 <= ~fall_temp_4;
		end else begin
			fall_temp_4 <= fall_temp_4;
		end
	end

	wire clk_7_4;
	assign clk_7_4 = rise_temp_4 ^ fall_temp_4;

	//方法五
	//方法5.1同或~^
	reg rise_temp_5;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_5 <= 1'd0;
		end else if(temp1 >= 3'd2 && temp1 <= 3'd5) begin
			rise_temp_5 <= 1'd1;
		end else begin
			rise_temp_5 <= 1'd0;
		end
	end

	wire clk_7_5;
	assign clk_7_5 = rise_temp_5 ~^ edge_temp_3;

	//方法5.2
	reg rise_temp_6;
	always@(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			rise_temp_6 <= 1'd0;
		end else if(temp1 == 3'd6) begin
			rise_temp_6 <= ~rise_temp_6;
		end else begin
			rise_temp_6 <= rise_temp_6;
		end
	end

	reg fall_temp_6;
	always@(negedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			fall_temp_6 <= 1'd0;
		end else if(temp2 == 3'd3) begin
			fall_temp_6 <= ~fall_temp_6;
		end else begin
			fall_temp_6 <= fall_temp_6;
		end
	end

	wire clk_7_6;
	assign clk_7_6 = rise_temp_6 ~^ fall_temp_6;

endmodule