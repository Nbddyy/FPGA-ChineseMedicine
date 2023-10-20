

	module ADS42LB69(

		input clk,
		input rst_n,
		
		input wire ADC1_CLKOUTP,
		
		input wire ADC1_DB0P,
		//input wire ADC1_DB0M,
	
	   input wire ADC1_DB2P,
	  // input wire ADC1_DB2M,
	
	   input wire ADC1_DB4P,
	 //  input wire ADC1_DB4M,
	
	   input wire ADC1_DB6P,
	 //  input wire ADC1_DB6M,
	
	   input wire ADC1_DB8P,
	 //  input wire ADC1_DB8M,
	
   	input wire ADC1_DB10P,
	  // input wire ADC1_DB10M,
	
	   input wire ADC1_DB12P,
	 //  input wire ADC1_DB12M,
	
	   input wire ADC1_DB14P,
	  // input wire ADC1_DB14M,
		
		output wire [15:0] ADC_OUT

	);
	
	
	
	//////////////////
	
	 wire [15:0] adc_data_a;
	
	adc_ddr2sdr #
(
    .ADC_WIDTH                          ( 16                        )
) adc_da_ddr2sdr (
    // AD Clock
    .adc_clk                            ( ADC1_CLKOUTP                   ),
    // AD Data DDR In
    .adc_din                            ( {ADC1_DB14P,ADC1_DB12P,ADC1_DB10P,ADC1_DB8P,ADC1_DB6P,ADC1_DB4P,ADC1_DB2P,ADC1_DB0P}                    ),
    // AD Data SDR Out
    .adc_dout                           ( adc_data_a                )
);
	
	
	assign ADC_OUT = adc_data_a;
	
	
	
	
	
	
	
	
	
	
	
	
	
	



	endmodule












































































