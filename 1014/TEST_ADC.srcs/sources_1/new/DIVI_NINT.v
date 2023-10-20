`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/08 18:06:31
// Design Name: 
// Module Name: DIVI_NINT
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


module DIVI_NINT(
    input clk,
    input [14 : 0] dividend,
    input [6 : 0] divisor,
    output [14 : 0] quotient,
    output [6 : 0] fractional	
    
    );
    
    reg [14:0] quotient_r = 15'd0;
    reg [6:0] fractional_r = 7'd0;
    
    always @ (posedge clk)
    begin 
        quotient_r <= dividend / divisor;
        fractional_r <= dividend % divisor;
    end 
    
    assign quotient = quotient_r;
    assign fractional = fractional_r;
    
    
endmodule
