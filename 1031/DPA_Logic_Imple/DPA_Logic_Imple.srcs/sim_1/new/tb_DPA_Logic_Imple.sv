
`timescale 1ns/1ps
module tb_DPA_Logic_Imple (); /* this is automatically generated */

	// (*NOTE*) replace reset, clock, others
	reg        board_clk_100mhz;
	reg        board_rst_n;
 		
	reg clk_400mhz;	//用于模拟adc输出数据的生成时钟
	reg clk_200mhz;
	reg [23:0] cnt_65535;

	reg        din0_p;
	reg        din2_p;
	reg        din4_p;
	reg        din6_p;
	reg        din8_p;
	reg        din10_p;
	reg        din12_p;
	reg        din14_p;

	// wire din0_n;
	// wire din2_n;
	// wire din4_n;
	// wire din6_n;
	// wire din8_n;
	// wire din10_n;
	// wire din12_n;
	// wire din14_n;

	reg din0_p_temp;
	reg din2_p_temp;
	reg din4_p_temp;
	reg din6_p_temp;
	reg din8_p_temp;
	reg din10_p_temp;
	reg din12_p_temp;
	reg din14_p_temp;


	wire        reset;
	wire        spi_clk;
	wire        cs;
	wire        spi_mosi;

	wire [15:0] dout16;


	reg din0_p_flag;	//用于标识取位
	reg din2_p_flag;	
	reg din4_p_flag;	
	reg din6_p_flag;	
	reg din8_p_flag;	
	reg din10_p_flag;	
	reg din12_p_flag;	
	reg din14_p_flag;	

	DPA_Logic_Imple inst_DPA_Logic_Imple
		(
			.board_clk_100mhz (board_clk_100mhz),
			.board_rst_n      (board_rst_n),
			.clk_p            (clk_200mhz),
			.clk_n            (!clk_200mhz),

			.cnt_65535		  (cnt_65535),

			.din0_p           (din0_p_temp),
			.din2_p           (din2_p_temp),
			.din4_p           (din4_p_temp),
			.din6_p           (din6_p_temp),
			.din8_p           (din8_p_temp),
			.din10_p          (din10_p_temp),
			.din12_p          (din12_p_temp),
			.din14_p          (din14_p_temp),

			.din0_n           (!din0_p_temp),
			.din2_n           (!din2_p_temp),
			.din4_n           (!din4_p_temp),
			.din6_n           (!din6_p_temp),
			.din8_n           (!din8_p_temp),
			.din10_n          (!din10_p_temp),
			.din12_n          (!din12_p_temp),
			.din14_n          (!din14_p_temp),

			.reset            (reset),
			.spi_clk          (spi_clk),
			.cs               (cs),
			.spi_mosi         (spi_mosi),
			.dout16           (dout16)
		);

	/**********************board***************************/
	initial begin
		board_clk_100mhz <= 1'd0;
		board_rst_n <= 1'd0;
		#233
		board_rst_n <= 1'd1;
	end

	always #5 board_clk_100mhz <= !board_clk_100mhz;

	/***********************adc_clk**************************/


	/***********************adc_data**************************/
	/*以500MHz的速率模拟adc输出数据*/
	initial begin
		clk_400mhz <= 1'd0;
		clk_200mhz <= 1'd0;
		din0_p <= 1'd0;
		// din0_n <= 1'd1;
		din2_p <= 1'd0;
		// din2_n <= 1'd1;
		din4_p <= 1'd0;
		// din4_n <= 1'd1;
		din6_p <= 1'd0;
		// din6_n <= 1'd1;
		din8_p <= 1'd0;
		// din8_n <= 1'd1;
		din10_p <= 1'd0;
		// din10_n <= 1'd1;
		din12_p <= 1'd0;
		// din12_n <= 1'd1;
		din14_p <= 1'd0;
		// din14_n <= 1'd1;
	end

	always@(posedge clk_200mhz or negedge board_rst_n) begin
		if(!board_rst_n) begin
			cnt_65535 <= 24'd0;
		end else if(cnt_65535 == 24'd65535) begin
			cnt_65535 <= 24'd0;
		end else begin
			cnt_65535 <= cnt_65535 + 24'd1;
		end
	end

	always@(posedge clk_400mhz or negedge board_rst_n) begin
		if(!board_rst_n) begin
			din0_p_temp <= 1'd0;
			din2_p_temp <= 1'd0;
			din4_p_temp <= 1'd0;
			din6_p_temp <= 1'd0;
			din8_p_temp <= 1'd0;
			din10_p_temp <= 1'd0;
			din12_p_temp <= 1'd0;
			din14_p_temp <= 1'd0;

			din0_p_flag <= 1'd0;
			din2_p_flag <= 1'd0;
			din4_p_flag <= 1'd0;
			din6_p_flag <= 1'd0;
			din8_p_flag <= 1'd0;
			din10_p_flag <= 1'd0;
			din12_p_flag <= 1'd0;
			din14_p_flag <= 1'd0;
		end else begin
			din0_p_temp <= (din0_p_flag) ? cnt_65535[1] : cnt_65535[0];
			din2_p_temp <= (din2_p_flag) ? cnt_65535[3] : cnt_65535[2];
			din4_p_temp <= (din4_p_flag) ? cnt_65535[5] : cnt_65535[4];
			din6_p_temp <= (din6_p_flag) ? cnt_65535[7] : cnt_65535[6];
			din8_p_temp <= (din8_p_flag) ? cnt_65535[9] : cnt_65535[8];
			din10_p_temp <= (din10_p_flag) ? cnt_65535[11] : cnt_65535[10];
			din12_p_temp <= (din12_p_flag) ? cnt_65535[13] : cnt_65535[12];
			din14_p_temp <= (din14_p_flag) ? cnt_65535[15] : cnt_65535[14];

			din0_p_flag <= !din0_p_flag;
			din2_p_flag <= !din2_p_flag;
			din4_p_flag <= !din4_p_flag;
			din6_p_flag <= !din6_p_flag;
			din8_p_flag <= !din8_p_flag;
			din10_p_flag <= !din10_p_flag;
			din12_p_flag <= !din12_p_flag;
			din14_p_flag <= !din14_p_flag;
		end
	end


	// always@(posedge clk_400mhz or negedge board_rst_n) begin
	// 	if(!board_rst_n) begin
	// 		din0_p <= 1'd0;
	// 		din2_p <= 1'd0;
	// 		din4_p <= 1'd0;
	// 		din6_p <= 1'd0;
	// 		din8_p <= 1'd0;
	// 		din10_p <= 1'd0;
	// 		din12_p <= 1'd0;
	// 		din14_p <= 1'd0;
	// 	end else begin
	// 		din0_p <= din0_p_temp;
	// 		din2_p <= din2_p_temp;
	// 		din4_p <= din4_p_temp;
	// 		din6_p <= din6_p_temp;
	// 		din8_p <= din8_p_temp;
	// 		din10_p <= din10_p_temp;
	// 		din12_p <= din12_p_temp;
	// 		din14_p <= din14_p_temp;
	// 	end
	// end

	// assign din0_n = !din0_p;
	// assign din2_n = !din2_p;
	// assign din4_n = !din4_p;
	// assign din6_n = !din6_p;
	// assign din8_n = !din8_p;
	// assign din10_n = !din10_p;
	// assign din12_n = !din12_p;
	// assign din14_n = !din14_p;

	always #1.25 clk_400mhz <= !clk_400mhz;
	always #2.5 clk_200mhz <= !clk_200mhz;

endmodule
