module W25Q16_Cfg_Data (
	input [7:0] index,
	output [23:0] spi_wrdata
);

	wire [23:0] cfg_data [0:152];
	assign cfg_data[0]   = {16'd0,8'h03};	//进行Page Program之前需要先Write Enable

	assign cfg_data[1]   = {8'h00,8'h04,8'h25};	//Write Enable之后需要进行Chip Erase

	// assign cfg_data[2]   = {16'd0,8'h02};	//Page Program instruction

	// assign cfg_data[3]   = {8'h01,8'h01,8'h00};	//给出进行页编辑的地址：Block地址,Sector地址,Page地址

	// //本次此时插入数据字节149个
	// assign cfg_data[4] = {16'd0,8'h04};
	// assign cfg_data[5] = {16'd0,8'h05};  
	// assign cfg_data[6] = {16'd0,8'h06};
	// assign cfg_data[7] = {16'd0,8'h07};
	// assign cfg_data[8] = {16'd0,8'h08};
	// assign cfg_data[9] = {16'd0,8'h09};
	// assign cfg_data[10] = {16'd0,8'h10};
	// assign cfg_data[11] = {16'd0,8'h11};
	// assign cfg_data[12] = {16'd0,8'h12};
	// assign cfg_data[13] = {16'd0,8'h13}; 
	// assign cfg_data[14] = {16'd0,8'h14};
	// assign cfg_data[15] = {16'd0,8'h15};  
	// assign cfg_data[16] = {16'd0,8'h16};
	// assign cfg_data[17] = {16'd0,8'h17};
	// assign cfg_data[18] = {16'd0,8'h18};
	// assign cfg_data[19] = {16'd0,8'h19};//4f   
	// assign cfg_data[20] = {16'd0,8'h20};
	// assign cfg_data[21] = {16'd0,8'h21};
	// assign cfg_data[22] = {16'd0,8'h22};
	// assign cfg_data[23] = {16'd0,8'h23};
	// assign cfg_data[24] = {16'd0,8'h24};
	// assign cfg_data[25] = {16'd0,8'h25};
	// assign cfg_data[26] = {16'd0,8'h26};
	// assign cfg_data[27] = {16'd0,8'h27};
	// assign cfg_data[28] = {16'd0,8'h28}; 
	// assign cfg_data[29] = {16'd0,8'h29}; 
	// assign cfg_data[30] = {16'd0,8'h30};
	// assign cfg_data[31] = {16'd0,8'h31}; 
	// assign cfg_data[32] = {16'd0,8'h32}; 
	// assign cfg_data[33] = {16'd0,8'h33};
	// assign cfg_data[34] = {16'd0,8'h34};
	// assign cfg_data[35] = {16'd0,8'h35};
	// assign cfg_data[36] = {16'd0,8'h36};
	// assign cfg_data[37] = {16'd0,8'h37};
	// assign cfg_data[38] = {16'd0,8'h38};
	// assign cfg_data[39] = {16'd0,8'h39};
	// assign cfg_data[40] = {16'd0,8'h40};
	// assign cfg_data[41] = {16'd0,8'h41};
	// assign cfg_data[42] = {16'd0,8'h42};
	// assign cfg_data[43] = {16'd0,8'h43};
	// assign cfg_data[44] = {16'd0,8'h44};
	// assign cfg_data[45] = {16'd0,8'h45};  
	// assign cfg_data[46] = {16'd0,8'h46};
	// assign cfg_data[47] = {16'd0,8'h47};
	// assign cfg_data[48] = {16'd0,8'h48};
	// assign cfg_data[49] = {16'd0,8'h49};
	// assign cfg_data[50] = {16'd0,8'h50};///0
	// assign cfg_data[51] = {16'd0,8'h51};
	// assign cfg_data[52] = {16'd0,8'h52};
	// assign cfg_data[53] = {16'd0,8'h53};
	// assign cfg_data[54] = {16'd0,8'h54};
	// assign cfg_data[55] = {16'd0,8'h55};
	// assign cfg_data[56] = {16'd0,8'h56};
	// assign cfg_data[57] = {16'd0,8'h57};
	// assign cfg_data[58] = {16'd0,8'h58};
	// assign cfg_data[59] = {16'd0,8'h59};
	// assign cfg_data[60] = {16'd0,8'h60};
	// assign cfg_data[61] = {16'd0,8'h61};
	// assign cfg_data[62] = {16'd0,8'h62};
	// assign cfg_data[63] = {16'd0,8'h63};////////////////////////淇敼20220110 鍘熸潵鏄痗d
	// assign cfg_data[64] = {16'd0,8'h64};/////2
	// assign cfg_data[65] = {16'd0,8'h65};
	// assign cfg_data[66] = {16'd0,8'h66}; ////鍘熸潵鏄�13
	// assign cfg_data[67] = {16'd0,8'h67};
	// assign cfg_data[68] = {16'd0,8'h68};
	// assign cfg_data[69] = {16'd0,8'h69};
	// assign cfg_data[70] = {16'd0,8'h70};
	// assign cfg_data[71] = {16'd0,8'h71};//out3
	// assign cfg_data[72] = {16'd0,8'h72};
	// assign cfg_data[73] = {16'd0,8'h73};
	// assign cfg_data[74] = {16'd0,8'h74};
	// assign cfg_data[75] = {16'd0,8'h75};
	// assign cfg_data[76] = {16'd0,8'h76};
	// assign cfg_data[77] = {16'd0,8'h77};//////鍘熸潵鏄痗d
	// assign cfg_data[78] = {16'd0,8'h78};/////////////
	// assign cfg_data[79] = {16'd0,8'h79};
	// assign cfg_data[80] = {16'd0,8'h80};
	// assign cfg_data[81] = {16'd0,8'h81};
	// assign cfg_data[82] = {16'd0,8'h82};
	// assign cfg_data[83] = {16'd0,8'h83};
	// assign cfg_data[84] = {16'd0,8'h84};
	// assign cfg_data[85] = {16'd0,8'h85};
	// assign cfg_data[86] = {16'd0,8'h86};
	// assign cfg_data[87] = {16'd0,8'h87};
	// assign cfg_data[88] = {16'd0,8'h88};
	// assign cfg_data[89] = {16'd0,8'h89};
	// assign cfg_data[90] = {16'd0,8'h90};
	// assign cfg_data[91] = {16'd0,8'h91};
	// assign cfg_data[92] = {16'd0,8'h92};/////
	// assign cfg_data[93] = {16'd0,8'h93};
	// assign cfg_data[94] = {16'd0,8'h94};
	// assign cfg_data[95] = {16'd0,8'h95};
	// assign cfg_data[96] = {16'd0,8'h96};
	// assign cfg_data[97] = {16'd0,8'h97};
	// assign cfg_data[98] = {16'd0,8'h98};
	// assign cfg_data[99] = {16'd0,8'h99};//out7
	// assign cfg_data[100] = {16'd0,8'h00};
	// assign cfg_data[101] = {16'd0,8'h01};
	// assign cfg_data[102] = {16'd0,8'h02};
	// assign cfg_data[103] = {16'd0,8'h03};
	// assign cfg_data[104] = {16'd0,8'h04};
	// assign cfg_data[105] = {16'd0,8'h05};
	// assign cfg_data[106] = {16'd0,8'h06};///
	// assign cfg_data[107] = {16'd0,8'h07};
	// assign cfg_data[108] = {16'd0,8'h08};
	// assign cfg_data[109] = {16'd0,8'h09};
	// assign cfg_data[110] = {16'd0,8'h10};
	// assign cfg_data[111] = {16'd0,8'h11};
	// assign cfg_data[112] = {16'd0,8'h12};
	// assign cfg_data[113] = {16'd0,8'h13};
	// assign cfg_data[114] = {16'd0,8'h14};
	// assign cfg_data[115] = {16'd0,8'h15};
	// assign cfg_data[116] = {16'd0,8'h16};
	// assign cfg_data[117] = {16'd0,8'h17};
	// assign cfg_data[118] = {16'd0,8'h18};
	// assign cfg_data[119] = {16'd0,8'h19};
	// assign cfg_data[120] = {16'd0,8'h20};//18//10
	// assign cfg_data[121] = {16'd0,8'h21};
	// assign cfg_data[122] = {16'd0,8'h22};
	// assign cfg_data[123] = {16'd0,8'h23};
	// assign cfg_data[124] = {16'd0,8'h24};
	// assign cfg_data[125] = {16'd0,8'h25};
	// assign cfg_data[126] = {16'd0,8'h26};
	// assign cfg_data[127] = {16'd0,8'h27};
	// assign cfg_data[128] = {16'd0,8'h28};
	// assign cfg_data[129] = {16'd0,8'h29};
	// assign cfg_data[130] = {16'd0,8'h30};
	// assign cfg_data[131] = {16'd0,8'h31};
	// assign cfg_data[132] = {16'd0,8'h32};
	// assign cfg_data[133] = {16'd0,8'h33};  ///鍘熸潵鏄痗d
	// assign cfg_data[134] = {16'd0,8'h34};//12閫氶亾
	// assign cfg_data[135] = {16'd0,8'h35};
	// assign cfg_data[136] = {16'd0,8'h36}; /////鍘熸潵鏄�33
	// assign cfg_data[137] = {16'd0,8'h37};
	// assign cfg_data[138] = {16'd0,8'h38};
	// assign cfg_data[139] = {16'd0,8'h39};
	// assign cfg_data[140] = {16'd0,8'h40};  /////鍘熸潵鏄痗d   //////////鏀规垚c1
	// assign cfg_data[141] = {16'd0,8'h41};
	// assign cfg_data[142] = {16'd0,8'h42};
	// assign cfg_data[143] = {16'd0,8'h43};
	// assign cfg_data[144] = {16'd0,8'h44};
	// assign cfg_data[145] = {16'd0,8'h45};
	// assign cfg_data[146] = {16'd0,8'h46};
	// assign cfg_data[147] = {16'd0,8'h47};
	// assign cfg_data[148] = {16'd0,8'h48};
	// assign cfg_data[149] = {16'd0,8'h49};
	// assign cfg_data[150] = {16'd0,8'h50};
	// assign cfg_data[151] = {16'd0,8'h51};
	// assign cfg_data[152] = {16'd0,8'h52};

	assign spi_wrdata = cfg_data[index];

endmodule 










