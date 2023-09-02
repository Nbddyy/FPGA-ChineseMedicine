module Buffer_Module 
#(
	parameter cnt_baud_max = 16'd4500 	//比码元间隔多几个clk
)
(
	input clk,
	input rst_n, 
	input op_flag,
	input [7:0] op_data,
	output reg ip_flag,
	output reg [7:0] ip_data
);

	reg [3:0] cnt_8;	//用于记录生日的8个字符是否全部生成完

	reg [15:0] cnt_baud;	//当开始传输时的码元间隔
	reg ip_en;
	reg [7:0] cnt_26;	//用于记录已输出的字符

	reg [7:0] birth_year_thous;
	reg [7:0] birth_year_hunds;
	reg [7:0] birth_year_tens;
	reg [7:0] birth_year_units;

	reg [7:0] birth_month_tens;
	reg [7:0] birth_month_units;

	reg [7:0] birth_day_tens;
	reg [7:0] birth_day_units;

	/*temp cnt_8*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_8 <= 4'd0;
		end else if(cnt_8 == 4'd8) begin
			cnt_8 <= 4'd0;
		end else if(op_flag) begin
			cnt_8 <= cnt_8 + 4'd1;
		end else begin
			cnt_8 <= cnt_8;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			birth_year_thous <= 8'd0;
			birth_year_hunds <= 8'd0;
			birth_year_tens <= 8'd0;
			birth_year_units <= 8'd0;
			birth_month_tens <= 8'd0;
			birth_month_units <= 8'd0;
			birth_day_tens <= 8'd0;
			birth_day_units <= 8'd0;
		end else if(cnt_8 == 4'd0 && op_flag) begin
			birth_year_thous <= op_data;
		end else if(cnt_8 == 4'd1 && op_flag) begin
			birth_year_hunds <= op_data;
		end else if(cnt_8 == 4'd2 && op_flag) begin
			birth_year_tens <= op_data;
		end else if(cnt_8 == 4'd3 && op_flag) begin
			birth_year_units <= op_data;
		end else if(cnt_8 == 4'd4 && op_flag) begin
			birth_month_tens <= op_data;
		end else if(cnt_8 == 4'd5 && op_flag) begin
			birth_month_units <= op_data;
		end else if(cnt_8 == 4'd6 && op_flag) begin
			birth_day_tens <= op_data;
		end else if(cnt_8 == 4'd7 && op_flag) begin
			birth_day_units <= op_data;
		end else begin
			birth_year_thous <= birth_year_thous;
			birth_year_hunds <= birth_year_hunds;
			birth_year_tens <= birth_year_tens;
			birth_year_units <= birth_year_units;
			birth_month_tens <= birth_month_tens;
			birth_month_units <= birth_month_units;
			birth_day_tens <= birth_day_tens;
			birth_day_units <= birth_day_units;
		end
	end

	/*temp ip_en*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_en <= 1'd0;
		end else if(cnt_26 == 8'd25 && cnt_baud == 16'd10) begin
			ip_en <= 1'd0;
		end else if(cnt_8 == 4'd8) begin
			ip_en <= 1'd1;
		end else begin
			ip_en <= ip_en;
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_26 <= 8'd0;
		end else if(!ip_en) begin
			cnt_26 <= 8'd0;
		end else if(cnt_baud == cnt_baud_max) begin
			cnt_26 <= cnt_26 + 8'd1;
		end else begin
			cnt_26 <= cnt_26;
		end
	end

	/*temp cnt_baud*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_baud <= 16'd0;
		end else if(!ip_en || cnt_baud == cnt_baud_max) begin
			cnt_baud <= 16'd0;
		end else begin
			cnt_baud <= cnt_baud + 16'd1;
		end
	end

	/*output ip_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_flag <= 1'd0;
		end else if(!ip_en) begin
			ip_flag <= 1'd0;
		end else if(cnt_baud == 16'd5) begin
			ip_flag <= 1'd1;
		end else begin
			ip_flag <= 1'd0;
		end
	end

	/*output ip_data*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ip_data <= 8'd0;
		end else if(!ip_en) begin
			ip_data <= 8'd0;
		end else begin
			case(cnt_26)
				8'd0 : ip_data <= 8'h5A;
				8'd1 : ip_data <= 8'h67;
				8'd2 : ip_data <= 8'h6A;
				8'd3 : ip_data <= 8'h3A;
				8'd4 : ip_data <= birth_year_thous;
				8'd5 : ip_data <= birth_year_hunds;
				8'd6 : ip_data <= birth_year_tens;
				8'd7 : ip_data <= birth_year_units;
				8'd8 : ip_data <= 8'h79;
				8'd9 : ip_data <= 8'h65;
				8'd10 : ip_data <= 8'h61;
				8'd11 : ip_data <= 8'h72;
				8'd12 : ip_data <= 8'h2D;
				8'd13 : ip_data <= birth_month_tens;
				8'd14 : ip_data <= birth_month_units;
				8'd15 : ip_data <= 8'h6D;
				8'd16 : ip_data <= 8'h6F;
				8'd17 : ip_data <= 8'h6E;
				8'd18 : ip_data <= 8'h74;
				8'd19 : ip_data <= 8'h68;
				8'd20 : ip_data <= 8'h2D;
				8'd21 : ip_data <= birth_day_tens;
				8'd22 : ip_data <= birth_day_units;
				8'd23 : ip_data <= 8'h64;
				8'd24 : ip_data <= 8'h61;
				8'd25 : ip_data <= 8'h79;
			endcase
		end
	end

endmodule