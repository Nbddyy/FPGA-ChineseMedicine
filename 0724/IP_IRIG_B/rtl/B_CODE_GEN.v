module B_CODE_GEN 
#(
	parameter   cnt_10ms_max = 32'd1_249_999,
    parameter   cnt_8ms_max = 32'd999_999,
    parameter   cnt_5ms_max = 32'd624_999,
    parameter   cnt_2ms_max = 32'd249_999
)
(
	input pll_c0,
	input pll_locked,
	output reg [7:0] moni_b_code_out
);
    
    wire [7:0] mem [99:0];
    
	assign mem[0] = 8'h70; ////P
	assign mem[1] = 8'h70; ////P
	assign mem[2] = 8'h30; ////0
	assign mem[3] = 8'h30; ////0
	assign mem[4] = 8'h30; ////0
	assign mem[5] = 8'h31; ////1
	assign mem[6] = 8'h30; ////0
	assign mem[7] = 8'h30; ////0
	assign mem[8] = 8'h30; ////0
	assign mem[9] = 8'h30; ////0
	
	assign mem[10] = 8'h70; ////P
	assign mem[11] = 8'h30; ////0
	assign mem[12] = 8'h30; ////0
	assign mem[13] = 8'h30; ////0
	assign mem[14] = 8'h31; ////1
	assign mem[15] = 8'h30; ////0
	assign mem[16] = 8'h30; ////0
	assign mem[17] = 8'h30; ////0
	assign mem[18] = 8'h31; ////1
	assign mem[19] = 8'h30; ////0
	
	assign mem[20] = 8'h70; ////P
	assign mem[21] = 8'h31; ////1
	assign mem[22] = 8'h30; ////0
	assign mem[23] = 8'h30; ////0
	assign mem[24] = 8'h30; ////0
	assign mem[25] = 8'h30; ////0
	assign mem[26] = 8'h30; ////0
	assign mem[27] = 8'h30; ////0
	assign mem[28] = 8'h30; ////0
	assign mem[29] = 8'h30; ////0
	
	assign mem[30] = 8'h70; ////P
	assign mem[31] = 8'h31; ////1
	assign mem[32] = 8'h30; ////0
	assign mem[33] = 8'h30; ////0
	assign mem[34] = 8'h30; ////0
	assign mem[35] = 8'h30; ////0
	assign mem[36] = 8'h31; ////1
	assign mem[37] = 8'h30; ////0
	assign mem[38] = 8'h31; ////1
	assign mem[39] = 8'h30; ////0
	
	assign mem[40] = 8'h70; ////P
	assign mem[41] = 8'h30; ////0
	assign mem[42] = 8'h31; ////1
	assign mem[43] = 8'h30; ////0
	assign mem[44] = 8'h30; ////0
	assign mem[45] = 8'h30; ////0
	assign mem[46] = 8'h30; ////0
	assign mem[47] = 8'h30; ////0
	assign mem[48] = 8'h30; ////0
	assign mem[49] = 8'h30; ////0
	
	assign mem[50] = 8'h70; ////P
	assign mem[51] = 8'h31; ////1
	assign mem[52] = 8'h30; ////0
	assign mem[53] = 8'h30; ////0
	assign mem[54] = 8'h30; ////0
	assign mem[55] = 8'h30; ////0
	assign mem[56] = 8'h30; ////0
	assign mem[57] = 8'h31; ////1
	assign mem[58] = 8'h30; ////0
	assign mem[59] = 8'h30; ////0
	
	assign mem[60] = 8'h70; ////P
	assign mem[61] = 8'h30; ////0
	assign mem[62] = 8'h30; ////0
	assign mem[63] = 8'h30; ////0
	assign mem[64] = 8'h30; ////0
	assign mem[65] = 8'h30; ////0
	assign mem[66] = 8'h30; ////0
	assign mem[67] = 8'h30; ////0
	assign mem[68] = 8'h30; ////0
	assign mem[69] = 8'h30; ////0
	
	assign mem[70] = 8'h70; ////P
	assign mem[71] = 8'h30; ////0
	assign mem[72] = 8'h30; ////0
	assign mem[73] = 8'h30; ////0
	assign mem[74] = 8'h30; ////0
	assign mem[75] = 8'h30; ////0
	assign mem[76] = 8'h31; ////1
	assign mem[77] = 8'h30; ////0
	assign mem[78] = 8'h30; ////0
	assign mem[79] = 8'h30; ////0
	
	assign mem[80] = 8'h70; ////P
	assign mem[81] = 8'h30; ////0
	assign mem[82] = 8'h30; ////0
	assign mem[83] = 8'h30; ////0
	assign mem[84] = 8'h31; ////1
	assign mem[85] = 8'h31; ////1
	assign mem[86] = 8'h30; ////0
	assign mem[87] = 8'h31; ////1
	assign mem[88] = 8'h30; ////0
	assign mem[89] = 8'h31; ////1
	
	assign mem[90] = 8'h70; ////P
	assign mem[91] = 8'h30; ////0
	assign mem[92] = 8'h30; ////0
	assign mem[93] = 8'h31; ////1
	assign mem[94] = 8'h31; ////1
	assign mem[95] = 8'h30; ////0
	assign mem[96] = 8'h30; ////0
	assign mem[97] = 8'h30; ////0
	assign mem[98] = 8'h30; ////0
	assign mem[99] = 8'h30; ////0
   
    reg [7:0]   number;

    parameter IDLE = 8'h0;
    parameter BCODE_P = 8'h70;
    parameter BCODE_0 = 8'h30;
    parameter BCODE_1 = 8'h31;

    /*定义计数器用来记录单个码元时间10ms*/
    reg [31:0] cnt_10ms;

    /*定义脉冲*/
    reg ex_bcode_sig;

    /*定义状态转移*/
    reg [7:0] state;
    always @(posedge pll_c0 or negedge pll_locked) begin
    	if(~pll_locked) begin
    		state <= IDLE;
    		number <= 8'd0;
    		cnt_10ms <= 32'd0;
    		ex_bcode_sig <= 1'd0;
    	end else begin
    		
    		case(state)

    			IDLE : begin
    				if(mem[number] == BCODE_P) begin
    					state <= BCODE_P;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(mem[number] == BCODE_0) begin
    					state <= BCODE_0;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(mem[number] == BCODE_1) begin
    					state <= BCODE_1;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else begin
    					state <= IDLE;
    					cnt_10ms <= 32'd0;
    				end
    			end

    			BCODE_P : begin
    				if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_P) begin
    					state <= BCODE_P;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_0) begin
    					state <= BCODE_0;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_1) begin
    					state <= BCODE_1;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else begin
    					state <= BCODE_P;
    					cnt_10ms <= cnt_10ms + 32'd1;
    				end

    				if(cnt_10ms < cnt_8ms_max) begin
    					ex_bcode_sig <= 1'd1;
    				end else begin
    					ex_bcode_sig <= 1'd0;
    				end
    			end

    			BCODE_0 : begin
    				if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_P) begin
    					state <= BCODE_P;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_0) begin
    					state <= BCODE_0;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_1) begin
    					state <= BCODE_1;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else begin
    					state <= BCODE_0;
    					cnt_10ms <= cnt_10ms + 32'd1;
    				end

    				if(cnt_10ms < cnt_2ms_max) begin
    					ex_bcode_sig <= 1'd1;
    				end else begin
    					ex_bcode_sig <= 1'd0;
    				end
    			end

    			BCODE_1 : begin
    				if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_P) begin
    					state <= BCODE_P;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_0) begin
    					state <= BCODE_0;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else if(cnt_10ms == cnt_10ms_max && mem[number] == BCODE_1) begin
    					state <= BCODE_1;
    					cnt_10ms <= 32'd0;
    					number <= number + 8'd1;
    				end else begin
    					state <= BCODE_1;
    					cnt_10ms <= cnt_10ms + 32'd1;
    				end

    				if(cnt_10ms < cnt_5ms_max) begin
    					ex_bcode_sig <= 1'd1;
    				end else begin
    					ex_bcode_sig <= 1'd0;
    				end
    			end

    			default : ex_bcode_sig <= IDLE;

    		endcase

    	end
    end
    
    /*对应状态下moni_b_code_out的各种输出情况*/
    always @(posedge pll_c0 or negedge pll_locked) begin
    	if(~pll_locked) begin
    		moni_b_code_out <= 8'h0;
    	end else begin
    		case(state)
    			BCODE_P : moni_b_code_out <= BCODE_P;
    			BCODE_0 : moni_b_code_out <= BCODE_0;
				BCODE_1 : moni_b_code_out <= BCODE_1;
				default : moni_b_code_out <= 8'h0;
    		endcase
    	end
    end


endmodule