	`timescale 1ns / 1ps
	//////////////////////////////////////////////////////////////////////////////////
	// Company: 
	// Engineer: 
	// 
	// Create Date: 2023/04/14 16:08:08
	// Design Name: 
	// Module Name: ADC_DATA_XDH_tb
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


	module ADC_DATA_XDH_tb(

		);
		
		
	reg  adc_clk;
	reg  main_clk;
	reg  rst_n;	
		
	initial begin 	
		adc_clk = 1'b0;
		main_clk = 1'b0;
		rst_n = 1'b0;
		#400
		rst_n = 1'b1;
		
	end 
		
	always #13.0208	 adc_clk = ~adc_clk;
	always #2.17014	 main_clk = ~main_clk;
		
		
	wire [31:0] DDS_SIN_COS_dataout;	
		
	//gen 2.5mhz  
	// DDS_SIN_COS DDS_SIN_COS (
	  // .aclk(adc_clk),                                  // input wire aclk
	  // .s_axis_config_tvalid(1'b1),  // input wire s_axis_config_tvalid
	  // .s_axis_config_tdata(32'd279620267),    // input wire [31 : 0] s_axis_config_tdata
	  // .m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
	  // .m_axis_data_tdata(DDS_SIN_COS_dataout)        // output wire [31 : 0] m_axis_data_tdata
	// );	
		

	//2.23mhz	
	DDS_SIN_COS DDS_SIN_COS (
	  .aclk(adc_clk),                                  // input wire aclk
	  .s_axis_config_tvalid(1'b1),  // input wire s_axis_config_tvalid
	  .s_axis_config_tdata(32'd249421278),    // input wire [31 : 0] s_axis_config_tdata
	  .m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
	  .m_axis_data_tdata(DDS_SIN_COS_dataout)        // output wire [31 : 0] m_axis_data_tdata
	);			
			
			
			
		
		
		
		
	ADC_DATA_XDH ADC_DATA_XDH(

		. adc_clk(adc_clk),
		. main_clk(main_clk), // 230.4mhz

		. rst_n(rst_n),

		. adc_data(DDS_SIN_COS_dataout[31-:16])
		
	);	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	endmodule
