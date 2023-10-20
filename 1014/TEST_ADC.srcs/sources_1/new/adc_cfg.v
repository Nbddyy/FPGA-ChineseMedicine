`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 14:30:00
// Design Name: 
// Module Name: ad9516_cfg
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


module adc_cfg(
    input               i_clk,
    input               i_rst,
    input               i_ad9516_cfg_en,
    output              o_ad9516_ref_sel,
    output              o_ad9516_spi_cs_b,
    output              o_ad9516_spi_sclk,
    output              o_ad9516_spi_sdio,
    input               i_ad9516_spi_sdo
    );
    

localparam  IDLE        = 3'd0;    
localparam  SEND        = 3'd1;    
localparam  WAIT_SEND   = 3'd2;    
localparam  WAIT        = 3'd3;    
localparam  END         = 3'd4;    

reg         spi_en;
reg [23:0]  spi_data;
wire        spi_tx_finished;
reg [07:0]  data_index;
reg [04:0]  wait_cnt;
reg [02:0]  state;

assign o_ad9516_ref_sel = 0;

wire [15:0] cfg_data[0:52];

assign cfg_data[ 0]  = 16'h06_80;
assign cfg_data[ 1]  = 16'h07_00;
assign cfg_data[ 2]  = 16'h08_0C;
assign cfg_data[ 3]  = 16'h0C_00;
assign cfg_data[ 4]  = 16'h0D_6C;
assign cfg_data[ 5]  = 16'h0F_44;  /////44 测试模式

assign cfg_data[ 6]  = 16'h10_00;
assign cfg_data[ 7]  = 16'h11_00;
assign cfg_data[ 8]  = 16'h12_00;
assign cfg_data[ 9]  = 16'h13_00;
assign cfg_data[10]  = 16'h14_00;
assign cfg_data[11]  = 16'h15_01;
assign cfg_data[12]  = 16'h16_00;
assign cfg_data[13]  = 16'h17_80;  //0x02-REF1  0x44-REF2
assign cfg_data[14]  = 16'h18_00;
assign cfg_data[15]  = 16'h1F_80;  //0x0A-OFF  0x0C-ON 960mV
assign cfg_data[16]  = 16'h20_00;


assign cfg_data[17]  = 16'h0B_00;
assign cfg_data[18]  = 16'h20_00;
assign cfg_data[19]  = 16'h20_00;   ///CONFIG THIS ADC DONE;
assign cfg_data[20]  = 16'h20_00;
assign cfg_data[21]  = 16'h20_00;
assign cfg_data[22]  = 16'h20_00;
assign cfg_data[23]  = 16'h20_00;
assign cfg_data[24]  = 16'h20_00;
assign cfg_data[25]  = 16'h20_00;
assign cfg_data[26]  = 16'h20_00;
assign cfg_data[27]  = 16'h20_00;
assign cfg_data[28]  = 16'h20_00;  //divider 0x00-2 0x11-4 0x22-6 0x55-12
assign cfg_data[29]  = 16'h20_00;  //0x80 bypass divider
assign cfg_data[30]  = 16'h20_00;
assign cfg_data[31]  = 16'h20_00;  //divider 0x00-2 0x11-4 0x22-6 0x55-12
assign cfg_data[32]  = 16'h20_00;  //0x80 bypass divider
assign cfg_data[33]  = 16'h20_00;
assign cfg_data[34]  = 16'h20_00;
assign cfg_data[35]  = 16'h20_00;
assign cfg_data[36]  = 16'h20_00;
assign cfg_data[37]  = 16'h20_00;
assign cfg_data[38]  = 16'h20_00;
assign cfg_data[39]  = 16'h20_00;
assign cfg_data[40]  = 16'h20_00;
assign cfg_data[41]  = 16'h20_00;
assign cfg_data[42]  = 16'h20_00;
assign cfg_data[43]  = 16'h20_00;
assign cfg_data[44]  = 16'h20_00;
assign cfg_data[45]  = 16'h20_00;  //VCO 2400MHz divider 0x00-2 0x01-3 0x02-4
assign cfg_data[46]  = 16'h20_00;
assign cfg_data[47]  = 16'h20_00;
assign cfg_data[48]  = 16'h20_00;
assign cfg_data[49]  = 16'h20_00;
assign cfg_data[50]  = 16'h20_00;
assign cfg_data[51]  = 16'h20_00;
assign cfg_data[52]  = 16'h20_00;




always @(posedge i_clk)begin
    if(i_rst)begin
        spi_en      <= 0;
        spi_data    <= 0;
        data_index  <= 0;
        wait_cnt    <= 0;
        state       <= IDLE;
    end else begin
        case(state)
            IDLE:begin
                spi_en      <= 1'b0;
                spi_data    <= 24'd0;
                data_index  <= 8'd0;
                wait_cnt    <= 4'h0;
                if(i_ad9516_cfg_en)begin
                    state   <= SEND;
                end else begin
                    state   <= IDLE;
                end
            end
            SEND:begin
                spi_en      <= 1'b1;
                spi_data    <= cfg_data[data_index];
                data_index  <= data_index;
                wait_cnt    <= 4'h0;
                state       <= WAIT_SEND;
            end
            WAIT_SEND:begin
                spi_en      <= 1'b0;
                spi_data    <= spi_data;
                wait_cnt    <= 4'h0;
                if(spi_tx_finished)begin            ////当该寄存器配置完成之后，
                    data_index  <= data_index+1;
                    state       <= WAIT;
                end else begin
                    data_index  <= data_index;
                    state       <= WAIT_SEND;
                end
            end
            WAIT:begin
                spi_en      <= 1'b0;
                spi_data    <= spi_data;
                data_index  <= data_index;
                wait_cnt    <= wait_cnt+1;
                if(data_index==8'd53)begin   ///////////�?有的寄存器配置完�?
                    state   <= END;
                end else begin
                    if(wait_cnt==5'h1F)begin
                        state   <= SEND;
                    end else begin
                        state   <= WAIT;
                    end
                end
            end
            END:begin
                spi_en      <= 1'b0;
                spi_data    <= 24'd0;
                data_index  <= 8'd0;
                wait_cnt    <= 4'h0;
                state       <= IDLE;
            end
            default:begin
                spi_en      <= 1'b0;
                spi_data    <= 24'd0;
                data_index  <= 8'd0;
                wait_cnt    <= 4'h0;
                state       <= IDLE;
            end
        endcase
    end
end

spi_master # (
    .CLK_DIV        (20),  //base on 100M
    .DATA_WIDTH     (16)
)spi (
    .clk            (i_clk), 
    .rst            (i_rst), 
    .spi_en         (spi_en), 
    .mlb            (0),            // 0-MSB 1-LSB   MSB为从高位�?始发�?
    .tx_en          (spi_en), 
    .tx_data        (spi_data),
    .tx_finished    (spi_tx_finished),
    .rx_en          (0), 
    .rx_data        ( ), 
    .rx_data_valid  ( ),
    .cs_n           (o_ad9516_spi_cs_b), 
    .sclk           (o_ad9516_spi_sclk), 
    .sdata_o        (o_ad9516_spi_sdio), 
//    .sdata_i        (1'b1)
    .sdata_i        (i_ad9516_spi_sdo)
    );
endmodule
