

`timescale 1ns / 1ps
`define IDDR

module iddr #
(
    parameter   FPGA_FAMILY             =   "Altera"
)
(
    // Clock
    input   wire                        clk                         ,

    // DDR In Interface
    input   wire                        ddr                         ,

    // SDR Out Interface
    output  reg                         sdr_p                       ,
    output  reg                         sdr_n
);


/******************************************************************************/
/****************************** Parameters Define *****************************/
/******************************************************************************/


/******************************************************************************/
/****************************** Internal Signals ******************************/
/******************************************************************************/
wire                                    sdr_p_s, sdr_n_s            ;
reg                                     sdr_p_r                     ;


/******************************************************************************/
/****************************** Main Logic Work *******************************/
/******************************************************************************/

/*
 *  ----------------------------------------------------------------------------
 *  Name        :   Xilnx
 *  Description :
 *  ----------------------------------------------------------------------------
 */
generate
case (FPGA_FAMILY)
"Altera" : begin
    altddio_in                          # (
        //.intended_device_family       ( FPGA_FAMILY               ),
        .invert_output                  ( "OFF"                     ),
        .lpm_hint                       ( "UNUSED"                  ),
        .lpm_type                       ( "altddio_in"              ),
        .oe_reg                         ( "UNREGISTERED"            ),
        .power_up_high                  ( "OFF"                     ),
        .width                          ( 1                         )
    ) IDDR (
        .aclr                           ( 1'b0                      ),// 1-bit reset
        .aset                           ( 1'b0                      ),// 1-bit set
        .sclr                           ( 1'b0                      ),// 1-bit reset
        .sset                           ( 1'b0                      ),// 1-bit set
        .inclocken                      ( 1'b1                      ),// 1-bit clock enable input
        .inclock                        ( clk                       ),// 1-bit clock input
        .datain                         ( ddr                       ),// 1-bit DDR data input
        .dataout_h                      ( sdr_p_s                   ),// 1-bit output for positive edge of clock
        .dataout_l                      ( sdr_n_s                   ) // 1-bit output for negative edge of clock
    );

    always @ (posedge clk)
    begin
        sdr_p_r <= sdr_p_s;
        sdr_p   <= sdr_p_r;
        sdr_n   <= sdr_n_s;
    end
end

"Xilinx_7s" : begin
    IDDR                                # (
        .DDR_CLK_EDGE                   ( "SAME_EDGE_PIPELINED"     ),// "OPPOSITE_EDGE", "SAME_EDGE"  or "SAME_EDGE_PIPELINED"
        .INIT_Q1                        ( 1'b0                      ),// Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2                        ( 1'b0                      ),// Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE                         ( "ASYNC"                   ) // Set/Reset type: "SYNC" or "ASYNC"
    ) IDDR (
        .R                              ( 1'b0                      ),// 1-bit reset
        .S                              ( 1'b0                      ),// 1-bit set
        .CE                             ( 1'b1                      ),// 1-bit clock enable input
        .C                              ( clk                       ),// 1-bit clock input
        .D                              ( ddr                       ),// 1-bit DDR data input
        .Q1                             ( sdr_p_s                   ),// 1-bit output for positive edge of clock
        .Q2                             ( sdr_n_s                   ) // 1-bit output for negative edge of clock
    );

    always @ (posedge clk)
    begin
        sdr_p   <= sdr_p_s;
        sdr_n   <= sdr_n_s;
    end
end

"Xilinx_uc" : begin
    IDDRE1                              # (
       .DDR_CLK_EDGE                    ( "SAME_EDGE_PIPELINED"     ),// IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
       .IS_CB_INVERTED                  ( 1'b0                      ),// Optional inversion for CB
       .IS_C_INVERTED                   ( 1'b0                      ) // Optional inversion for C
    ) IDDR (
       .R                               ( 1'b0                      ),// 1-bit input: Active High Async Reset
       .C                               ( clk                       ),// 1-bit input: High-speed clock
       .CB                              ( ~clk                      ),// 1-bit input: Inversion of High-speed clock C
       .D                               ( ddr                       ),// 1-bit input: Serial Data Input
       .Q1                              ( sdr_p_s                   ),// 1-bit output: Registered parallel output 1
       .Q2                              ( sdr_n_s                   ) // 1-bit output: Registered parallel output 2
    );

    always @ (posedge clk)
    begin
        sdr_p   <= sdr_p_s;
        sdr_n   <= sdr_n_s;
    end
end




"Xilinx_VTR" : begin
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_inst (
      .Q1(sdr_p_s), // 1-bit output for positive edge of clock
      .Q2(sdr_n_s), // 1-bit output for negative edge of clock
      .C(clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(ddr),   // 1-bit DDR data input
      .R(1'b0),   // 1-bit reset
      .S(1'b0)    // 1-bit set
   );

always @ (posedge clk)
    begin
        sdr_p   <= sdr_p_s;
        sdr_n   <= sdr_n_s;
    end
end








default : begin
    always @ (posedge clk)
    begin
        sdr_p   <= 1'b1;
        sdr_n   <= 1'b0;
    end
end
endcase

endgenerate


endmodule





























