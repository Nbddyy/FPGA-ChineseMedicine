
`timescale 1ns/1ps
module tb_Test_IDELAY (); /* this is automatically generated */

	// (*NOTE*) replace reset, clock, others
	reg board_clk_1khz;
	reg board_rst;

	initial begin
		board_clk_1khz <= 1'd0;
		board_rst <= 1'd1;
		datain <= 1'd0;
		#13
		board_rst <= 1'd0;
		#200
		datain = 1'd1;
	end

	always #500_000 board_clk_1khz <= !board_clk_1khz;

	reg datain;
	wire dataout;

	Test_IDELAY inst_Test_IDELAY (.board_clk_1khz(board_clk_1khz), .board_rst(board_rst), .datain(datain), .dataout(dataout));

	
endmodule
