module RAM_Storage_Tube (
	input clk,
	input rst_n,
	input key1,
	input key2,
	output shcp,
	output stcp,
	output ds,
	output oe
);

	wire wren;
	wire rden;
	wire [7:0] addr;
	wire [5:0] sel;
	wire [7:0] datas;
	wire [5:0] sel_out;
	wire [7:0] sec;

	Key_Filter Key_Filter_Write 
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(key1),
		.flag(wren)
	);

	Key_Filter Key_Filter_Read
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(key2),
		.flag(rden)
	);

	Data_Gen Data_Gen_1 (
		.clk(clk),
		.rst_n(rst_n),
		.wren(wren),
		.rden(rden),
		.addr(addr),
		.sel(sel),
		.datas(datas)
	);

	Data_Flow_Pre Data_Flow_Pre_1 (
		.clk(clk),
		.rst_n(rst_n),
		.addr(addr),
		.sel(sel),
		.data(datas),
		.sel_out(sel_out),
		.sec(sec)
	);

	Hc595_Pre Hc595_Pre_1 (
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel_out),
		.sec(sec),
		.shcp(shcp),
		.stcp(stcp),
		.ds(ds),
		.oe(oe)
);

endmodule