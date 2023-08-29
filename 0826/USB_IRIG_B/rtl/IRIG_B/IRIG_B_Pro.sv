module IRIG_B_Pro (
	input clk,
	input rst_n,
	input [7:0] ex_sig_B_code,
	output reg [7:0] output_array [24:0],
	output reg output_flag
);

	wire [3:0] second_units;
	wire [2:0] second_tens;
	wire [3:0] minute_units;
	wire [2:0] minute_tens;
	wire [3:0] hour_units;
	wire [1:0] hour_tens;
	wire [3:0] day_units;
	wire [3:0] day_tens;
	wire [1:0] day_hunds;
	wire [3:0] year_units;
	wire [3:0] year_tens;

	wire time_flag;

	wire ex_bcode_signal;

	integer i;

	Draw_Symbol 
	#(
		.bcode_0_flag(24'd99_999),
		.bcode_1_flag(24'd249_999),
		.bcode_2_flag(24'd399_999),
		.num_10ms(24'd499_999)
	)
	inst_Draw_Symbol
	(
		.clk(clk),
		.rst_n(rst_n),
		.ex_sig_B_code(ex_sig_B_code),
		.ex_bcode_signal(ex_bcode_signal)
	);

	IRIG_Parse 
	#(
		.bcode_0_flag(24'd99_999),
		.bcode_1_flag(24'd249_999),
		.bcode_p_flag(24'd399_999)
	)
	inst_IRIG_Parse
	(
		.clk(clk),
		.rst_n(rst_n),
		.ex_bcode_signal(ex_bcode_signal),
		.second_units(second_units),
		.second_tens(second_tens),
		.minute_units(minute_units),
		.minute_tens(minute_tens),
		.hour_units(hour_units),
		.hour_tens(hour_tens),
		.day_units(day_units),
		.day_tens(day_tens),
		.day_hunds(day_hunds),
		.year_units(year_units),
		.year_tens(year_tens),
		.time_flag(time_flag)
	);

	/*使用数组将关键time寄存到数组中*/
	always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				for(i = 0; i < 25; i = i + 1) begin
					output_array[i] <= 8'd0;
				end
			end else if(time_flag) begin
				output_array[0] <= 8'd0;
				output_array[1] <= 8'd0;
				output_array[2] <= 8'd0;
				output_array[3] <= 8'd0;
				output_array[4] <= 8'd0;
				output_array[5] <= 8'd2;
				output_array[6] <= 8'd0;
				output_array[7] <= year_tens;
				output_array[8] <= year_units;
				output_array[9] <= 8'd0;
				output_array[10] <= day_hunds;
				output_array[11] <= day_tens;
				output_array[12] <= day_units;
				output_array[13] <= 8'd0;
				output_array[14] <= 8'd0;
				output_array[15] <= 8'd0;
				output_array[16] <= 8'd0;
				output_array[17] <= hour_tens;
				output_array[18] <= hour_units;
				output_array[19] <= 8'd0;
				output_array[20] <= minute_tens;
				output_array[21] <= minute_units;
				output_array[22] <= 8'd0;
				output_array[23] <= second_tens;
				output_array[24] <= second_units;
			end else begin
				for(i = 0; i < 25; i = i + 1) begin
					output_array[i] <= output_array[i];
				end
			end
		end	

		/*output_flag用于告知下一个模块time数据已经准备完毕*/
		always @(posedge clk or negedge rst_n) begin
			if(~rst_n) begin
				output_flag <= 1'd0;
			end else if(time_flag) begin
				output_flag <= 1'd1;
			end else begin
				output_flag <= 1'd0;
			end
		end

endmodule