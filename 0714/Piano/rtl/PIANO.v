module PIANO 
(
	input clk,
	input rst_n,
	input [3:0] keys,
	
	output out
);

	wire [3:0] piano_in;

	KF KF_1 
	(
		.clk(clk),
		.rst_n(rst_n),
		.keys(keys),
		.kf_out(piano_in)
	);

	BUZZER BUZZER_1
	(
		.clk(clk),
		.rst_n(rst_n),
		.pianos(piano_in),
		.beep_out(out)
	);

endmodule