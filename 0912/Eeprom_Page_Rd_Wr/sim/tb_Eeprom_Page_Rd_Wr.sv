
`timescale 1ns/1ps
module tb_Eeprom_Page_Rd_Wr (); /* this is automatically generated */

	reg clk;
	reg rst_n;

	// (*NOTE*) replace reset, clock, others
	reg key1;
	reg key2;
	reg key3;
	wire i2c_sda;
	wire i2c_scl;

	initial begin
		clk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	always #10 clk <= !clk;

	initial begin
		key1 = 1'd1;
		key2 = 1'd1;
		key3 = 1'd1;
		#200_000
		key1 = 1'd0;
		#20_001_000
		key1 = 1'd1;
	end


	Eeprom_Page_Rd_Wr inst_Eeprom_Page_Rd_Wr (
		.clk(clk),
		.rst_n(rst_n),
		.key1(key1),
		.key2(key2),
		.key3(key3),
		.i2c_sda(i2c_sda),	//全双工以输入引脚配置
		.i2c_scl(i2c_scl)
	);

endmodule
