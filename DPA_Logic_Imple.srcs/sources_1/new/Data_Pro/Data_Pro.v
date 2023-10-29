module Data_Pro (
	input rst_n,  // Asynchronous reset active low
	input refclk,

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
	
	output [15:0] dout16,
	output [2:0] detect_com
);

	wire din0;
	wire din2;
	wire din4;
	wire din6;
	wire din8;
	wire din10;
	wire din12;
	wire din14;

	wire adc_clk;

	IBUF_Pro inst_IBUF_Pro
		(
			.clk_p   (clk_p),
			.clk_n   (clk_n),
			.din0_p  (din0_p),
			.din0_n  (din0_n),
			.din2_p  (din2_p),
			.din2_n  (din2_n),
			.din4_p  (din4_p),
			.din4_n  (din4_n),
			.din6_p  (din6_p),
			.din6_n  (din6_n),
			.din8_p  (din8_p),
			.din8_n  (din8_n),
			.din10_p (din10_p),
			.din10_n (din10_n),
			.din12_p (din12_p),
			.din12_n (din12_n),
			.din14_p (din14_p),
			.din14_n (din14_n),
			.adc_clk (adc_clk),
			.din0    (din0),
			.din2    (din2),
			.din4    (din4),
			.din6    (din6),
			.din8    (din8),
			.din10   (din10),
			.din12   (din12),
			.din14   (din14)
		);

	wire din0_Q1;
	wire din0_Q2;
	wire din2_Q1;
	wire din2_Q2;
	wire din4_Q1;
	wire din4_Q2;
	wire din6_Q1;
	wire din6_Q2;
	wire din8_Q1;
	wire din8_Q2;
	wire din10_Q1;
	wire din10_Q2;
	wire din12_Q1;
	wire din12_Q2;
	wire din14_Q1;
	wire din14_Q2;

	wire clk_out;
	wire [4:0] CNTVALUEOUT;

	IDDR_Pro inst_IDDR_Pro
		(
			.rst_n    (rst_n),
			.adc_clk  (clk_out),
			.din0     (din0),
			.din2     (din2),
			.din4     (din4),
			.din6     (din6),
			.din8     (din8),
			.din10    (din10),
			.din12    (din12),
			.din14    (din14),
			.din0_Q1  (din0_Q1),
			.din0_Q2  (din0_Q2),
			.din2_Q1  (din2_Q1),
			.din2_Q2  (din2_Q2),
			.din4_Q1  (din4_Q1),
			.din4_Q2  (din4_Q2),
			.din6_Q1  (din6_Q1),
			.din6_Q2  (din6_Q2),
			.din8_Q1  (din8_Q1),
			.din8_Q2  (din8_Q2),
			.din10_Q1 (din10_Q1),
			.din10_Q2 (din10_Q2),
			.din12_Q1 (din12_Q1),
			.din12_Q2 (din12_Q2),
			.din14_Q1 (din14_Q1),
			.din14_Q2 (din14_Q2)
		);

		wire detect_over;

	IDELAY_Pro inst_IDELAY_Pro (
			.clk        (adc_clk),
			.refclk     (refclk),
			.rst_n      (rst_n),
			.detect_com (detect_com),
			.clk_out    (clk_out),
			.CNTVALUEOUT(CNTVALUEOUT),
			.detect_over(detect_over)
		);

		Bit_Splice_Detect_Pro inst_Bit_Splice_Detect_Pro
		(
			.clk        (adc_clk),
			.rst_n      (rst_n),
			.CNTVALUEOUT(CNTVALUEOUT),
			.detect_over(detect_over),
			.D0         (din0_Q1),
			.D1         (din0_Q2),
			.D2         (din2_Q1),
			.D3         (din2_Q2),
			.D4         (din4_Q1),
			.D5         (din4_Q2),
			.D6         (din6_Q1),
			.D7         (din6_Q2),
			.D8         (din8_Q1),
			.D9         (din8_Q2),
			.D10        (din10_Q1),
			.D11        (din10_Q2),
			.D12        (din12_Q1),
			.D13        (din12_Q2),
			.D14        (din14_Q1),
			.D15        (din14_Q2),
			.detect_com (detect_com),
			.D16        (dout16)
		);


endmodule