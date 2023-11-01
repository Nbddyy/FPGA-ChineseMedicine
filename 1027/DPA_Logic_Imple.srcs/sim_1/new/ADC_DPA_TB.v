`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 13:56:20
// Design Name: 
// Module Name: ADC_DPA_TB
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


module ADC_DPA_TB();


reg clk_100MHz;
reg clk_200MHz;
reg rst_n; 
wire adc_clkout_p;
wire adc_clkout_n;  
reg [7:0] adc_data_p;
wire [7:0] adc_data_n; 

wire RESET;
wire ADC_SPI_CLK;
wire ADC_SPI_CS;       
wire ADC_SPI_MOSI;
wire adc_samp_clkout;
wire [15:0] adc_samp_data; 
wire pass;
wire no_pass; 


reg clk_250MHz;
reg clk_500MHz;
initial begin
    clk_100MHz <= 1'b0;
    clk_200MHz <= 1'b0;
    clk_250MHz <= 1'b0;
    clk_500MHz <= 1'b0;
    rst_n <= 1'b0;
    #66
    rst_n <= 1'b1;    
end

always #5 clk_100MHz = ~clk_100MHz;
always #2.5 clk_200MHz = ~clk_200MHz;
always #2 clk_250MHz = ~clk_250MHz;
always #1 clk_500MHz = ~clk_500MHz;

assign adc_clkout_p = clk_250MHz;
assign adc_clkout_n = ~clk_250MHz;

reg [15:0] cnt;
always@(posedge clk_250MHz or negedge rst_n) 
begin
    if(!rst_n)
        cnt <= 16'd0;
    else if(cnt == 16'd65535)
        cnt <= 16'd0;
    else
        cnt <= cnt + 16'd1;
end


wire [7:0] adc_data;
wire [7:0] adc_data_r;
always@(posedge clk_500MHz or negedge rst_n) 
begin
    if(!rst_n)
    begin
        adc_data_r <= 8'd0;
        adc_data_p <= 8'd0;
    end
    else 
    begin
        adc_data_r <= adc_data;
        adc_data_p <= adc_data_r;
    end
end


assign adc_data_n = ~adc_data_p;




genvar i;
generate for(i=0;i<=7;i=i+1) begin:iii
   ODDR #(
      .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_inst (
      .Q(adc_data[i]),   // 1-bit DDR output
      .C(clk_250MHz),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D1(cnt[2*i]), // 1-bit data input (positive edge)
      .D2(cnt[2*i+1]), // 1-bit data input (negative edge)
      .R(),   // 1-bit reset
      .S()    // 1-bit set
   );
end
endgenerate




ADC_DPA ADC_DPA
(
    .clk_100MHz  (clk_100MHz  )   ,
    .clk_200MHz  (clk_200MHz  )   ,
    .rst_n       (rst_n       )   , 
    .adc_clkout_p(adc_clkout_p)   ,
    .adc_clkout_n(adc_clkout_n)   ,  
    .adc_data_p  (adc_data_p  )   ,
    .adc_data_n  (adc_data_n  )   , 

    .RESET          (RESET          ), 
    .ADC_SPI_CLK    (ADC_SPI_CLK    ), 
    .ADC_SPI_CS     (ADC_SPI_CS     ),       
    .ADC_SPI_MOSI   (ADC_SPI_MOSI   ),
    .adc_samp_clkout(adc_samp_clkout),
    .adc_samp_data  (adc_samp_data  ),     
    .pass           (pass           ),
    .no_pass        (no_pass )

);


endmodule
