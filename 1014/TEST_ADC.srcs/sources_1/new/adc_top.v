module adc_top(
////adc_interface/////
	input              	adc_clk_a_p		,			
	input              	adc_clk_a_n		,		
										
	input     [7:0]    	adc_data_a_p	,			
	input     [7:0]    	adc_data_a_n	,			
           	                				
										
	input     [7:0]    	adc_data_b_p	,			
	input     [7:0]    	adc_data_b_n	,			


/////adc_spi/////////
	output             	adc_sen			,
	output             	adc_sclk		,
	output             	adc_sdata		,
	input            	adc_sdout		,
	output             	adc_reset		,

//////adc_data///////

    output              o_adc_clk_d     	,
    output   wire   [15:0]  o_adc_data_d    	,

	 output     wire  [15:0]  o_adc_data_d2    	,

	output              o_adc_vild_d		,
/////2832//////
	output wire 		LMH2832_cs,
    output wire 		LMH2832_SCLK,
    output wire 		LMH2832_SDI,
    input wire  		LMH2832_SDO,	
	output wire 		LMH2832_PDA,
	output wire 		LMH2832_PDB,
/////rst_clk////////

	input				clk_100m		, 
	input     			rstn_125m  ,
	
	input   rst_n,
	
	output wire lvds_rclk

	



);

//	wire lvds_rclk;


	
   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(lvds_rclk ),  // Buffer output
      .I(adc_clk_a_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(adc_clk_a_n) // Diff_n buffer input (connect directly to top-level port)
   );





























 adc_interface adc_interface_u_d1(
 .adc_clk_p				(adc_clk_a_p)		,
 .adc_clk_n				(adc_clk_a_n)		,

 .adc_data_p				(adc_data_a_p)		,    /////adc_data_b_p
 .adc_data_n				(adc_data_a_n)		,    ///adc_data_b_n
 
 .rstn_125m                 (rstn_125m)			,

 .o_adc_clk					(o_adc_clk_d)		,
 .o_adc_data				(o_adc_data_d)		,
 .o_adc_vild				(o_adc_vild_d),
 
 .rst_n (rst_n),
. lvds_rclk(lvds_rclk)

 );




 adc_interface adc_interface_u_d2(
 .adc_clk_p				(adc_clk_a_p)		,
 .adc_clk_n				(adc_clk_a_n)		,

 .adc_data_p				(adc_data_b_p)		,    /////adc_data_b_p
 .adc_data_n				(adc_data_b_n)		,    ///adc_data_b_n
 
 .rstn_125m                 (rstn_125m)			,

 .o_adc_clk					()		,
 .o_adc_data				(o_adc_data_d2)		,
 .o_adc_vild				(),
 
 .rst_n (rst_n),
. lvds_rclk(lvds_rclk)

 );










adc_cfg_ctrl adc_cfg_ctrl(
    . i_clk(clk_100m),   /////////////////输入时钟为配置ADC芯片的，采用100mhz
    . i_rst(~rst_n ),
    . o_ad9516_ref_sel(),
    . o_ad9516_spi_cs_b(adc_sen),
    . o_ad9516_spi_sclk(adc_sclk),
    . o_ad9516_spi_sdio(adc_sdata),
    . i_ad9516_spi_sdo(adc_sdout),
	.reset_cnt(reset_cnt),
	 .adc_reset(adc_reset)
    );













endmodule