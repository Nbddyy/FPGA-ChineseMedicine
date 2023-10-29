
`timescale 1ns/1ps
module tb_Test_FFT_UART (); /* this is automatically generated */

	// (*NOTE*) replace reset, clock, others
	reg  board_clk_100mhz;
	reg  board_rst_n;
	reg  rx;
	wire  tx;

	integer i;

	initial begin
		board_clk_100mhz <= 1'd0;
		board_rst_n <= 1'd0;
		rx <= 1'd1;
		#203
		board_rst_n = 1'd1;
	end

	always #5 board_clk_100mhz <= !board_clk_100mhz;

	task generate_negative();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd1;
				3 : rx = 1'd1;
				4 : rx = 1'd1;
				5 : rx = 1'd1;
				6 : rx = 1'd1;
				7 : rx = 1'd1;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_negative_1();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd1;
				3 : rx = 1'd1;
				4 : rx = 1'd1;
				5 : rx = 1'd1;
				6 : rx = 1'd1;
				7 : rx = 1'd1;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_0();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd0;
				3 : rx = 1'd0;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_1();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd0;
				3 : rx = 1'd0;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_2();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd1;
				3 : rx = 1'd0;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_3();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd1;
				3 : rx = 1'd0;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_4();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd0;
				3 : rx = 1'd1;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_6();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd1;
				3 : rx = 1'd1;
				4 : rx = 1'd0;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_9();
		for(i = 0; i < 10; i = i + 1) begin
			#104_166
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd0;
				3 : rx = 1'd0;
				4 : rx = 1'd1;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd0;
				8 : rx = 1'd0;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	initial begin
		//x0
		#303
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_0();
		#104_166
		generate_1();
		#104_166

		//x1
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_0();
		#104_166
		generate_0();
		#104_166

		//x2
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_negative();
		#104_166
		generate_negative_1();
		#104_166

		//x3
		generate_0();
		#104_166
		generate_0();
		#104_166
		generate_0();
		#104_166
		generate_1();
		#104_166

		//x4
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_negative();
		#104_166
		generate_negative_1();
		#104_166

		//x5
		generate_0();
		#104_166
		generate_0();
		#104_166
		generate_0();
		#104_166
		generate_1();
		#104_166

		//x6
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_0();
		#104_166
		generate_1();
		#104_166

		//x7
		generate_0();
		#104_166
		generate_1();
		#104_166
		generate_0();
		#104_166
		generate_0();

	end

	Test_FFT_UART inst_Test_FFT_UART
		(
			.board_clk_100mhz (board_clk_100mhz),
			.board_rst_n      (board_rst_n),
			.rx               (rx),
			.tx               (tx)
		);

	
endmodule
