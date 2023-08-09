module PIANO 
(
	input clk,
	input rst_n,
	input [3:0] keys,
	
	output out
);

	wire [7:0] piano_in;

	KF  
	// #(
	// 	.max(10),
	// 	.inter_max(30)
	// )
	KF_1
	(
		.clk(clk),
		.rst_n(rst_n),
		.keys(keys),
		.kf_out(piano_in)
	);

	BUZZER 
	// #(
	// 	.max_500ms(20)
	// )
	BUZZER_1
	(
		.clk(clk),
		.rst_n(rst_n),
		.pianos(piano_in),
		.beep_out(out)
	);

endmodule