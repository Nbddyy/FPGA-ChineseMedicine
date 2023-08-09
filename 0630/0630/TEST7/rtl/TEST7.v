module TEST7 (
	input wire [7:0] A,
	input wire [7:0] B,
	input wire [7:0] C,
	input wire [7:0] D,
	input wire [7:0] E,
	input wire [7:0] F,
	input wire [7:0] G,
	input wire [7:0] H,
	input wire [2:0] SEL,
	output reg [7:0] Y
);

	always@(*) 
		begin
			if(SEL == 3'b000) 
				begin
					Y = A;
				end 
			else if(SEL == 3'b001) 
				begin
					Y = B;
				end 
			else if(SEL == 3'b010) 
				begin
					Y = C;
				end 
			else if(SEL == 3'b011) 
				begin
					Y = D;
				end 
			else if(SEL == 3'b100) 
				begin
					Y = E;
				end 
			else if(SEL == 3'b101) 
				begin
					Y = F;
				end 
			else if(SEL == 3'b110) 
				begin
					Y = G;
				end 
			else if(SEL == 3'b111) 
				begin
					Y = H;
				end 
		end

endmodule