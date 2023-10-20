`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/18 21:57:58
// Design Name: 
// Module Name: Test_DDS
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


module Test_DDS(
    input board_clk_100mhz,
    input board_rst_n
    );

    /*clk_wiz_50mhz*/
    wire board_clk_50mhz;
    wire locked;


    /*dds_sin_cos_1*/
    wire [31:0] m_axis_data_tdata_1;
    wire [31:0] m_axis_data_tdata_2;

    reg [15:0] m_axis_data_tdata_1_sin;
    reg [15:0] m_axis_data_tdata_1_cos;
    reg [15:0] m_axis_data_tdata_2_sin;
    reg [15:0] m_axis_data_tdata_2_cos;

    /*mult_gen_0*/
    wire [31:0] mult_5k_5m_hz;

    /*生成5KHz的sin和cos*/
    always @(posedge board_clk_50mhz or negedge board_rst_n) begin
        if(~board_rst_n) begin
            m_axis_data_tdata_1_sin <= 16'd0;
            m_axis_data_tdata_1_cos <= 16'd0;
        end else begin
            m_axis_data_tdata_1_sin <= m_axis_data_tdata_1[31:16];
            m_axis_data_tdata_1_cos <= m_axis_data_tdata_1[15:0];
        end
    end

    /*生成5MHz的sin和cos*/
    always @(posedge board_clk_50mhz or negedge board_rst_n) begin
        if(~board_rst_n) begin
            m_axis_data_tdata_2_sin <= 16'd0;
            m_axis_data_tdata_2_cos <= 16'd0;
        end else begin
            m_axis_data_tdata_2_sin <= m_axis_data_tdata_2[31:16];
            m_axis_data_tdata_2_cos <= m_axis_data_tdata_2[15:0];
        end
    end

    clk_wiz_50mhz clk_wiz_50mhz_inst
   (
    // Clock out ports
    .clk_out1(board_clk_50mhz),     // output clk_out1
    // Status and control signals
    .reset(!board_rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(board_clk_100mhz)); 

    dds_sin_cos_1 dds_sin_cos_1_inst_1 (    //generate 5khz
        .aclk(board_clk_50mhz),                                  // input wire aclk
        .aresetn(locked),                            // input wire aresetn
        .s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
        .s_axis_config_tdata(32'd429_497),    // input wire [31 : 0] s_axis_config_tdata
        .m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
        .m_axis_data_tdata(m_axis_data_tdata_1)        // output wire [31 : 0] m_axis_data_tdata
    );

    dds_sin_cos_1 dds_sin_cos_1_inst_2 (    //generate 5mhz
        .aclk(board_clk_50mhz),                                  // input wire aclk
        .aresetn(locked),                            // input wire aresetn
        .s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
        .s_axis_config_tdata(32'd429_496_730),    // input wire [31 : 0] s_axis_config_tdata
        .m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
        .m_axis_data_tdata(m_axis_data_tdata_2)        // output wire [31 : 0] m_axis_data_tdata
    );

    mult_gen_0 mult_gen_0_inst (
        .CLK(board_clk_50mhz),  // input wire CLK
        .A(m_axis_data_tdata_1_sin),      // input wire [15 : 0] A
        .B(m_axis_data_tdata_2_sin),      // input wire [15 : 0] B
        .P(mult_5k_5m_hz)      // output wire [31 : 0] P
    );

endmodule
