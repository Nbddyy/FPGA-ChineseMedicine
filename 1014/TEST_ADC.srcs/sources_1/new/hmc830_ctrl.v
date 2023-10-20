`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 23:38:24
// Design Name: 
// Module Name: hmc830_ctrl
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


module hmc830_ctrl(

    input wire clk,
    
    output wire rst_n_delay,
    output wire start_cfg_hmc830

    );
    
    //power on 2s start cfg hmc830
    
    parameter TIME_2S = 32'd2000;
	
	
	
    reg [15:0] delay_cnt = 16'd0;
    reg rst_n_delay_r = 1'b0;
    
    always @ (posedge clk)
    begin 
        if(delay_cnt == 16'd1000)
            begin 
                delay_cnt <= delay_cnt;
                rst_n_delay_r <= 1'b1;
            end 
        else 
            begin 
                delay_cnt <= delay_cnt + 1'b1 ;
                rst_n_delay_r <= 1'b0;
            end 
    end 
    
    assign rst_n_delay = rst_n_delay_r;
    
    
    
    reg [31:0] delay_time_cnt = 32'd0; // 2s   10 000 000
    reg start_cfg_hmc830_r = 1'b0;
    
    always @ (posedge clk)
    begin 
        if(delay_time_cnt == TIME_2S)
            begin 
                delay_time_cnt <= delay_time_cnt;
            end 
        else 
            begin 
                delay_time_cnt <= delay_time_cnt + 1'b1 ;
            end 
    end 
    
    always @ (posedge clk)
    begin 
        if((delay_time_cnt >= (TIME_2S - 10)) && (delay_time_cnt <= (TIME_2S - 2)))
            begin 
                start_cfg_hmc830_r <= 1'b1;
            end 
        else 
            begin 
                start_cfg_hmc830_r <= 1'b0;
            end 
    end 
    
    
    assign start_cfg_hmc830 = start_cfg_hmc830_r;
    
    
    
    
endmodule
