

`timescale 1ns / 1ps

module adc_ddr2sdr #
(
    parameter   ADC_WIDTH               =   16                      ,
    parameter   FPGA_FAMILY             =   "Xilinx_VTR"
)
(
    // AD Clock
    input   wire                        adc_clk                     ,

    // AD Data DDR In
    input   wire    [(ADC_WIDTH/2)-1:0] adc_din                     ,

    // AD Data SDR Out
    output  wire    [ADC_WIDTH-1:0]     adc_dout
);


/******************************************************************************/
/****************************** Parameters Define *****************************/
/******************************************************************************/


/******************************************************************************/
/****************************** Internal Signals ******************************/
/******************************************************************************/


/******************************************************************************/
/****************************** Main Logic Work *******************************/
/******************************************************************************/

/*
 *  ----------------------------------------------------------------------------
 *  Name        :   iddr
 *  Description :
 *  ----------------------------------------------------------------------------
 */
genvar i;
generate
for (i=0; i<ADC_WIDTH/2; i=i+1) begin : a123
    iddr                                # (
        .FPGA_FAMILY                    ( FPGA_FAMILY               )
    ) adc_iddr (
    .clk                                ( adc_clk                   ),
    .ddr                                ( adc_din[i]                ),
    .sdr_p                              ( adc_dout[(i*2)]           ),
    .sdr_n                              ( adc_dout[(i*2)+1]         )
    );
end
endgenerate


endmodule
