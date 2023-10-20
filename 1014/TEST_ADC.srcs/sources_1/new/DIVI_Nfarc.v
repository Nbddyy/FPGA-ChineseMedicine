`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:03:35
// Design Name: 
// Module Name: DIVI_Nfarc
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


module DIVI_Nfarc(

    input wire clk,
    input wire [30:0] dividend,
    input [6 : 0] divisor,
    output wire [30 : 0] quotient

    );
    
    reg [30:0] quotient_r = 31'd0;
    
    always @ (posedge clk)
    begin 
     quotient_r <= dividend / divisor;
    end 
    
    assign quotient = quotient_r;
    
    
    
endmodule



















