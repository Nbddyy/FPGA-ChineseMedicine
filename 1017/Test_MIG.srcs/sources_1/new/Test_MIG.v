`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/17 19:33:40
// Design Name: 
// Module Name: Test_MIG
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


module Test_MIG(
    output [14:0] ddr3_addr,
    output [2:0] ddr3_ba,
    output ddr3_cas_n,
    output ddr3_ck_n,
    output ddr3_ck_p,
    output ddr3_cke,
    output ddr3_ras_n,
    output ddr3_reset_n,
    output ddr3_we_n,
    output ddr3_cs_n,
    output [7:0] ddr3_dm,
    output ddr3_odt,

    inout [63:0] ddr3_dq,
    inout [7:0] ddr3_dqs_n,
    inout [7:0] ddr3_dqs_p,

    input board_clk_100mhz,
    input board_rst_n    
    );

    /*clock wizard*/
    wire locked;
    wire clk_out1_200mhz;

    /*memory interface generator*/
    wire sys_clk_i;
    wire clk_ref_i;
    wire init_calib_complete;
    wire app_rdy;
    wire app_wdf_rdy;

    assign sys_clk_i = clk_out1_200mhz;
    assign clk_ref_i = clk_out1_200mhz;

    clk_wiz_200mhz inst_clk_wiz_200mhz
   (
    // Clock out ports
    .clk_out1(clk_out1_200mhz),     // output clk_out1
    // Status and control signals
    .reset(!board_rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(board_clk_100mhz));

    mig_7series_0 inst_mig_7series_0 (

    // Memory interface ports


    .ddr3_addr                      (ddr3_addr),  // output [14:0]      ddr3_addr


    .ddr3_ba                        (ddr3_ba),  // output [2:0]     ddr3_ba


    .ddr3_cas_n                     (ddr3_cas_n),  // output            ddr3_cas_n


    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]       ddr3_ck_n


    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]       ddr3_ck_p


    .ddr3_cke                       (ddr3_cke),  // output [0:0]        ddr3_cke


    .ddr3_ras_n                     (ddr3_ras_n),  // output            ddr3_ras_n


    .ddr3_reset_n                   (ddr3_reset_n),  // output          ddr3_reset_n


    .ddr3_we_n                      (ddr3_we_n),  // output         ddr3_we_n


    .ddr3_dq                        (ddr3_dq),  // inout [63:0]     ddr3_dq


    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [7:0]       ddr3_dqs_n


    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [7:0]       ddr3_dqs_p


    .init_calib_complete            (init_calib_complete),  // output           init_calib_complete


      


    .ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]       ddr3_cs_n


    .ddr3_dm                        (ddr3_dm),  // output [7:0]     ddr3_dm


    .ddr3_odt                       (ddr3_odt),  // output [0:0]        ddr3_odt


    // Application interface ports


    .app_addr                       (29'd0),  // input [28:0]        app_addr


    .app_cmd                        (3'd0),  // input [2:0]      app_cmd


    .app_en                         (1'd0),  // input             app_en


    .app_wdf_data                   (512'd0),  // input [511:0]       app_wdf_data


    .app_wdf_end                    (1'd0),  // input                app_wdf_end


    .app_wdf_wren                   (1'd0),  // input               app_wdf_wren


    .app_rd_data                    (),  // output [511:0]       app_rd_data


    .app_rd_data_end                (),  // output           app_rd_data_end


    .app_rd_data_valid              (),  // output         app_rd_data_valid


    .app_rdy                        (app_rdy),  // output           app_rdy


    .app_wdf_rdy                    (app_wdf_rdy),  // output           app_wdf_rdy


    .app_sr_req                     (1'd0),  // input         app_sr_req


    .app_ref_req                    (1'd0),  // input            app_ref_req


    .app_zq_req                     (1'd0),  // input         app_zq_req


    .app_sr_active                  (),  // output         app_sr_active


    .app_ref_ack                    (),  // output           app_ref_ack


    .app_zq_ack                     (),  // output            app_zq_ack


    .ui_clk                         (),  // output            ui_clk


    .ui_clk_sync_rst                (),  // output           ui_clk_sync_rst


    .app_wdf_mask                   (64'd0),  // input [63:0]        app_wdf_mask


    // System Clock Ports


    .sys_clk_i                       (sys_clk_i),


    // Reference Clock Ports


    .clk_ref_i                      (clk_ref_i),


    .sys_rst                        (locked) // input sys_rst


    );

    ILA_DDR3_Init inst_ILA_DDR3_Init (
    .clk(clk_out1_200mhz), // input wire clk


    .probe0(app_rdy), // input wire [0:0]  probe0  
    .probe1(init_calib_complete), // input wire [0:0]  probe1 
    .probe2(app_wdf_rdy) // input wire [0:0]  probe2
    );

endmodule
