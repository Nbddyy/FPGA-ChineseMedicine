`timescale 1ns/1ps

module CNT_tb ();

reg clk;
reg rst_n;
wire counter;

initial begin
	clk = 0;
	rst_n = 0;
	#10
	rst_n = 1;
end

always #10 clk = ~clk;

CNT CNT_1 (
	.clk(clk),
	.rst_n(rst_n),
	.counter(counter)
);

endmodule