module IBUF_Pro (
	input clk_p,
	input clk_n,
	
	input din0_p,
	input din0_n,
	input din2_p,
	input din2_n,
	input din4_p,
	input din4_n,
	input din6_p,
	input din6_n,
	input din8_p,
	input din8_n,
	input din10_p,
	input din10_n,
	input din12_p,
	input din12_n,
	input din14_p,
	input din14_n,

	output adc_clk,
	output din0,
	output din2,
	output din4,
	output din6,
	output din8,
	output din10,
	output din12,
	output din14
);


	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_clk (
	   		.O(adc_clk),  // Buffer output
	   		.I(clk_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(clk_n) // Diff_n buffer input (connect directly to top-level port)
	   );


	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din0 (
	   		.O(din0),  // Buffer output
	   		.I(din0_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din0_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din2 (
	   		.O(din2),  // Buffer output
	   		.I(din2_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din2_n) // Diff_n buffer input (connect directly to top-level port)
	   );


	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din4 (
	   		.O(din4),  // Buffer output
	   		.I(din4_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din4_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din6 (
	   		.O(din6),  // Buffer output
	   		.I(din6_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din6_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din8 (
	   		.O(din8),  // Buffer output
	   		.I(din8_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din8_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din10 (
	   		.O(din10),  // Buffer output
	   		.I(din10_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din10_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din12 (
	   		.O(din12),  // Buffer output
	   		.I(din12_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din12_n) // Diff_n buffer input (connect directly to top-level port)
	   );

	IBUFDS #(
    	.DIFF_TERM("FALSE"),       // Differential Termination
    	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
    	.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
	   ) IBUFDS_inst_din14 (
	   		.O(din14),  // Buffer output
	   		.I(din14_p),  // Diff_p buffer input (connect directly to top-level port)
	   		.IB(din14_n) // Diff_n buffer input (connect directly to top-level port)
	   );

endmodule


   