
	`timescale 1ns/1ps

	module tb_USB_GPS();

	
	reg clk;
	reg rst_n;
	

	initial begin 
		clk = 1'b0;
		rst_n = 1'b0;
		#400
		rst_n = 1'b1;
	
	end 

	always #10 clk = ~clk;
	
	
	

	/////from read datas to my mem
	wire [7:0] a_mem[199:0];
	reg data_in;
	
	assign a_mem[0] = "$";
	assign a_mem[1] = "G";
	assign a_mem[2] = "N";
	assign a_mem[3] = "R";
	assign a_mem[4] = "M";
	assign a_mem[5] = "C";
	assign a_mem[6] = ",";
	assign a_mem[7] = "1";
	assign a_mem[8] = "1";
	assign a_mem[9] = "3";

	assign a_mem[10] = "2";
	assign a_mem[11] = "3";
	assign a_mem[12] = "2";
	assign a_mem[13] = ".";
	assign a_mem[14] = "0";
	assign a_mem[15] = "0";
	assign a_mem[16] = ",";
	assign a_mem[17] = "A";
	assign a_mem[18] = ",";
	assign a_mem[19] = "3";

	assign a_mem[20] = "4";
	assign a_mem[21] = "4";
	assign a_mem[22] = "9";
	assign a_mem[23] = ".";
	assign a_mem[24] = "2";
	assign a_mem[25] = "9";
	assign a_mem[26] = "1";
	assign a_mem[27] = "8";
	assign a_mem[28] = "4";
	assign a_mem[29] = ",";

	assign a_mem[30] = "N";
	assign a_mem[31] = ",";
	assign a_mem[32] = "1";
	assign a_mem[33] = "1";
	assign a_mem[34] = "3";
	assign a_mem[35] = "3";
	assign a_mem[36] = "3";
	assign a_mem[37] = ".";
	assign a_mem[38] = "6";
	assign a_mem[39] = "2";

	assign a_mem[40] = "6";
	assign a_mem[41] = "0";
	assign a_mem[42] = "6";
	assign a_mem[43] = ",";
	assign a_mem[44] = "E";
	assign a_mem[45] = ",";
	assign a_mem[46] = "0";
	assign a_mem[47] = ".";
	assign a_mem[48] = "0";
	assign a_mem[49] = "3";

	assign a_mem[50] = "3";
	assign a_mem[51] = ",";
	assign a_mem[52] = ",";
	assign a_mem[53] = "1";
	assign a_mem[54] = "4";
	assign a_mem[55] = "0";
	assign a_mem[56] = "4";
	assign a_mem[57] = "2";
	assign a_mem[58] = "1";
	assign a_mem[59] = ",";

	assign a_mem[60] = ",";
	assign a_mem[61] = ",";
	assign a_mem[62] = "A";
	assign a_mem[63] = ",";
	assign a_mem[64] = "V";
	assign a_mem[65] = "*";
	assign a_mem[66] = "1";
	assign a_mem[67] = "D";///////结束
	assign a_mem[68] = "$";
	assign a_mem[69] = "$";

	assign a_mem[70] = "$";
	assign a_mem[71] = "$";
	assign a_mem[72] = "$";
	assign a_mem[73] = "$";
	assign a_mem[74] = "$";
	assign a_mem[75] = "$";
	assign a_mem[76] = "$";
	assign a_mem[77] = "$";
	assign a_mem[78] = "$";
	assign a_mem[79] = "$";

	assign a_mem[80] = "$";
	assign a_mem[81] = "$";
	assign a_mem[82] = "$";
	assign a_mem[83] = "$";
	assign a_mem[84] = "$";
	assign a_mem[85] = "$";
	assign a_mem[86] = "$";
	assign a_mem[87] = "$";
	assign a_mem[88] = "$";
	assign a_mem[89] = "$";

	assign a_mem[90] = "$";
	assign a_mem[91] = "$";
	assign a_mem[92] = "$";
	assign a_mem[93] = "$";
	assign a_mem[94] = "$";
	assign a_mem[95] = "$";
	assign a_mem[96] = "$";
	assign a_mem[97] = "$";
	assign a_mem[98] = "$";
	assign a_mem[99] = "$";

	assign a_mem[100] = "$";
	assign a_mem[101] = "G";
	assign a_mem[102] = "N";
	assign a_mem[103] = "R";
	assign a_mem[104] = "M";
	assign a_mem[105] = "C";
	assign a_mem[106] = ",";
	assign a_mem[107] = "0";
	assign a_mem[108] = "8";
	assign a_mem[109] = "5";

	assign a_mem[110] = "9";
	assign a_mem[111] = "0";
	assign a_mem[112] = "3";
	assign a_mem[113] = ".";
	assign a_mem[114] = "0";
	assign a_mem[115] = "0";
	assign a_mem[116] = "0";
	assign a_mem[117] = ",";
	assign a_mem[118] = "A";
	assign a_mem[119] = ",";

	assign a_mem[120] = "3";
	assign a_mem[121] = "4";
	assign a_mem[122] = "4";
	assign a_mem[123] = "7";
	assign a_mem[124] = ".";
	assign a_mem[125] = "1";
	assign a_mem[126] = "8";
	assign a_mem[127] = "2";
	assign a_mem[128] = "0";
	assign a_mem[129] = "1";

	assign a_mem[130] = ",";
	assign a_mem[131] = "N";
	assign a_mem[132] = ",";
	assign a_mem[133] = "1";
	assign a_mem[134] = "1";
	assign a_mem[135] = "3";
	assign a_mem[136] = "3";
	assign a_mem[137] = "1";
	assign a_mem[138] = ".";
	assign a_mem[139] = "9";

	assign a_mem[140] = "0";
	assign a_mem[141] = "7";
	assign a_mem[142] = "0";
	assign a_mem[143] = "3";
	assign a_mem[144] = ",";
	assign a_mem[145] = "E";
	assign a_mem[146] = ",";
	assign a_mem[147] = "0";
	assign a_mem[148] = ".";
	assign a_mem[149] = "0";

	assign a_mem[150] = "0";
	assign a_mem[151] = ",";

	assign a_mem[153 - 1] = "0";
	assign a_mem[154 - 1] = ".";
	assign a_mem[155 - 1] = "0";
	assign a_mem[156 - 1] = "0";
	assign a_mem[157 - 1] = ",";
	assign a_mem[158 - 1] = "2";
	assign a_mem[159 - 1] = "8";

	assign a_mem[160 - 1] = "0";
	assign a_mem[161 - 1] = "8";
	assign a_mem[162 - 1] = "2";
	assign a_mem[163 - 1] = "3";
	assign a_mem[164 - 1] = ",";
	assign a_mem[165 - 1] = ",";
	assign a_mem[166 - 1] = ",";
	assign a_mem[167 - 1] = "A";///////结束
	assign a_mem[168 - 1] = "*";
	assign a_mem[169 - 1] = "7";

	assign a_mem[170 - 1] = "6";
	assign a_mem[171 - 1] = "$";
	assign a_mem[172 - 1] = "$";
	assign a_mem[173 - 1] = "$";
	assign a_mem[174 - 1] = "$";
	assign a_mem[175 - 1] = "$";
	assign a_mem[176 - 1] = "$";
	assign a_mem[177 - 1] = "$";
	assign a_mem[178 - 1] = "$";
	assign a_mem[179 - 1] = "$";

	assign a_mem[180 - 1] = "$";
	assign a_mem[181 - 1] = "$";
	assign a_mem[182 - 1] = "$";
	assign a_mem[183 - 1] = "$";
	assign a_mem[184 - 1] = "$";
	assign a_mem[185 - 1] = "$";
	assign a_mem[186 - 1] = "$";
	assign a_mem[187 - 1] = "$";
	assign a_mem[188 - 1] = "$";
	assign a_mem[189 - 1] = "$";

	assign a_mem[190 - 1] = "$";
	assign a_mem[191 - 1] = "$";
	assign a_mem[192 - 1] = "$";
	assign a_mem[193 - 1] = "$";
	assign a_mem[194 - 1] = "$";
	assign a_mem[195 - 1] = "$";
	assign a_mem[196 - 1] = "$";
	assign a_mem[197 - 1] = "$";
	assign a_mem[198 - 1] = "$";
	assign a_mem[199 - 1] = "$";



	
	initial begin
		data_in <= 1;
		#1000;
		top_2();
	end 
	
	task	top_1(
		input	[7:0]top
		);
		integer	i;
		for(i=0;i<10;i=i+1)
			begin
				case(i)
					0:	data_in <= 0;
					1:	data_in <= top[0];
					2:	data_in <= top[1];
					3:	data_in <= top[2];
					4:	data_in <= top[3];
					5:	data_in <= top[4];
					6:	data_in <= top[5];	
					7:	data_in <= top[6];
					8:	data_in <= top[7];	
					9:	data_in <= 1;
				default:data_in <= 1;
				endcase
				#(5208*20);  //每次发送1位数据延时时钟周期个数乘以时钟周期      
			end               
		endtask	

		//相当于例化，将j赋值给task top_1里面的8位top
		task	top_2();
		integer	j;
		for(j=0;j<274;j=j+1)
			top_1(a_mem[j]);	
		endtask

			
	wire ds;
	wire oe;
	wire shcp;
	wire stcp;
	

	USB_GPS inst_USB_GPS (
		.clk(clk), 
		.rst_n(rst_n),
		.rx(data_in),
		.ds(ds),
		.oe(oe),
		.shcp(shcp),
		.stcp(stcp)
	);


















	endmodule 



























