module Static_Six_Digit_Tube (
	input clk,
	input rst_n,
	output ds,
	output shcp,
	output stcp,
	output oe
);

	wire [5:0] sel;	//位选
	wire [7:0] sec;	//段选

	Data_Control Data_Control_1 
	(
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel), 	
		.sec(sec) 	
	);

	Hc595_Pre Hc595_Pre_1 (
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel),
		.sec(sec),
		.shcp(shcp),
		.stcp(stcp),
		.ds(ds),
		.oe(oe)
	);

endmodule