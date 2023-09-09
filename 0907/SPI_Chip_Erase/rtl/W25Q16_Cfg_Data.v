module W25Q16_Cfg_Data(
	input wire [7:0] index,
	output [7:0] spi_wrdata
);

	wire [7:0] cfg_data [0:1];
	assign cfg_data[ 0]   = {8'b0000_0110};
	assign cfg_data[ 1]   = {8'b1100_0111};

	/*assign cfg_data[ 0]   = {1'b0,2'b0,13'h0,		8'h1	};							
	assign cfg_data[ 1]   = {1'b0,2'b0,13'h0,		8'h0	};
	assign cfg_data[ 2]   = {1'b0,2'b0,13'hc8,		8'h0	};
	assign cfg_data[ 3]   = {1'b0,2'b0,13'hd2,		8'h0	};
	assign cfg_data[ 4]   = {1'b0,2'b0,13'hdc,		8'h0	};
	assign cfg_data[ 5]   = {1'b0,2'b0,13'he6,		8'h0	};  
	assign cfg_data[ 6]   = {1'b0,2'b0,13'hf0,		8'h0	};
	assign cfg_data[ 7]   = {1'b0,2'b0,13'hfa,		8'h0	};
	assign cfg_data[ 8]   = {1'b0,2'b0,13'h104,	8'h0	};
	assign cfg_data[ 9]   = {1'b0,2'b0,13'h10e,	8'h0	};
	assign cfg_data[10]   = {1'b0,2'b0,13'h118,	8'h0	};
	assign cfg_data[11]   = {1'b0,2'b0,13'h122,	8'h0	};
	assign cfg_data[12]   = {1'b0,2'b0,13'h12c,	8'h0	};
	assign cfg_data[13]   = {1'b0,2'b0,13'h136,	8'h0	}; 
	assign cfg_data[14]   = {1'b0,2'b0,13'h140,	8'h0	};
	assign cfg_data[15]   = {1'b0,2'b0,13'h14a,	8'h0	};  
	assign cfg_data[16]   = {1'b0,2'b0,13'ha5,		8'h6	};
	assign cfg_data[17]   = {1'b0,2'b0,13'ha8,		8'h6	};
	assign cfg_data[18]   = {1'b0,2'b0,13'hb0,		8'h4	};
	assign cfg_data[19]   = {1'b0,2'b0,13'h5,		8'h48	};//4f   
	assign cfg_data[20]   = {1'b0,2'b0,13'h3,		8'h24	};
	assign cfg_data[21]   = {1'b0,2'b0,13'ha,		8'h0	};
	assign cfg_data[22]   = {1'b0,2'b0,13'hb,		8'h0	};
	assign cfg_data[23]   = {1'b0,2'b0,13'hc,		8'h0	};
	assign cfg_data[24]   = {1'b0,2'b0,13'hd,		8'h17	};
	assign cfg_data[25]   = {1'b0,2'b0,13'h1f,		8'h01	};
	assign cfg_data[26]   = {1'b0,2'b0,13'h14,		8'hff	};
	assign cfg_data[27]   = {1'b0,2'b0,13'h20,		8'h0a	};
	assign cfg_data[28]   = {1'b0,2'b0,13'h21,		8'h7d	}; 
	assign cfg_data[29]   = {1'b0,2'b0,13'h22,		8'h00	}; 
	assign cfg_data[30]   = {1'b0,2'b0,13'h26,		8'h00	};
	assign cfg_data[31]   = {1'b0,2'b0,13'h27,		8'h06	}; 
	assign cfg_data[32]   = {1'b0,2'b0,13'h28,		8'h20	}; 
	assign cfg_data[33]   = {1'b0,2'b0,13'h29,		8'h1c	};
	assign cfg_data[34]   = {1'b0,2'b0,13'h33,		8'h01	};
	assign cfg_data[35]   = {1'b0,2'b0,13'h34,		8'h00	};
	assign cfg_data[36]   = {1'b0,2'b0,13'h35,		8'h0a	};
	assign cfg_data[37]   = {1'b0,2'b0,13'h36,		8'h00	};
	assign cfg_data[38]   = {1'b0,2'b0,13'h37,		8'h04	};
	assign cfg_data[39]   = {1'b0,2'b0,13'h32,		8'h0	};
	assign cfg_data[40]   = {1'b0,2'b0,13'h5a,		8'h0	};
	assign cfg_data[41]   = {1'b0,2'b0,13'h46,		8'h11	};
	assign cfg_data[42]   = {1'b0,2'b0,13'h47,		8'h0	};
	assign cfg_data[43]   = {1'b0,2'b0,13'h48,		8'h0	};
	assign cfg_data[44]   = {1'b0,2'b0,13'h49,		8'h0	};
	assign cfg_data[45]   = {1'b0,2'b0,13'h50,		8'h7f	};  
	assign cfg_data[46]   = {1'b0,2'b0,13'h51,		8'h7f	};
	assign cfg_data[47]   = {1'b0,2'b0,13'h52,		8'h7f	};
	assign cfg_data[48]   = {1'b0,2'b0,13'h53,		8'h7f	};
	assign cfg_data[49]   = {1'b0,2'b0,13'h3,		8'h37	};
	assign cfg_data[50]   = {1'b0,2'b0,13'hc9,		8'h14	};///0
	assign cfg_data[51]   = {1'b0,2'b0,13'hca,		8'h0	};
	assign cfg_data[52]   = {1'b0,2'b0,13'hd0,		8'h11	};
	assign cfg_data[53]   = {1'b0,2'b0,13'hcb,		8'h0	};
	assign cfg_data[54]   = {1'b0,2'b0,13'hcc,		8'h0	};
	assign cfg_data[55]   = {1'b0,2'b0,13'hcf,		8'h0	};
	assign cfg_data[56]   = {1'b0,2'b0,13'hc8,		8'hc1	};
	assign cfg_data[57]   = {1'b0,2'b0,13'hd3,		8'h80	};
	assign cfg_data[58]   = {1'b0,2'b0,13'hd4,		8'h2	};
	assign cfg_data[59]   = {1'b0,2'b0,13'hda,		8'h31	};
	assign cfg_data[60]   = {1'b0,2'b0,13'hd5,		8'h0	};
	assign cfg_data[61]   = {1'b0,2'b0,13'hd6,		8'h0	};
	assign cfg_data[62]   = {1'b0,2'b0,13'hd9,		8'h0	};
	assign cfg_data[63]   = {1'b0,2'b0,13'hd2,		8'hcd	};////////////////////////淇敼20220110 鍘熸潵鏄痗d
	assign cfg_data[64]   = {1'b0,2'b0,13'hdd,		8'h40	};/////2
	assign cfg_data[65]   = {1'b0,2'b0,13'hde,		8'h0	};
	assign cfg_data[66]   = {1'b0,2'b0,13'he4,		8'h11	}; ////鍘熸潵鏄�13
	assign cfg_data[67]   = {1'b0,2'b0,13'hdf,		8'h0	};
	assign cfg_data[68]   = {1'b0,2'b0,13'he0,		8'h0	};
	assign cfg_data[69]   = {1'b0,2'b0,13'he3,		8'h0	};
	assign cfg_data[70]   = {1'b0,2'b0,13'hdc,		8'hc1	};
	assign cfg_data[71]   = {1'b0,2'b0,13'he7,		8'h14	};//out3
	assign cfg_data[72]   = {1'b0,2'b0,13'he8,		8'h0	};
	assign cfg_data[73]   = {1'b0,2'b0,13'hee,		8'h11	};
	assign cfg_data[74]   = {1'b0,2'b0,13'he9,		8'h0	};
	assign cfg_data[75]   = {1'b0,2'b0,13'hea,		8'h0	};
	assign cfg_data[76]   = {1'b0,2'b0,13'hed,		8'h0	};
	assign cfg_data[77]   = {1'b0,2'b0,13'he6,		8'hcd	};//////鍘熸潵鏄痗d
	assign cfg_data[78]   = {1'b0,2'b0,13'hf1,		8'h14	};/////////////
	assign cfg_data[79]   = {1'b0,2'b0,13'hf2,		8'h0	};
	assign cfg_data[80]   = {1'b0,2'b0,13'hf8,		8'h11	};
	assign cfg_data[81]   = {1'b0,2'b0,13'hf3,		8'h0	};
	assign cfg_data[82]   = {1'b0,2'b0,13'hf4,		8'h0	};
	assign cfg_data[83]   = {1'b0,2'b0,13'hf7,		8'h0	};
	assign cfg_data[84]   = {1'b0,2'b0,13'hf0,		8'hc1	};
	assign cfg_data[85]   = {1'b0,2'b0,13'hfb,		8'h80	};
	assign cfg_data[86]   = {1'b0,2'b0,13'hfc,		8'h2	};
	assign cfg_data[87]   = {1'b0,2'b0,13'h102,	8'h31	};
	assign cfg_data[88]   = {1'b0,2'b0,13'hfd,		8'h0	};
	assign cfg_data[89]   = {1'b0,2'b0,13'hfe,		8'h0	};
	assign cfg_data[90]   = {1'b0,2'b0,13'h101,	8'h0	};
	assign cfg_data[91]   = {1'b0,2'b0,13'hfa,		8'hcd	};
	assign cfg_data[92]   = {1'b0,2'b0,13'h105,	8'h14	};/////
	assign cfg_data[93]   = {1'b0,2'b0,13'h106,	8'h0	};
	assign cfg_data[94]   = {1'b0,2'b0,13'h10c,	 8'h11	};
	assign cfg_data[95]   = {1'b0,2'b0,13'h107,	8'h0	};
	assign cfg_data[96]   = {1'b0,2'b0,13'h108,	8'h0	};
	assign cfg_data[97]   = {1'b0,2'b0,13'h10b,	8'h0	};
	assign cfg_data[98]   = {1'b0,2'b0,13'h104,	8'hc1	};
	assign cfg_data[99]   = {1'b0,2'b0,13'h10f,	8'h80	};//out7
	assign cfg_data[100]  = {1'b0,2'b0,13'h110,	8'h2	};
	assign cfg_data[101]  = {1'b0,2'b0,13'h116,	8'h31	};
	assign cfg_data[102]  = {1'b0,2'b0,13'h111,	8'h0	};
	assign cfg_data[103]  = {1'b0,2'b0,13'h112,	8'h0	};
	assign cfg_data[104]  = {1'b0,2'b0,13'h115,	8'h0	};
	assign cfg_data[105]  = {1'b0,2'b0,13'h10e,	8'hc1	};
	assign cfg_data[106]  = {1'b0,2'b0,13'h119,	8'h14	};///
	assign cfg_data[107]  = {1'b0,2'b0,13'h11a,	8'h0	};
	assign cfg_data[108]  = {1'b0,2'b0,13'h120,	8'h11	};
	assign cfg_data[109]  = {1'b0,2'b0,13'h11b,	8'h0	};
	assign cfg_data[110]  = {1'b0,2'b0,13'h11c,	8'h0	};
	assign cfg_data[111]  = {1'b0,2'b0,13'h11f,	8'h0	};
	assign cfg_data[112]  = {1'b0,2'b0,13'h118,	8'hc1	};
	assign cfg_data[113]  = {1'b0,2'b0,13'h123,	8'h14	};
	assign cfg_data[114]  = {1'b0,2'b0,13'h124,	8'h0	};
	assign cfg_data[115]  = {1'b0,2'b0,13'h12a,	8'h11	};
	assign cfg_data[116]  = {1'b0,2'b0,13'h125,	8'h0	};
	assign cfg_data[117]  = {1'b0,2'b0,13'h126,	8'h0	};
	assign cfg_data[118]  = {1'b0,2'b0,13'h129,	8'h0	};
	assign cfg_data[119]  = {1'b0,2'b0,13'h122,	8'hc1	};
	assign cfg_data[120]  = {1'b0,2'b0,13'h12d,	8'h14	};//18//10
	assign cfg_data[121]  = {1'b0,2'b0,13'h12e,	8'h0	};
	assign cfg_data[122]  = {1'b0,2'b0,13'h134,	8'h11	};
	assign cfg_data[123]  = {1'b0,2'b0,13'h12f,	8'h0	};
	assign cfg_data[124]  = {1'b0,2'b0,13'h130,	8'h0	};
	assign cfg_data[125]  = {1'b0,2'b0,13'h133,	8'h0	};
	assign cfg_data[126]  = {1'b0,2'b0,13'h12c,	8'h41	};
	assign cfg_data[127]  = {1'b0,2'b0,13'h137,	8'h80	};
	assign cfg_data[128]  = {1'b0,2'b0,13'h138,	8'h2	};
	assign cfg_data[129]  = {1'b0,2'b0,13'h13e,	8'h31	};
	assign cfg_data[130]  = {1'b0,2'b0,13'h139,	8'h0	};
	assign cfg_data[131]  = {1'b0,2'b0,13'h13a,	8'h0	};
	assign cfg_data[132]  = {1'b0,2'b0,13'h13d,	8'h0	};
	assign cfg_data[133]  = {1'b0,2'b0,13'h136,	8'hcd};  ///鍘熸潵鏄痗d
	assign cfg_data[134]  = {1'b0,2'b0,13'h141,	8'h40	};//12閫氶亾
	assign cfg_data[135]  = {1'b0,2'b0,13'h142,	8'h0	};
	assign cfg_data[136]  = {1'b0,2'b0,13'h148,	8'h11	}; /////鍘熸潵鏄�33
	assign cfg_data[137]  = {1'b0,2'b0,13'h143,	8'h0	};
	assign cfg_data[138]  = {1'b0,2'b0,13'h144,	8'h0	};
	assign cfg_data[139]  = {1'b0,2'b0,13'h147,	8'h0	};
	assign cfg_data[140]  = {1'b0,2'b0,13'h140,	8'hc1	};  /////鍘熸潵鏄痗d   //////////鏀规垚c1
	assign cfg_data[141]  = {1'b0,2'b0,13'h14b,	8'h14	};
	assign cfg_data[142]  = {1'b0,2'b0,13'h14c,	8'h0	};
	assign cfg_data[143]  = {1'b0,2'b0,13'h152,	8'h11	};
	assign cfg_data[144]  = {1'b0,2'b0,13'h14d,	8'h0	};
	assign cfg_data[145]  = {1'b0,2'b0,13'h14e,	8'h0	};
	assign cfg_data[146]  = {1'b0,2'b0,13'h151,	8'h0	};
	assign cfg_data[147]  = {1'b0,2'b0,13'h14a,	8'hc1	};
	assign cfg_data[148]  = {1'b0,2'b0,13'h5b,		8'h4	};
	assign cfg_data[149]  = {1'b0,2'b0,13'h5c,		8'h80	};
	assign cfg_data[150]  = {1'b0,2'b0,13'h5d,		8'h2	};
	assign cfg_data[151]  = {1'b0,2'b0,13'h1,		8'h2	};
	assign cfg_data[152]  = {1'b0,2'b0,13'h1,		8'h60	};*/

	assign spi_wrdata = cfg_data[index];

endmodule 










