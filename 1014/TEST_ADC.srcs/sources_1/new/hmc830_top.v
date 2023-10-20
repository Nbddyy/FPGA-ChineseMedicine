`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:56:30
// Design Name: 
// Module Name: hmc830_top
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


module hmc830_top(

    input wire clk, //100mhz
    input wire rst_n ,
    
    output wire sck_spi,
    output wire sdi_spi,
    output wire sen_spi,
    
    output wire hmc830_cfg_done

    );
    
    wire div_clk_out;
    wire rst_n_delay;
    wire start_cfg_hmc830;
    
    div_clk div_clk(

    . clk(clk),
    
    . div_clk(div_clk_out)
  
    );
    
    hmc830_ctrl hmc830_ctrl(

    . clk(div_clk_out),
    
    . rst_n_delay(rst_n_delay),
   . start_cfg_hmc830(start_cfg_hmc830)

    );
    
    
    
    hmc830 hmc830(
	.	sck_spi(sck_spi),
	.	sdi_spi(sdi_spi),
	.	sen_spi(sen_spi),
	.	done(hmc830_cfg_done),
	.	start(start_cfg_hmc830),
	.	clock(div_clk_out),
	.	reset(rst_n_delay),
	.	FREQ_DATA(250)
    );    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
