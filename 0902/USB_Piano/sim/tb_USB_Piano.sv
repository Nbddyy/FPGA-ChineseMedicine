
`timescale 1ns/1ps
module tb_USB_Piano (); /* this is automatically generated */

	// clock
	reg clk;
	initial begin
		clk = 1'd0;
		forever #(10) clk = ~clk;
	end

	// asynchronous reset
	reg rst_n;
	initial begin
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
	end

	// (*NOTE*) replace reset, clock, others
	reg  rx;
	wire  beep;

	integer i;

	task generate_aa();
		for(i = 0; i < 10; i = i + 1) begin
			#8680
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd1;
				3 : rx = 1'd0;
				4 : rx = 1'd1;
				5 : rx = 1'd0;
				6 : rx = 1'd1;
				7 : rx = 1'd0;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_bb();
		for(i = 0; i < 10; i = i + 1) begin
			#8680
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd1;
				3 : rx = 1'd0;
				4 : rx = 1'd1;
				5 : rx = 1'd1;
				6 : rx = 1'd1;
				7 : rx = 1'd0;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_cc();
		for(i = 0; i < 10; i = i + 1) begin
			#8680
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd0;
				2 : rx = 1'd0;
				3 : rx = 1'd1;
				4 : rx = 1'd1;
				5 : rx = 1'd0;
				6 : rx = 1'd0;
				7 : rx = 1'd1;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	task generate_dd();
		for(i = 0; i < 10; i = i + 1) begin
			#8680
			case(i)
				0 : rx = 1'd0;	//起始位
				1 : rx = 1'd1;
				2 : rx = 1'd0;
				3 : rx = 1'd1;
				4 : rx = 1'd1;
				5 : rx = 1'd1;
				6 : rx = 1'd0;
				7 : rx = 1'd1;
				8 : rx = 1'd1;
				9 : rx = 1'd1;	//停止位
				default : rx = 1'd1;
			endcase
		end
	endtask

	initial begin
		rx = 1'd1;
		#200
		generate_aa();
		#8680
		generate_bb();
		#8680
		generate_cc();
		#8680
		generate_dd();
	end

	USB_Piano inst_USB_Piano (.clk(clk), .rst_n(rst_n), .rx(rx), .beep(beep));

	
endmodule
