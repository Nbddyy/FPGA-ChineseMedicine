module ddr3 (
	input clk,    // Clock
	input [7:0] f_word,
	input [7:0] p_word,
	output [7:0] data_out
);

	reg [7:0] init_frequency = 8'd0;
	reg [7:0] init_phase;

	reg [7:0] phase_address = 8'd0;
	reg [7:0] phase_now;

	wire [7:0] sample_75mhz_256 [255:0];

	/*同步频率控制字*/
	always @(posedge clk) begin
		init_frequency <= f_word;
	end

	/*同步相位控制字*/
	always @(posedge clk) begin
		init_phase <= p_word;
	end

	/*相位累加的结果*/
	always @(posedge clk) begin
		phase_address <= phase_address + init_frequency;
	end

	/*初始相位*/
	always @(posedge clk) begin
		phase_now <= phase_address + init_phase;
	end

	/*75MHz采样频率，采样深度为256，sin的离散性好采样值*/
	assign sample_75mhz_256[0] = 8'd128;
	assign sample_75mhz_256[1] = 8'd131;
	assign sample_75mhz_256[2] = 8'd134;
	assign sample_75mhz_256[3] = 8'd137;
	assign sample_75mhz_256[4] = 8'd140;
	assign sample_75mhz_256[5] = 8'd144;
	assign sample_75mhz_256[6] = 8'd147;
	assign sample_75mhz_256[7] = 8'd150;
	assign sample_75mhz_256[8] = 8'd153;
	assign sample_75mhz_256[9] = 8'd156;
	assign sample_75mhz_256[10] = 8'd159;
	assign sample_75mhz_256[11] = 8'd162;
	assign sample_75mhz_256[12] = 8'd165;
	assign sample_75mhz_256[13] = 8'd168;
	assign sample_75mhz_256[14] = 8'd171;
	assign sample_75mhz_256[15] = 8'd174;
	assign sample_75mhz_256[16] = 8'd177;
	assign sample_75mhz_256[17] = 8'd180;
	assign sample_75mhz_256[18] = 8'd182;
	assign sample_75mhz_256[19] = 8'd185;
	assign sample_75mhz_256[20] = 8'd188;
	assign sample_75mhz_256[21] = 8'd191;
	assign sample_75mhz_256[22] = 8'd194;
	assign sample_75mhz_256[23] = 8'd196;
	assign sample_75mhz_256[24] = 8'd199;
	assign sample_75mhz_256[25] = 8'd201;
	assign sample_75mhz_256[26] = 8'd204;
	assign sample_75mhz_256[27] = 8'd206;
	assign sample_75mhz_256[28] = 8'd209;
	assign sample_75mhz_256[29] = 8'd211;
	assign sample_75mhz_256[30] = 8'd214;
	assign sample_75mhz_256[31] = 8'd216;
	assign sample_75mhz_256[32] = 8'd218;
	assign sample_75mhz_256[33] = 8'd220;
	assign sample_75mhz_256[34] = 8'd222;
	assign sample_75mhz_256[35] = 8'd224;
	assign sample_75mhz_256[36] = 8'd226;
	assign sample_75mhz_256[37] = 8'd228;
	assign sample_75mhz_256[38] = 8'd230;
	assign sample_75mhz_256[39] = 8'd232;
	assign sample_75mhz_256[40] = 8'd234;
	assign sample_75mhz_256[41] = 8'd236;
	assign sample_75mhz_256[42] = 8'd237;
	assign sample_75mhz_256[43] = 8'd239;
	assign sample_75mhz_256[44] = 8'd240;
	assign sample_75mhz_256[45] = 8'd242;
	assign sample_75mhz_256[46] = 8'd243;
	assign sample_75mhz_256[47] = 8'd244;
	assign sample_75mhz_256[48] = 8'd246;
	assign sample_75mhz_256[49] = 8'd247;
	assign sample_75mhz_256[50] = 8'd248;
	assign sample_75mhz_256[51] = 8'd249;
	assign sample_75mhz_256[52] = 8'd250;
	assign sample_75mhz_256[53] = 8'd251;
	assign sample_75mhz_256[54] = 8'd251;
	assign sample_75mhz_256[55] = 8'd252;
	assign sample_75mhz_256[56] = 8'd253;
	assign sample_75mhz_256[57] = 8'd253;
	assign sample_75mhz_256[58] = 8'd254;
	assign sample_75mhz_256[59] = 8'd254;
	assign sample_75mhz_256[60] = 8'd254;
	assign sample_75mhz_256[61] = 8'd255;
	assign sample_75mhz_256[62] = 8'd255;
	assign sample_75mhz_256[63] = 8'd255;
	assign sample_75mhz_256[64] = 8'd255;
	assign sample_75mhz_256[65] = 8'd255;
	assign sample_75mhz_256[66] = 8'd255;
	assign sample_75mhz_256[67] = 8'd255;
	assign sample_75mhz_256[68] = 8'd254;
	assign sample_75mhz_256[69] = 8'd254;
	assign sample_75mhz_256[70] = 8'd253;
	assign sample_75mhz_256[71] = 8'd253;
	assign sample_75mhz_256[72] = 8'd252;
	assign sample_75mhz_256[73] = 8'd252;
	assign sample_75mhz_256[74] = 8'd251;
	assign sample_75mhz_256[75] = 8'd250;
	assign sample_75mhz_256[76] = 8'd249;
	assign sample_75mhz_256[77] = 8'd248;
	assign sample_75mhz_256[78] = 8'd247;
	assign sample_75mhz_256[79] = 8'd246;
	assign sample_75mhz_256[80] = 8'd245;
	assign sample_75mhz_256[81] = 8'd244;
	assign sample_75mhz_256[82] = 8'd242;
	assign sample_75mhz_256[83] = 8'd241;
	assign sample_75mhz_256[84] = 8'd240;
	assign sample_75mhz_256[85] = 8'd238;
	assign sample_75mhz_256[86] = 8'd236;
	assign sample_75mhz_256[87] = 8'd235;
	assign sample_75mhz_256[88] = 8'd233;
	assign sample_75mhz_256[89] = 8'd231;
	assign sample_75mhz_256[90] = 8'd229;
	assign sample_75mhz_256[91] = 8'd227;
	assign sample_75mhz_256[92] = 8'd225;
	assign sample_75mhz_256[93] = 8'd223;
	assign sample_75mhz_256[94] = 8'd221;
	assign sample_75mhz_256[95] = 8'd219;
	assign sample_75mhz_256[96] = 8'd217;
	assign sample_75mhz_256[97] = 8'd215;
	assign sample_75mhz_256[98] = 8'd212;
	assign sample_75mhz_256[99] = 8'd210;
	assign sample_75mhz_256[100] = 8'd208;
	assign sample_75mhz_256[101] = 8'd205;
	assign sample_75mhz_256[102] = 8'd203;
	assign sample_75mhz_256[103] = 8'd200;
	assign sample_75mhz_256[104] = 8'd197;
	assign sample_75mhz_256[105] = 8'd195;
	assign sample_75mhz_256[106] = 8'd192;
	assign sample_75mhz_256[107] = 8'd189;
	assign sample_75mhz_256[108] = 8'd187;
	assign sample_75mhz_256[109] = 8'd184;
	assign sample_75mhz_256[110] = 8'd181;
	assign sample_75mhz_256[111] = 8'd178;
	assign sample_75mhz_256[112] = 8'd175;
	assign sample_75mhz_256[113] = 8'd172;
	assign sample_75mhz_256[114] = 8'd169;
	assign sample_75mhz_256[115] = 8'd167;
	assign sample_75mhz_256[116] = 8'd164;
	assign sample_75mhz_256[117] = 8'd160;
	assign sample_75mhz_256[118] = 8'd157;
	assign sample_75mhz_256[119] = 8'd154;
	assign sample_75mhz_256[120] = 8'd151;
	assign sample_75mhz_256[121] = 8'd148;
	assign sample_75mhz_256[122] = 8'd145;
	assign sample_75mhz_256[123] = 8'd142;
	assign sample_75mhz_256[124] = 8'd139;
	assign sample_75mhz_256[125] = 8'd136;
	assign sample_75mhz_256[126] = 8'd133;
	assign sample_75mhz_256[127] = 8'd130;
	assign sample_75mhz_256[128] = 8'd126;
	assign sample_75mhz_256[129] = 8'd123;
	assign sample_75mhz_256[130] = 8'd120;
	assign sample_75mhz_256[131] = 8'd117;
	assign sample_75mhz_256[132] = 8'd114;
	assign sample_75mhz_256[133] = 8'd111;
	assign sample_75mhz_256[134] = 8'd108;
	assign sample_75mhz_256[135] = 8'd105;
	assign sample_75mhz_256[136] = 8'd102;
	assign sample_75mhz_256[137] = 8'd99;
	assign sample_75mhz_256[138] = 8'd96;
	assign sample_75mhz_256[139] = 8'd92;
	assign sample_75mhz_256[140] = 8'd89;
	assign sample_75mhz_256[141] = 8'd87;
	assign sample_75mhz_256[142] = 8'd84;
	assign sample_75mhz_256[143] = 8'd81;
	assign sample_75mhz_256[144] = 8'd78;
	assign sample_75mhz_256[145] = 8'd75;
	assign sample_75mhz_256[146] = 8'd72;
	assign sample_75mhz_256[147] = 8'd69;
	assign sample_75mhz_256[148] = 8'd67;
	assign sample_75mhz_256[149] = 8'd64;
	assign sample_75mhz_256[150] = 8'd61;
	assign sample_75mhz_256[151] = 8'd59;
	assign sample_75mhz_256[152] = 8'd56;
	assign sample_75mhz_256[153] = 8'd53;
	assign sample_75mhz_256[154] = 8'd51;
	assign sample_75mhz_256[155] = 8'd48;
	assign sample_75mhz_256[156] = 8'd46;
	assign sample_75mhz_256[157] = 8'd44;
	assign sample_75mhz_256[158] = 8'd41;
	assign sample_75mhz_256[159] = 8'd39;
	assign sample_75mhz_256[160] = 8'd37;
	assign sample_75mhz_256[161] = 8'd35;
	assign sample_75mhz_256[162] = 8'd33;
	assign sample_75mhz_256[163] = 8'd31;
	assign sample_75mhz_256[164] = 8'd29;
	assign sample_75mhz_256[165] = 8'd27;
	assign sample_75mhz_256[166] = 8'd25;
	assign sample_75mhz_256[167] = 8'd23;
	assign sample_75mhz_256[168] = 8'd21;
	assign sample_75mhz_256[169] = 8'd20;
	assign sample_75mhz_256[170] = 8'd18;
	assign sample_75mhz_256[171] = 8'd16;
	assign sample_75mhz_256[172] = 8'd15;
	assign sample_75mhz_256[173] = 8'd14;
	assign sample_75mhz_256[174] = 8'd12;
	assign sample_75mhz_256[175] = 8'd11;
	assign sample_75mhz_256[176] = 8'd10;
	assign sample_75mhz_256[177] = 8'd9;
	assign sample_75mhz_256[178] = 8'd8;
	assign sample_75mhz_256[179] = 8'd7;
	assign sample_75mhz_256[180] = 8'd6;
	assign sample_75mhz_256[181] = 8'd5;
	assign sample_75mhz_256[182] = 8'd4;
	assign sample_75mhz_256[183] = 8'd4;
	assign sample_75mhz_256[184] = 8'd3;
	assign sample_75mhz_256[185] = 8'd3;
	assign sample_75mhz_256[186] = 8'd2;
	assign sample_75mhz_256[187] = 8'd2;
	assign sample_75mhz_256[188] = 8'd1;
	assign sample_75mhz_256[189] = 8'd1;
	assign sample_75mhz_256[190] = 8'd1;
	assign sample_75mhz_256[191] = 8'd1;
	assign sample_75mhz_256[192] = 8'd1;
	assign sample_75mhz_256[193] = 8'd1;
	assign sample_75mhz_256[194] = 8'd1;
	assign sample_75mhz_256[195] = 8'd2;
	assign sample_75mhz_256[196] = 8'd2;
	assign sample_75mhz_256[197] = 8'd2;
	assign sample_75mhz_256[198] = 8'd3;
	assign sample_75mhz_256[199] = 8'd3;
	assign sample_75mhz_256[200] = 8'd4;
	assign sample_75mhz_256[201] = 8'd5;
	assign sample_75mhz_256[202] = 8'd5;
	assign sample_75mhz_256[203] = 8'd6;
	assign sample_75mhz_256[204] = 8'd7;
	assign sample_75mhz_256[205] = 8'd8;
	assign sample_75mhz_256[206] = 8'd9;
	assign sample_75mhz_256[207] = 8'd10;
	assign sample_75mhz_256[208] = 8'd12;
	assign sample_75mhz_256[209] = 8'd13;
	assign sample_75mhz_256[210] = 8'd14;
	assign sample_75mhz_256[211] = 8'd16;
	assign sample_75mhz_256[212] = 8'd17;
	assign sample_75mhz_256[213] = 8'd19;
	assign sample_75mhz_256[214] = 8'd20;
	assign sample_75mhz_256[215] = 8'd22;
	assign sample_75mhz_256[216] = 8'd24;
	assign sample_75mhz_256[217] = 8'd26;
	assign sample_75mhz_256[218] = 8'd28;
	assign sample_75mhz_256[219] = 8'd30;
	assign sample_75mhz_256[220] = 8'd32;
	assign sample_75mhz_256[221] = 8'd34;
	assign sample_75mhz_256[222] = 8'd36;
	assign sample_75mhz_256[223] = 8'd38;
	assign sample_75mhz_256[224] = 8'd40;
	assign sample_75mhz_256[225] = 8'd42;
	assign sample_75mhz_256[226] = 8'd45;
	assign sample_75mhz_256[227] = 8'd47;
	assign sample_75mhz_256[228] = 8'd50;
	assign sample_75mhz_256[229] = 8'd52;
	assign sample_75mhz_256[230] = 8'd55;
	assign sample_75mhz_256[231] = 8'd57;
	assign sample_75mhz_256[232] = 8'd60;
	assign sample_75mhz_256[233] = 8'd62;
	assign sample_75mhz_256[234] = 8'd65;
	assign sample_75mhz_256[235] = 8'd68;
	assign sample_75mhz_256[236] = 8'd71;
	assign sample_75mhz_256[237] = 8'd74;
	assign sample_75mhz_256[238] = 8'd76;
	assign sample_75mhz_256[239] = 8'd79;
	assign sample_75mhz_256[240] = 8'd82;
	assign sample_75mhz_256[241] = 8'd85;
	assign sample_75mhz_256[242] = 8'd88;
	assign sample_75mhz_256[243] = 8'd91;
	assign sample_75mhz_256[244] = 8'd94;
	assign sample_75mhz_256[245] = 8'd97;
	assign sample_75mhz_256[246] = 8'd100;
	assign sample_75mhz_256[247] = 8'd103;
	assign sample_75mhz_256[248] = 8'd106;
	assign sample_75mhz_256[249] = 8'd109;
	assign sample_75mhz_256[250] = 8'd112;
	assign sample_75mhz_256[251] = 8'd116;
	assign sample_75mhz_256[252] = 8'd119;
	assign sample_75mhz_256[253] = 8'd122;
	assign sample_75mhz_256[254] = 8'd125;
	assign sample_75mhz_256[255] = 8'd128;

	assign data_out = sample_75mhz_256[phase_now];

endmodule