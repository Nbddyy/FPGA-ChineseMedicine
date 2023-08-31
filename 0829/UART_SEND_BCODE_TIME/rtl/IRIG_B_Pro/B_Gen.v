// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : B_Gen.v
// Create : 2023-08-29 14:43:55
// Revise : 2023-08-29 14:43:55
// Editor : sublime text4, tab size (4)
// Descri : clk is 125MHz
// -----------------------------------------------------------------------------
module B_Gen
#(
	parameter   cnt_10ms = 24'd1_249_999,
    parameter   cnt_8ms = 24'd999_999,
    parameter   cnt_5ms = 24'd624_999,
    parameter   cnt_2ms = 24'd249_999
)
(
	input clk,
	input rst_n,
	output reg ex_bcode_signal
);        //生成我们所写的模块对应地输入


    
    wire [7:0] mem [0:99];
    
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
    
    reg [31:0]  cnt;
    
    reg [7:0]   state;
    parameter   IDLE = 8'd0;    //IDLE：空闲，用来分流
    parameter   S0 = 8'd1;      //描述P码
    parameter   S1 = 8'd2;      //描述1码
    parameter   S2 = 8'd3;      //描述0码
    parameter   S3 = 8'd4;      //判断是否重新读取存储器
    
    reg [7:0]   number;

    /*一次产生一轮B码，待UART_Tx模块解析完返回信号标识后再次产生*/
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            begin
                state <= IDLE;
                cnt <= 32'd0;
                number <= 8'd0;
            end
        else
            begin

            	
            		case(state)
	                    IDLE:
	                        begin
	                            if(mem[number] == 8'h70)    //读取到P码
	                                begin
	                                    state <= S0;
	                                end
	                            else    if(mem[number] == 8'h31)    //读取到1码
	                                begin
	                                    state <= S1;                              
	                                end
	                            else    if(mem[number] == 8'h30)    //读取到0码
	                                begin
	                                    state <= S2;                                   
	                                end
	                            else
	                                begin
	                                    state <= IDLE;
	                                end
	                                
	                            cnt <= 32'd0;

	                        end
	                    S0: //描述P码
	                        begin
	                            if(cnt == cnt_10ms)
	                                begin
	                                    state <= S3;
	                                    cnt <= 32'd0;
	                                end
	                            else
	                                begin
	                                    cnt <= cnt + 32'd1;
	                                end
	                            
	                            if(cnt >= cnt_8ms)
	                                ex_bcode_signal <= 1'b0;
	                            else
	                                ex_bcode_signal <= 1'b1;
	                            
	                        end
	                    S1: //描述1码
	                        begin
	                            if(cnt == cnt_10ms)
	                                begin
	                                    state <= S3;
	                                    cnt <= 32'd0;
	                                end
	                            else
	                                begin
	                                    cnt <= cnt + 32'd1;
	                                end
	                            
	                            if(cnt >= cnt_5ms)
	                                ex_bcode_signal <= 1'b0;
	                            else
	                                ex_bcode_signal <= 1'b1;
	                        end
	                    S2: //描述0码
	                        begin
	                            if(cnt == cnt_10ms)
	                                begin
	                                    state <= S3;
	                                    cnt <= 32'd0;
	                                end
	                            else
	                                begin
	                                    cnt <= cnt + 32'd1;
	                                end
	                            
	                            if(cnt >= cnt_2ms)
	                                ex_bcode_signal <= 1'b0;
	                            else
	                                ex_bcode_signal <= 1'b1;
	                        end
	                    S3: //判断是否重新读取存储器
	                        begin
	                            if(number == 8'd99)
	                                begin
	                                    number <= 8'd0;
	                                    state <= IDLE;                                 
	                                end
	                            else
	                                begin
	                                    number <= number + 8'd1;
	                                    state <= IDLE;
	                                end
	                        end
	                    default:    state <= IDLE;
                	endcase

                
            end
    end
    
    
	
endmodule