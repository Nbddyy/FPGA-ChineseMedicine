`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:52:52
// Design Name: 
// Module Name: div_clk
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


module div_clk( ///   5mhz clk out

    input wire clk,
    
    output wire div_clk
  

    );
    
    reg [7:0] cnt = 8'd0;
    reg div_clk_r = 1'b0;
    
    parameter DIV_PARA = 10'd9;
    
    
    always @ (posedge clk)
    begin 
        if(cnt == DIV_PARA)
            begin 
                cnt <= 8'd0;
                div_clk_r <= ~div_clk_r;
            end 
       else 
            begin 
                cnt <= cnt + 1'b1 ;
            end 
    end 
    
    assign div_clk = div_clk_r;
    

    
    
    
    
    
    
    
    
endmodule
