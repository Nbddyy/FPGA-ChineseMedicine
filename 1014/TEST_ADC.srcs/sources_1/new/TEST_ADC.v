`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:30:57
// Design Name: 
// Module Name: TEST_ADC
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


module TEST_ADC(

    input wire clk_in1_p,
    input wire clk_in1_n,
    
    //cfg   hmc830   output 250mhz
    output wire hmc830_sck_spi,
    output wire hmc830_sdi_spi,
    output wire hmc830_sen_spi,
    
 ////cfg  ads42lb69   cap data   
    input     [7:0]   ADC1_DA_P,
    input     [7:0]   ADC1_DA_M,
   
    input             ADC1_CLKOUTP,
    input             ADC1_CLKOUTM,
    input     [7:0]   ADC1_DB_P,
    input     [7:0]   ADC1_DB_M,
    
    output             ADC1_SEN,
    output             ADC1_SCLK,
    output             ADC1_SDATA,
    input              ADC1_SDOUT,
    output             ADC1_RESET,
    
   ////cfg  ads42lb69   cap data   
    input     [7:0]   ADC2_DA_P,
    input     [7:0]   ADC2_DA_M,
   
    input             ADC2_CLKOUTP,
    input             ADC2_CLKOUTM,
    input     [7:0]   ADC2_DB_P,
    input     [7:0]   ADC2_DB_M,
    
    output             ADC2_SEN,
    output             ADC2_SCLK,
    output             ADC2_SDATA,
    input              ADC2_SDOUT,
    output             ADC2_RESET,

///////时钟扇出缓冲器，选择HMC830的时钟输出给ADC

	output wire clk_sel2
	
	// output wire SYNCIN_AD1_P,
	// output wire SYNCIN_AD1_N,
	
	// output wire SYNCIN_AD2_P,
	// output wire SYNCIN_AD2_N




    );
    
    wire pll_locked;
    wire pll_100mhz;
    
      clk_wiz_0 clk_wiz_0
   (
    // Clock out ports
    .clk_out1(),     // output clk_out1
    .clk_out2(pll_100mhz),     // output clk_out2
    // Status and control signals
    .locked(pll_locked),       // output locked
   // Clock in ports
    .clk_in1_p(clk_in1_p),    // input clk_in1_p
    .clk_in1_n(clk_in1_n));    // input clk_in1_n
    
    
 //ADC输出的时钟和数据信号   
	
	wire adc1_rx_clk;
	wire [15:0] adc1_dataout_cha;
	wire [15:0] adc1_dataout_chb;
	
	wire adc2_rx_clk;
	wire [15:0] adc2_dataout_cha;
	wire [15:0] adc2_dataout_chb;
	
    
     adc_top adc_top_chip1(
     .adc_clk_a_p				(ADC1_CLKOUTP							),
     .adc_clk_a_n				(ADC1_CLKOUTM							),
    
     .adc_data_a_p				(ADC1_DA_P								),
     .adc_data_a_n				(ADC1_DA_M								),
     
     .adc_data_b_p				(ADC1_DB_P								),
     .adc_data_b_n				(ADC1_DB_M								),
     
    
     .adc_sen					(ADC1_SEN								),
     .adc_sclk					(ADC1_SCLK								),
     .adc_sdata					(ADC1_SDATA								),
     .adc_sdout					(ADC1_SDOUT								),
     .adc_reset					(ADC1_RESET								),
    
    
     
     .rst_n (hmc830_cfg_done ),
     .lvds_rclk(adc1_rx_clk),
     
     .rstn_125m                 (hmc830_cfg_done							),
     .clk_100m					(pll_100mhz								),
     
     .o_adc_clk_d				( 							),
     .o_adc_data_d				(adc1_dataout_cha							),
    . o_adc_data_d2(adc1_dataout_chb),
     .o_adc_vild_d				(							)
	 


 );
    
	
	
    
    adc_top adc_top_chip2(
     .adc_clk_a_p				(ADC2_CLKOUTP							),
     .adc_clk_a_n				(ADC2_CLKOUTM							),
    
     .adc_data_a_p				(ADC2_DA_P								),
     .adc_data_a_n				(ADC2_DA_M								),
     
     .adc_data_b_p				(ADC2_DB_P								),
     .adc_data_b_n				(ADC2_DB_M								),
     
    
     .adc_sen					(ADC2_SEN								),
     .adc_sclk					(ADC2_SCLK								),
     .adc_sdata					(ADC2_SDATA								),
     .adc_sdout					(ADC2_SDOUT								),
     .adc_reset					(ADC2_RESET								),
    
    
     
     .rst_n (hmc830_cfg_done ),
     .lvds_rclk(adc2_rx_clk),
     
     .rstn_125m                 (hmc830_cfg_done							),
     .clk_100m					(pll_100mhz								),
     
     .o_adc_clk_d				( 							),
     .o_adc_data_d				(adc2_dataout_cha							),
    . o_adc_data_d2(adc2_dataout_chb),
     .o_adc_vild_d				(							)
	 
	

 ); 
    
    
    
    
hmc830_top hmc830_top(

    . clk(pll_100mhz), //100mhz
 //   . rst_n() ,
    
    . sck_spi(hmc830_sck_spi),
    . sdi_spi(hmc830_sdi_spi),
    . sen_spi(hmc830_sen_spi),
     .hmc830_cfg_done(hmc830_cfg_done)
    );
    
    
    
    
    
    
endmodule
