
`timescale 1ns/1ps
module tb_UART_LED (); /* this is automatically generated */

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
	reg       rx;
	wire [3:0] led_out;

	task Byte_AA();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_BB();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_CC();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd11;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_DD();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_55();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_66();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_77();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;
		end
	endtask

	task Byte_88();
		begin
			#104166;	//每一个码元传输所占的ns
			rx = 1'd0;
			
			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd0;

			#104166;
			rx = 1'd1;

			#104166;
			rx = 1'd1;
		end
	endtask

	initial begin
		rx = 1'd1;
		#20000
		Byte_BB();
		#104166;
		Byte_AA();
		#104166;
		Byte_BB();
		#104166;
		Byte_CC();
		#104166;
		Byte_DD();
		#104166;
		Byte_55();
		#104166;
		Byte_66();
		#104166;
		Byte_77();
		#104166;
		Byte_88();
	end

	UART_LED inst_UART_LED (.clk(clk), .rst_n(rst_n), .rx(rx), .led_out(led_out));

	
endmodule
