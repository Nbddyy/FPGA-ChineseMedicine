module Data_Gen 
#(
	parameter birth_year = 16'h2000,
	parameter birth_month = 8'h10,
	parameter birth_day = 8'h29,
	parameter baud_cnt_max = 12'd433
)
(
	input clk,
	input rst_n,
	input key_flag,
	output reg rx
);

	/****************************/
	reg [7:0] birth_year_thous;
	reg [7:0] birth_year_hunds;
	reg [7:0] birth_year_tens;
	reg [7:0] birth_year_units;

	reg [7:0] birth_month_tens;
	reg [7:0] birth_month_units;

	reg [7:0] birth_day_tens;
	reg [7:0] birth_day_units;
	/****************************/

	reg work_en;	//产生数据的work使能信号
	reg [11:0] baud_cnt;

	reg [3:0] bit_cnt;
	reg [3:0] birth_cnt;

	/*work使能信号的代码体现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			work_en <= 1'd0;
		end else if(birth_cnt == 4'd8 && bit_cnt == 4'd10 && baud_cnt == baud_cnt_max) begin
			work_en <= 1'd0;
		end else if(key_flag) begin
			work_en <= 1'd1;
		end else begin
			work_en <= work_en;
		end
	end

	/*baud_cnt的代码体现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			baud_cnt <= 12'd0;
		end else if(!work_en || baud_cnt == baud_cnt_max) begin
			baud_cnt <= 12'd0;
		end else begin
			baud_cnt <= baud_cnt + 12'd1;
		end
	end

	/*bit_cnt用于记录处理当前数据帧所处的位置*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			bit_cnt <= 4'd0;
		end else if(key_flag || (bit_cnt == 4'd10 && baud_cnt == baud_cnt_max)) begin
			bit_cnt <= 4'd1;
		end else if(!work_en) begin
			bit_cnt <= 4'd0;
		end else if(baud_cnt == baud_cnt_max) begin
			bit_cnt <= bit_cnt + 4'd1;
		end else begin
			bit_cnt <= bit_cnt;
		end
	end

	/*birth_cnt用于记录当前处理生日字符的位置*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			birth_cnt <= 4'd0;
		end else if(key_flag) begin
			birth_cnt <= 4'd1;
		end else if(!work_en) begin
			birth_cnt <= 4'd0;
		end else if(bit_cnt == 4'd10 && baud_cnt == baud_cnt_max) begin
			birth_cnt <= birth_cnt + 4'd1;
		end else begin
			birth_cnt <= birth_cnt;
		end
	end

	/*temp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			birth_year_thous <= 8'h00;
			birth_year_hunds <= 8'h00;
			birth_year_tens <= 8'h00;
			birth_year_units <= 8'h00;
			birth_month_tens <= 8'h00;
			birth_month_units <= 8'h00;
			birth_day_tens <= 8'h00;
			birth_day_units <= 8'h00;
		end else begin
			birth_year_thous <= {4'b0011,birth_year[15:12]};
			birth_year_hunds <= {4'b0011,birth_year[11:8]};
			birth_year_tens <= {4'b0011,birth_year[7:4]};
			birth_year_units <= {4'b0011,birth_year[3:0]};
			birth_month_tens <= {4'b0011,birth_month[7:4]};
			birth_month_units <= {4'b0011,birth_month[3:0]};
			birth_day_tens <= {4'b0011,birth_day[7:4]};
			birth_day_units <= {4'b0011,birth_day[3:0]};
		end
	end


	/*output rx*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			rx <= 1'd1;
		end else begin
			case(birth_cnt)
				4'd1 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_year_thous[bit_cnt - 4'd2];
				4'd2 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_year_hunds[bit_cnt - 4'd2];
				4'd3 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_year_tens[bit_cnt - 4'd2];
				4'd4 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_year_units[bit_cnt - 4'd2];
				4'd5 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_month_tens[bit_cnt - 4'd2];
				4'd6 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_month_units[bit_cnt - 4'd2];
				4'd7 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_day_tens[bit_cnt - 4'd2];
				4'd8 : rx <= (bit_cnt == 4'd1) ? 1'd0 : (bit_cnt == 4'd10) ? 1'd1 : birth_day_units[bit_cnt - 4'd2];
				default : rx <= 1'd1;
			endcase
		end
	end

endmodule