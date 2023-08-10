// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy	qq1877117587@outlook.com
// File   : Poll_Detect.v
// Create : 2023-08-10 10:46:38
// Revise : 2023-08-10 10:46:38
// Editor : sublime text4, tab size (4)
// Descri : 要求data_valid与up_data对其，即没有潜伏期
// -----------------------------------------------------------------------------
module Poll_Detect (
	input rdclk,    //时钟与DCFIFO的rdclk保持一致
	input rst_n,
	input [2:0] access,
	input [63:0] q_in,
	output reg data_valid,
	output reg [63:0] up_data
);

	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end else if(access != 3'd0) begin
			data_valid <= 1'd1;
			up_data <= q_in;
		end else begin
			data_valid <= 1'd0;
			up_data <= 64'd0;
		end
	end

endmodule
