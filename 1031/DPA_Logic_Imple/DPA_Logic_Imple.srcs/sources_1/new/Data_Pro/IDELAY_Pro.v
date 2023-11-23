// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//      "header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy qq1877117587@outlook.com
// File   : IDELAY_Pro.v
// Create : 2023-10-28 15:41:54
// Revise : 2023-10-28 15:41:54
// Editor : sublime text4, tab size (4)
// Descri : 用于进行IDELAY自动轮询Tap的逻辑代码, 进行设计优化，定位符号要求的初始和截至TAP，然后取中间TAP(挡位)
// -----------------------------------------------------------------------------
module IDELAY_Pro (
	input clk,
	input refclk,	//参考时钟200MHz，挡位间隔78.125ps
	input rst_n, 
    input [2:0] detect_com, //[1] express the Bit_Splice_Detect_pro module detect result flag, [0] express detect result

	output clk_out,
    output [4:0] CNTVALUEOUT,
    output detect_over
);

	//定义状态
    reg [4:0] idelay_status;
    parameter IDLE = 5'b00001;
    parameter DELAY = 5'b00010;
    parameter COMPLE_INIT = 5'b00100;
    parameter COMPLE_END = 5'b01000;
    parameter DETECT_OVER = 5'b10000;

	IDELAYCTRL IDELAYCTRL_inst (
        .RDY(),       // 1-bit output: Ready output
        .REFCLK(refclk), // 1-bit input: Reference clock input
        .RST(!rst_n)        // 1-bit input: Active high reset input
   );

    reg no_delay;   //用于判断是否调用IDELAY进行时钟相位调整的标志

    wire clk_shift;
    reg CE;
    reg INC;
    reg LD;

    reg [5:0] CNTVALLUEIN_expand;

    IDELAYE2 #(
        .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
        .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
        .HIGH_PERFORMANCE_MODE("FALSE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
        .IDELAY_TYPE("VAR_LOAD"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
        .IDELAY_VALUE(0),                // Input delay tap setting (0-31)
        .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
        .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
        .SIGNAL_PATTERN("CLOCK")          // DATA, CLOCK input signal
    )
    IDELAYE2_inst (
        .CNTVALUEOUT(CNTVALUEOUT), // 5-bit output: Counter value output
        .DATAOUT(clk_shift),         // 1-bit output: Delayed data output
        .C(clk),                     // 1-bit input: Clock input
        .CE(CE),                   // 1-bit input: Active high enable increment/decrement input
        .CINVCTRL(),       // 1-bit input: Dynamic clock inversion input
        .CNTVALUEIN(CNTVALLUEIN_expand >> 1),   // 5-bit input: Counter value input
        .DATAIN(),           // 1-bit input: Internal delay data input
        .IDATAIN(clk),         // 1-bit input: Data input from the I/O
        .INC(INC),                 // 1-bit input: Increment / Decrement tap delay input
        .LD(LD),                   // 1-bit input: Load IDELAY_VALUE input
        .LDPIPEEN(),       // 1-bit input: Enable PIPELINE register to load data input
        .REGRST(!rst_n)            // 1-bit input: Active-high reset tap-delay input
    );


    /**********************************************************************/
    /*idelay_status transition*/
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            idelay_status <= IDLE;
        end else begin
            case(idelay_status)
                IDLE : idelay_status <= (detect_com[1] == 1'd1) ?  DELAY : idelay_status;
                DELAY : idelay_status <= (detect_com[1:0] == 2'b11) ? COMPLE_INIT : idelay_status;
                COMPLE_INIT : idelay_status <= (detect_com[1:0] == 2'b10 || (CNTVALUEOUT == 5'd31 && detect_com[1:0] == 2'b11)) ? COMPLE_END : idelay_status;
                COMPLE_END : idelay_status <= DETECT_OVER;
                DETECT_OVER : idelay_status <= idelay_status;
                default : idelay_status <= idelay_status;
            endcase
        end
    end

    /*no_delay*/
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            no_delay <= 1'd0;
        end else begin
            no_delay <= (idelay_status == IDLE && detect_com[1:0] == 2'b11) ? 1'd1 : no_delay;
        end
    end

    /*CE and INC Control*/
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            CE <= 1'd0;
        end else begin
            // CE <= (idelay_status != COMPLE_END && detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
            case(idelay_status)
                IDLE : CE <= (detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
                DELAY : CE <= (detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
                COMPLE_INIT : CE <= (detect_com[1:0] == 2'b11) ? 1'd1 : 1'd0;
                default : CE <= 1'd0;
            endcase
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            INC <= 1'd0;
        end else begin
            // INC <= (idelay_status != COMPLE_END && detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
            case(idelay_status)
                IDLE : INC <= (detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
                DELAY : INC <= (detect_com[1] == 1'd1) ? 1'd1 : 1'd0;
                COMPLE_INIT : INC <= (detect_com[1:0] == 2'b11) ? 1'd1 : 1'd0;
                default : INC <= 1'd0;
            endcase
        end
    end

    /***************************************************************************************/
    /*CNTVALUEIN*/
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            CNTVALLUEIN_expand <= 5'd0;
        end else begin
            CNTVALLUEIN_expand <= ((idelay_status == DELAY && detect_com[1:0] == 2'b11) || (idelay_status == COMPLE_INIT && (detect_com[1:0] == 2'b10 || (CNTVALUEOUT == 5'd31 && detect_com[1:0] == 2'b11)))) ? CNTVALLUEIN_expand + CNTVALUEOUT : CNTVALLUEIN_expand;
        end
    end

    /*LD*/
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            LD <= 1'd0;
        end else begin
            LD <= ((idelay_status == COMPLE_INIT) && (detect_com[1:0] == 2'b10 || (CNTVALUEOUT == 5'd31 && detect_com[1:0] == 2'b11))) ? 1'd1 : 1'd0;
        end
    end

    /***************************************************************************************/

    assign detect_over = (idelay_status == COMPLE_INIT && (detect_com[1:0] == 2'b10 || (CNTVALUEOUT == 5'd31 && detect_com[1:0] == 2'b11))) ? 1'd1 : 1'd0;

    // assign CE = (idelay_status == DELAY && detect_com == 2'b10) ? 1'd1 : 1'd0;
    // assign INC = (idelay_status == DELAY && detect_com == 2'b10) ? 1'd1 : 1'd0;

    /*output clk_out*/
    assign clk_out = (idelay_status == IDLE) ? clk : (idelay_status == DELAY && no_delay) ? clk : clk_shift;

endmodule