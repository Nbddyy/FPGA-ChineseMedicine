module DCFIFO (

	//FIFO写端
	input wrclk,
	input [7:0] data,		//写位宽8位
	input wrreq,

	output wrempty,
	output wrfull,
	output [7:0] wrusedw,	//写深度为256

	//FIFO读端口
	input rdclk,
	input rdreq,

	output [15:0] q,		//读位宽为16位
	output rdempty,
	output rdfull,
	output [6:0] rdusedw	//读深度为128
	
	
	
);

	DCFIFO_8_25to16_128 inst_DCFIFO_8_25to16_128 (
		.data(data),
		.rdclk(rdclk),
		.rdreq(rdreq),
		.wrclk(wrclk),
		.wrreq(wrreq),
		.q(q),
		.rdempty(rdempty),
		.rdfull(rdfull),
		.rdusedw(rdusedw),
		.wrempty(wrempty),
		.wrfull(wrfull),
		.wrusedw(wrusedw));

endmodule
