module Detect_Module (
	input clk,
	input rst_n, 
	input [7:0] op_data,
	input op_flag,
	output reg [3:0] led_out
);
	
	//定义序列检测的几种状态
	parameter IDLE = 8'd0;
	parameter B_AA = 8'd1;
	parameter B_BB = 8'd2;
	parameter B_CC = 8'd3;
	parameter B_DD = 8'd4;
	parameter E_55 = 8'd5;
	parameter E_66= 8'd6;
	parameter E_77 = 8'd7;
	parameter E_88 = 8'd8;
	
	reg [7:0] state;

	/*state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			state <= IDLE;
		end else if(op_flag) begin
			case(state) 
				IDLE : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h55) ? E_55 : IDLE;
				
				B_AA : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'hBB) ? B_BB : (op_data == 8'h55) ? E_55 : IDLE;
				B_BB : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h55) ? E_55 : (op_data == 8'hCC) ? B_CC : IDLE;
				B_CC : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h55) ? E_55 : (op_data == 8'hDD) ? B_DD : IDLE;
				B_DD : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h55) ? E_55 : IDLE;

				E_55 : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h66) ? E_66 : (op_data == 8'h55) ? E_55 : IDLE;
				E_66 : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h77) ? E_77 : (op_data == 8'h55) ? E_55 : IDLE;
				E_77 : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h88) ? E_88 : (op_data == 8'h55) ? E_55 : IDLE;
				E_88 : state <= (op_data == 8'hAA) ? B_AA : (op_data == 8'h55) ? E_55 : IDLE;

				default : state <= IDLE;
			endcase
		end else begin
			state <= state;
		end
	end

	/*output led_out*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			led_out <= 4'b1111;
		end else begin
			case(state) 
				B_DD : led_out <= 4'b0000;
				E_88 : led_out <= 4'b1111;
				default : led_out <= led_out;
			endcase
		end
	end

endmodule