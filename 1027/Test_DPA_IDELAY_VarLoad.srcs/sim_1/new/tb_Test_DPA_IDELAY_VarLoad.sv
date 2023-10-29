
`timescale 1ns/1ps
module tb_Test_DPA_IDELAY_VarLoad (); /* this is automatically generated */

	reg board_clk_100mhz;
	reg refclk;
	reg board_rst_n;
	reg [4:0] CNTVALUEIN;
	reg INC;
	reg LD;
	reg CE;

	initial begin
		board_clk_100mhz <= 1'd0;
		board_rst_n <= 1'd0;
		refclk <= 1'd0;
		#13
		board_clk_100mhz <= 1'd1;
	end

	always #5 board_clk_100mhz <= !board_clk_100mhz;
	always #2.5 refclk <= !refclk;

	initial begin
		CNTVALUEIN <= 5'd0;
		LD <= 1'd0;
		CE <= 1'd0;
		INC <= 1'd0;

		#223 	//tap add 1
		CE <= 1'd1;
		INC <= 1'd1;

		#10 	//keep
		CE <= 1'd0;
		INC <= 1'd0;

		#5000 	//tap add 1
		CE <= 1'd1;
		INC <= 1;

		#10 	//keep
		CE <= 1'd0;
		INC <= 1'd0;

		#5000 	//tap convert to 15
		LD <= 1'd1;
		CNTVALUEIN <= 5'd15;

		#10
		LD <= 1'd0;
		CNTVALUEIN <= 5'd0;

		#5000 	//tap reduce 1
		CE <= 1'd1;
		INC <= 1'd0;

		#10
		CE <= 1'd0;
		INC <= 5'd0;

	end


	Test_DPA_IDELAY_VarLoad inst_Test_DPA_IDELAY_VarLoad(
    	.board_clk_100mhz(board_clk_100mhz),
    	.refclk(refclk),
    	.board_rst_n(board_rst_n),
    	.CE(CE),
    	.CNTVALUEIN(CNTVALUEIN),
    	.INC(INC),
    	.LD(LD)
    );

endmodule
