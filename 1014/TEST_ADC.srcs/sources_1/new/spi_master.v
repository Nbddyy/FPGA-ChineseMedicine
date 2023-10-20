`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/19 11:29:47
// Design Name: 
// Module Name: spi_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//   SPI MODE 3
//      change data @negedge
//      read data @posedge
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_master #
(
    parameter               CLK_DIV     = 10,    // base on 100MHz clk
    parameter               DATA_WIDTH  = 8 // data width 8/16/32 bit
//    parameter               MLB = 0         // 0-MSB 1-LSB
 )
(
    input                   clk,
    input                   rst,
    
    input                   spi_en,
    input                   mlb, // 0-MSB 1-LSB
    input                   tx_en,
    input [DATA_WIDTH-1:0]  tx_data,
    output reg              tx_finished,
    input                   rx_en,
    output [DATA_WIDTH-1:0] rx_data,
    output reg              rx_data_valid,
    
    output reg              cs_n,
    output reg              sclk,
    output reg              sdata_o,
    input                   sdata_i
    );
    
localparam      IDLE = 3'b000;
localparam      CS_B = 3'b001;
localparam      SEND = 3'b010;
localparam      WAIT = 3'b100;
localparam      STOP = 3'b101;
    
reg [2:0]           c_state;
reg [2:0]           n_state;

reg [9:0]           clk_cnt; //clock diver counter
reg [9:0]           wait_cnt;
reg [9:0]           tx_data_cnt; 
reg [DATA_WIDTH-1:0]tx_data_reg;
reg [DATA_WIDTH-1:0]tx_data_reg0;
reg [DATA_WIDTH-1:0]tx_data_reg1;
reg [DATA_WIDTH-1:0]tx_data_reg2;
reg [DATA_WIDTH-1:0]rx_data_reg;
reg                 spi_en_reg;
reg                 spi_en_reg0;
reg                 sclk_reg;
wire                sclk_edge_r;
wire                sclk_edge_f;
//
always @(posedge clk) begin
    spi_en_reg0 <= spi_en;
    spi_en_reg  <= spi_en_reg0;
end
always @(posedge clk) begin
    tx_data_reg0 <= tx_data;
    tx_data_reg1 <= tx_data_reg0;
    tx_data_reg2 <= tx_data_reg1;
end
//
always @(posedge clk) begin
    if(rst) begin
        c_state     <= IDLE;
    end else begin
        c_state     <= n_state;
    end
end
always @(*) begin
    n_state = c_state;
    case(c_state)
        IDLE: begin
            if(spi_en_reg) begin
                n_state = CS_B;
            end else begin
                n_state = IDLE;
            end
        end
        CS_B: begin
            n_state = SEND;
        end
        SEND: begin
            if((tx_data_cnt == DATA_WIDTH) && sclk_edge_f) begin
                n_state = WAIT;
            end else begin
                n_state = SEND;
            end
        end
        WAIT: begin
            if(wait_cnt == CLK_DIV) begin
                n_state = STOP;
            end else begin
                n_state = WAIT;
            end
        end
        STOP: begin
            n_state = IDLE;
        end
        default: begin
            n_state = IDLE;
        end
    endcase
end
    
//cs_n
always @(posedge clk) begin
    if(rst) begin
        cs_n    <= 1'b1;
    end else if(c_state == CS_B) begin
        cs_n    <= 1'b0;
    end else if(c_state == SEND) begin
        cs_n    <= 1'b0;
    end else if(c_state == WAIT) begin
        cs_n    <= 1'b0;
    end else if(c_state == STOP) begin
        cs_n    <= 1'b1;
    end else begin
        cs_n    <= 1'b1;
    end
end

//sclk
always @(posedge clk) begin
    if(rst) begin
        clk_cnt     <= 10'd0;
    end else if(c_state == SEND) begin
        if(clk_cnt == (CLK_DIV-1)) begin
            clk_cnt     <= 10'd0;
        end else begin
            clk_cnt     <= clk_cnt + 1;
        end
    end else begin
        clk_cnt     <= 10'd0;
    end
end
always @(posedge clk) begin
    if(rst) begin
        sclk        <= 1'b0;
    end else if(c_state == SEND) begin
        if(clk_cnt == (CLK_DIV-1)) begin
            sclk        <= ~sclk;
        end else begin
            sclk        <= sclk;
        end
    end else begin
        sclk        <= 1'b0;
    end
end
always @(posedge clk) begin
    sclk_reg <= sclk;
end
assign sclk_edge_r = ((!sclk_reg) && (sclk)) ? 1'b1 : 1'b0;
assign sclk_edge_f = ((sclk_reg) && (!sclk)) ? 1'b1 : 1'b0;
//sdata_o
always @(posedge clk) begin
    if(rst) begin
        sdata_o     <= 1'b0;
        tx_data_reg <= 0;
    end else if(c_state == CS_B)begin
        if(mlb) begin  //LSB 
            sdata_o     <= tx_data_reg2[0];
            tx_data_reg <= {1'b0,tx_data_reg2[DATA_WIDTH-1:1]};
        end else begin //MSB 
            sdata_o     <= tx_data_reg2[DATA_WIDTH-1];
            tx_data_reg <= {tx_data_reg2[DATA_WIDTH-2:0],1'b0};
        end
    end else if(c_state ==SEND)begin
        if(sclk_edge_f && mlb) begin //LSB
            sdata_o     <= tx_data_reg[0];
            tx_data_reg <= {1'b0,tx_data_reg[DATA_WIDTH-1:1]};
        end else if(sclk_edge_f &&(!mlb)) begin //MSB
            sdata_o     <= tx_data_reg[DATA_WIDTH-1];
            tx_data_reg <= {tx_data_reg[DATA_WIDTH-2:0],1'b0};
        end else begin
            sdata_o     <= sdata_o;
            tx_data_reg <= tx_data_reg;
        end
    end else begin
        sdata_o     <= 1'b0;
        tx_data_reg <= 0;
    end
end
//tx_data_cnt
always @(posedge clk) begin
    if(rst) begin
        tx_data_cnt <= 10'd0;
    end else if(c_state == CS_B) begin
        tx_data_cnt <= 10'd1;
    end else if(c_state == SEND) begin
        if(sclk_edge_f) begin
            tx_data_cnt <= tx_data_cnt + 1;
        end else begin
            tx_data_cnt <= tx_data_cnt;
        end
    end else begin
        tx_data_cnt <= 10'd0;
    end
end
//
always @(posedge clk) begin
    if(rst) begin
        tx_finished <= 1'b0;
    end else if(c_state == STOP) begin
        tx_finished <= 1'b1;
    end else begin
        tx_finished <= 1'b0;
    end
end
always @(posedge clk) begin
    if(rst) begin
        rx_data_valid <= 1'b0;
    end else if(c_state == STOP) begin
        rx_data_valid <= 1'b1;
    end else begin
        rx_data_valid <= 1'b0;
    end
end
//
always @(posedge clk) begin
    if(rst) begin
        rx_data_reg <= 0;
    end else if(c_state == SEND) begin
        if(sclk_edge_r && mlb) begin //LSB
            rx_data_reg <= {sdata_i,rx_data_reg[DATA_WIDTH-1:1]};
        end else if(sclk_edge_r &&(!mlb)) begin
            rx_data_reg <= {rx_data_reg[DATA_WIDTH-2:0],sdata_i};
        end else begin
            rx_data_reg <= rx_data_reg;
        end
    end else if(c_state == WAIT) begin
        rx_data_reg <= rx_data_reg;
    end else if(c_state == STOP) begin
        rx_data_reg <= rx_data_reg;
    end else begin
        rx_data_reg <= 0;
    end
end
assign rx_data = rx_data_reg;
//wait_cnt
always @(posedge clk) begin
    if(rst) begin
        wait_cnt <= 10'd0; 
    end else if(c_state == WAIT) begin
        wait_cnt <= wait_cnt +1;
    end else begin
        wait_cnt <= 10'd0;
    end
end


endmodule
