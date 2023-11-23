module IDDR_Pro (
	input rst_n,  // Asynchronous reset active low
	
	input adc_clk,

	input [23:0] cnt_65535,
	input [4:0] CNTVALUEOUT,

	input din0,
	input din2,
	input din4,
	input din6,
	input din8,
	input din10,
	input din12,
	input din14,

	output din0_Q1,
	output din0_Q2,
	output din2_Q1,
	output din2_Q2,
	output din4_Q1,
	output din4_Q2,
	output din6_Q1,
	output din6_Q2,
	output din8_Q1,
	output din8_Q2,
	output din10_Q1,
	output din10_Q2,
	output din12_Q1,
	output din12_Q2,
	output din14_Q1,
	output din14_Q2
);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_0 (
		.Q1(din0_Q1), // 1-bit output for positive edge of clock
		.Q2(din0_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din0),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_2 (
		.Q1(din2_Q1), // 1-bit output for positive edge of clock
		.Q2(din2_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din2),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_4 (
		.Q1(din4_Q1), // 1-bit output for positive edge of clock
		.Q2(din4_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din4),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_6 (
		.Q1(din6_Q1), // 1-bit output for positive edge of clock
		.Q2(din6_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din6),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_8 (
		.Q1(din8_Q1), // 1-bit output for positive edge of clock
		.Q2(din8_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din8),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_10 (
		.Q1(din10_Q1), // 1-bit output for positive edge of clock
		.Q2(din10_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din10),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_12 (
		.Q1(din12_Q1), // 1-bit output for positive edge of clock
		.Q2(din12_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din12),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

	IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
		                                //    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
	) IDDR_inst_14 (
		.Q1(din14_Q1), // 1-bit output for positive edge of clock
		.Q2(din14_Q2), // 1-bit output for negative edge of clock
		.C(adc_clk),   // 1-bit clock input
		.CE(1'd1), // 1-bit clock enable input
		.D(din14),   // 1-bit DDR data input
		.R(!rst_n),   // 1-bit reset
		.S()    // 1-bit set
	);

endmodule



