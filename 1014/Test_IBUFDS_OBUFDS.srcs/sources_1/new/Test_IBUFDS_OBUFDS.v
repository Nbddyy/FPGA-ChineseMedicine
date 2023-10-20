`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/14 09:49:40
// Design Name: 
// Module Name: Test_IBUFDS_OBUFDS
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 差分时钟源 -> IBUFDS -> PLL -> OBUFDS
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_IBUFDS_OBUFDS(
    input board_clk_100Mhz_P,
    input clk_100Mhz_N,
    input board_rst_n,
    output clk_125Mhz_P,
    output clk_125Mhz_N
    );

    wire clk_in1;
    wire clk_out1;

    /* 将提供的差分时钟源信号转换成单端提供给PLL */
    IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(clk_in1),  // Buffer output
      .I(board_clk_100Mhz_P),  // Diff_p buffer input (connect directly to top-level port)
      .IB(clk_100Mhz_N) // Diff_n buffer input (connect directly to top-level port)
   );

   /*根据提供的参考时钟100MHz，输出125MHz*/
    PLL_125MHz inst_PLL_125MHz
       (
        // Clock out ports
        .clk_out1(clk_out1),     // output clk_out1
        // Status and control signals
        .reset(!reset), // input reset : Active High
        .locked(locked),       // output locked
       // Clock in ports
        .clk_in1(clk_in1)); 

    /*将125MHz单端信号转换成差分输出*/
    OBUFDS #(
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW")           // Specify the output slew rate
   ) OBUFDS_inst (
      .O(clk_125Mhz_P),     // Diff_p output (connect directly to top-level port)
      .OB(clk_125Mhz_N),   // Diff_n output (connect directly to top-level port)
      .I(clk_out1)      // Buffer input
   );


endmodule
