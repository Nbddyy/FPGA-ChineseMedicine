`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/14 14:22:49
// Design Name: 
// Module Name: tb_Test_DSP_IP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Test_DSP_IP();

    reg board_clk_100mhz;
    reg [17:0] A;
    reg [17:0] B;
    reg [47:0] C;
    reg [17:0] D;
    wire [47:0] P;

    initial begin
        board_clk_100mhz = 1'd0;
        A <= 18'd0;
        B <= 18'd0;
        C <= 48'd0;
        D <= 18'd0;
    end

    always #5 board_clk_100mhz <= !board_clk_100mhz;

    always #10 A <= {$random} % 5;
    always #10 B <= {$random} % 5;
    always #10 C <= {$random} % 5;
    always #10 D <= {$random} % 5;

    xbip_dsp48_macro_0 your_instance_name (
      .CLK(board_clk_100mhz),  // input wire CLK
      .A(A),      // input wire [17 : 0] A
      .B(B),      // input wire [17 : 0] B
      .C(C),      // input wire [47 : 0] C
      .D(D),      // input wire [17 : 0] D
      .P(P)      // output wire [47 : 0] P
    );

endmodule
