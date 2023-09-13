module Eeprom_Page_Rd_Wr (
	input clk,
	input rst_n,
	input key1,
	input key2,
	input key3,
	inout i2c_sda,	//全双工以输入引脚配置
	output i2c_scl
);

	wire write;
	wire read;
	wire ack_4_flag;
	wire [7:0] index;

	wire i2c_clk;
	wire i2c_end;
	wire [7:0] rd_data;
	wire wr_en;
	wire rd_en;
	wire i2c_start;
	wire [15:0] byte_addr;
	wire [7:0] wr_data;
	wire addr_num;


	assign addr_num = 1'd1;

	Key_Filter 
	#(
		.cnt_20ms_max(32'd999_999)
	)
	inst_write_Key_Filter
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(key1),
		.flag(write)
	);

	Key_Filter 
	#(
		.cnt_20ms_max(32'd999_999)
	)
	inst_read_Key_Filter
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(key2),
		.flag(read)
	);

	Key_Filter 
	#(
		.cnt_20ms_max(32'd999_999)
	)
	inst_flag_Key_Filter
	(
		.clk(clk),
		.rst_n(rst_n),
		.key(key3),
		.flag(flag)
	);

	Iic_RW_Data 
	#(
		.indx_max(8'd3)
	)
	inst_Iic_RW_Data
	(
		.clk(clk),
		.rst_n(rst_n),
		.write(write),
		.i2c_clk(i2c_clk),
		.i2c_end(i2c_end),
		.rd_data(rd_data),
		.read(read),
		.ack_4_flag(ack_4_flag),
		.flag(flag),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.i2c_start(i2c_start),
		.byte_addr(byte_addr),
		.wr_data(wr_data),
		.index(index)
	);

	Iic_Ctrl 
	#(
		.cnt_clk_max(8'd24),
		.device_addr_write(8'b1010_0110),
		.device_addr_read(8'b1010_0111),
		.index_max(8'd3)
	)
	inst_Iic_Ctrl
	(
		.clk(clk),
		.rst_n(rst_n),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.i2c_start(i2c_start),
		.addr_num(addr_num),		//0代表1字节，1代表2两字节
		.byte_addr(byte_addr),
		.wr_data(wr_data),
		.index(index),
		.i2c_clk(i2c_clk),
		.i2c_end(i2c_end),
		.rd_data(rd_data),
		.i2c_scl(i2c_scl),
		.i2c_sda(i2c_sda),
		.ack_4_flag(ack_4_flag)	//用来标识页写数据更换
	);

endmodule