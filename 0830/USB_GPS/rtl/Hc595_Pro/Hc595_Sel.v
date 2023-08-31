module Hc595_Sel 
#(
	parameter cnt_1ms_max = 16'd49_999
)
(
	input clk,
	input rst_n,
	input [15:0] hours,
	input [15:0] minutes,
	input [15:0] seconds,
	output reg [7:0] data_sta,
	output reg [5:0] sel_out
);

	/*定义数码管对应数字的码元
	注意：第二个、第四个数码管的hp位点亮*/
	parameter digit_0 = 8'b1100_0000;
	parameter digit_1 = 8'b1111_1001;
	parameter digit_2 = 8'b1010_0100;
	parameter digit_3 = 8'b1011_0000;
	parameter digit_4 = 8'b1001_1001;
	parameter digit_5 = 8'b1001_0010;
	parameter digit_6 = 8'b1000_0010;
	parameter digit_7 = 8'b1111_1000;
	parameter digit_8 = 8'b1000_0000;
	parameter digit_9 = 8'b1001_0000;
	
	reg [15:0] cnt_1ms;	//用于记录1ms的计数
	reg [2:0] cnt_6;
	reg [7:0] cnt_100;

	/*cnt_1ms计数的代码实现*/
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_1ms <= 16'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_1ms <= 16'd0;
		end else begin
			cnt_1ms <= cnt_1ms + 16'd1;
		end
	end

	/*cnt_6用于每个位选占1ms的代码实现*/
	always@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_6 <= 3'd0;
		end else if(cnt_6 == 3'd5 && cnt_1ms == cnt_1ms_max) begin
			cnt_6 <= 3'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_6 <= cnt_6 + 3'd1;
		end else begin
			cnt_6 <= cnt_6;
		end
	end

	/*cnt_100用于记录100ms的代码体现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_100 <= 8'd0;
		end else if(cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			cnt_100 <= 8'd0;
		end else if(cnt_1ms == cnt_1ms_max) begin
			cnt_100 <= cnt_100 + 8'd1;
		end else begin
			cnt_100 <= cnt_100;
		end
	end

	

	/*output sel_out*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel_out <= 6'd0;
		end else begin
			case(cnt_6)
				3'd0 : sel_out <= 6'b000_001;
				3'd1 : sel_out <= 6'b000_010;
				3'd2 : sel_out <= 6'b000_100;
				3'd3 : sel_out <= 6'b001_000;
				3'd4 : sel_out <= 6'b010_000;
				3'd5 : sel_out <= 6'b100_000;
				default : sel_out <= 6'd0;
			endcase
		end
	end

	/*output data_sta*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			data_sta <= 8'b1111_1111;
		end else begin
			case(cnt_6)
				3'd0 : begin
					case(seconds[7:0])
    					8'h30 : data_sta <= digit_0;
    					8'h31 : data_sta <= digit_1;
    					8'h32 : data_sta <= digit_2;
    					8'h33 : data_sta <= digit_3;
    					8'h34 : data_sta <= digit_4;
    					8'h35 : data_sta <= digit_5;
    					8'h36 : data_sta <= digit_6;
    					8'h37 : data_sta <= digit_7;
    					8'h38 : data_sta <= digit_8;
    					8'h39 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end

				3'd1 : begin
					case(seconds[15:8])
    					8'h30 : data_sta <= digit_0;
    					8'h31 : data_sta <= digit_1;
    					8'h32 : data_sta <= digit_2;
    					8'h33 : data_sta <= digit_3;
    					8'h34 : data_sta <= digit_4;
    					8'h35 : data_sta <= digit_5;
    					8'h36 : data_sta <= digit_6;
    					8'h37 : data_sta <= digit_7;
    					8'h38 : data_sta <= digit_8;
    					8'h39 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end
				3'd2 : begin
					case(minutes[7:0])
    					8'h30 : data_sta <= {1'b0,digit_0[6:0]};
    					8'h31 : data_sta <= {1'b0,digit_1[6:0]};
    					8'h32 : data_sta <= {1'b0,digit_2[6:0]};
    					8'h33 : data_sta <= {1'b0,digit_3[6:0]};
    					8'h34 : data_sta <= {1'b0,digit_4[6:0]};
    					8'h35 : data_sta <= {1'b0,digit_5[6:0]};
    					8'h36 : data_sta <= {1'b0,digit_6[6:0]};
    					8'h37 : data_sta <= {1'b0,digit_7[6:0]};
    					8'h38 : data_sta <= {1'b0,digit_8[6:0]};
    					8'h39 : data_sta <= {1'b0,digit_9[6:0]};
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end
				3'd3 : begin
					case(minutes[15:8])
    					8'h30 : data_sta <= digit_0;
    					8'h31 : data_sta <= digit_1;
    					8'h32 : data_sta <= digit_2;
    					8'h33 : data_sta <= digit_3;
    					8'h34 : data_sta <= digit_4;
    					8'h35 : data_sta <= digit_5;
    					8'h36 : data_sta <= digit_6;
    					8'h37 : data_sta <= digit_7;
    					8'h38 : data_sta <= digit_8;
    					8'h39 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end
				3'd4 : begin
					case(hours[7:0])
    					8'h30 : data_sta <= {1'b0,digit_0[6:0]};
    					8'h31 : data_sta <= {1'b0,digit_1[6:0]};
    					8'h32 : data_sta <= {1'b0,digit_2[6:0]};
    					8'h33 : data_sta <= {1'b0,digit_3[6:0]};
    					8'h34 : data_sta <= {1'b0,digit_4[6:0]};
    					8'h35 : data_sta <= {1'b0,digit_5[6:0]};
    					8'h36 : data_sta <= {1'b0,digit_6[6:0]};
    					8'h37 : data_sta <= {1'b0,digit_7[6:0]};
    					8'h38 : data_sta <= {1'b0,digit_8[6:0]};
    					8'h39 : data_sta <= {1'b0,digit_9[6:0]};
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end
				3'd5 : begin
					case(hours[15:8])
    					8'h30 : data_sta <= digit_0;
    					8'h31 : data_sta <= digit_1;
    					8'h32 : data_sta <= digit_2;
    					8'h33 : data_sta <= digit_3;
    					8'h34 : data_sta <= digit_4;
    					8'h35 : data_sta <= digit_5;
    					8'h36 : data_sta <= digit_6;
    					8'h37 : data_sta <= digit_7;
    					8'h38 : data_sta <= digit_8;
    					8'h39 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
				end
				default : data_sta <= digit_0;
			endcase
		end
	end

endmodule