module TEST2 (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	output wire [7:0] Y
);

	//娴ｅ秵瀚鹃幒銉ㄧ箥缁犳顑佺紒鍐х瘎
	// assign Y = {A[7:4],B[1:0],2'b01};
	// assign Y = {2{A[3:0]}};

	//闁槒绶潻鎰暬缁楋妇绮屾稊
	//assign Y = ((A > B) && (C > D)) ? A : B;
	// assign Y = ((A > B) || (C > D)) ? A : B;

	//娴ｅ秷绻嶇粻妤冾儊缂佸啩绡
	// assign Y = A & B;
	assign Y = A ^ B;

endmodule