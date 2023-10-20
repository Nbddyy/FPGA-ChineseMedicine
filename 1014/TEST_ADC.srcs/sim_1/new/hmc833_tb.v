`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:11:07
// Design Name: 
// Module Name: hmc833_tb
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


module hmc833_tb(

    );
    
    reg clock;
    reg reset;
    reg start;
    
    
    initial begin 
        clock = 1'b0;
        reset = 1'b0;
        start = 1'b0;
        #400.1
        reset = 1'b1;
        #300.1
        start = 1'b1;
        #100
        start = 1'b0;
    end 
    
    always #5 clock = ~clock ;
    
    
     // hmc830 hmc830(
       // .	sck_spi(),
        // .	sdi_spi(),
        // .	sen_spi(),
       // .	done(),
       
       // .	start(start),
       // .	clock(clock),
       // .	reset(reset),
       // .	FREQ_DATA(250)
        // );
    
    
    
    hmc830_top hmc830_top(

    . clk(clock), //100mhz
    . rst_n(reset) 
    
    

    );
    
    
    
    
    
    
    
endmodule
