
`timescale 1ns/1ps
module tb_UART_FIFO_LOOP (); /* this is automatically generated */

	reg clk;
	reg rst_n;
	reg  rx;
	wire  tx;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	/*用于模拟生成包含1位起始位，8位有效位，一位停止位的数据帧*/
	task generate_rx();	//时序逻辑
		integer i;

		for(i = 0; i < 10; i = i + 1) begin
			case(i) 
				0 : rx <= 0;	//起始位固定为0
				9 : rx <= 1;	//停止位固定为1
				default : rx <= {$random} % 2;
			endcase	

			#104166;	//每一个码元传输所占的ns
		end	

	endtask

	initial begin
		rx = 1'd0;
		#200
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();

        
        #20000000
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();
		#(5208*20)
		generate_rx();
	end

	UART_FIFO_LOOP inst_UART_FIFO_LOOP (.clk(clk), .rst_n(rst_n), .rx(rx), .tx(tx));

	
endmodule
