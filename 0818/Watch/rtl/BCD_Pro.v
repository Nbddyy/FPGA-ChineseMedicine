module BCD_Pro (
	input clk,
	input rst_n,
	input [7:0] hours,
	input [7:0] minutes,
	input [7:0] seconds,
	input [5:0] sel_in,
	output reg [7:0] data_sta,	//这里指的是一个sel_out周期内的对应数码管的标准码元格式
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

    wire [7:0] hour;
    wire [7:0] minute;
    wire [7:0] second;
    wire [5:0] sel_out_temp;

    /*output data_sta*/
    always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		data_sta <= 8'b1111_1111;
    	end else begin
    		case(sel_out_temp) 
    			6'b000_001 : begin
    				case(second[3:0])
    					4'd0 : data_sta <= digit_0;
    					4'd1 : data_sta <= digit_1;
    					4'd2 : data_sta <= digit_2;
    					4'd3 : data_sta <= digit_3;
    					4'd4 : data_sta <= digit_4;
    					4'd5 : data_sta <= digit_5;
    					4'd6 : data_sta <= digit_6;
    					4'd7 : data_sta <= digit_7;
    					4'd8 : data_sta <= digit_8;
    					4'd9 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
    			end

    			6'b000_010 : begin
    				case(second[7:4])
    					4'd0 : data_sta <= digit_0;
    					4'd1 : data_sta <= digit_1;
    					4'd2 : data_sta <= digit_2;
    					4'd3 : data_sta <= digit_3;
    					4'd4 : data_sta <= digit_4;
    					4'd5 : data_sta <= digit_5;
    					4'd6 : data_sta <= digit_6;
    					4'd7 : data_sta <= digit_7;
    					4'd8 : data_sta <= digit_8;
    					4'd9 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
    			end

    			6'b000_100 : begin
    				case(minute[3:0])
    					4'd0 : data_sta <= {1'b0,digit_0[6:0]};
    					4'd1 : data_sta <= {1'b0,digit_1[6:0]};
    					4'd2 : data_sta <= {1'b0,digit_2[6:0]};
    					4'd3 : data_sta <= {1'b0,digit_3[6:0]};
    					4'd4 : data_sta <= {1'b0,digit_4[6:0]};
    					4'd5 : data_sta <= {1'b0,digit_5[6:0]};
    					4'd6 : data_sta <= {1'b0,digit_6[6:0]};
    					4'd7 : data_sta <= {1'b0,digit_7[6:0]};
    					4'd8 : data_sta <= {1'b0,digit_8[6:0]};
    					4'd9 : data_sta <= {1'b0,digit_9[6:0]};
    					default : data_sta <= 8'b0111_1111;
    				endcase
    			end

    			6'b001_000 : begin
    				case(minute[7:4])
    					4'd0 : data_sta <= digit_0;
    					4'd1 : data_sta <= digit_1;
    					4'd2 : data_sta <= digit_2;
    					4'd3 : data_sta <= digit_3;
    					4'd4 : data_sta <= digit_4;
    					4'd5 : data_sta <= digit_5;
    					4'd6 : data_sta <= digit_6;
    					4'd7 : data_sta <= digit_7;
    					4'd8 : data_sta <= digit_8;
    					4'd9 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
    			end

    			6'b010_000 : begin
    				case(hour[3:0])
    					4'd0 : data_sta <= {1'b0,digit_0[6:0]};
    					4'd1 : data_sta <= {1'b0,digit_1[6:0]};
    					4'd2 : data_sta <= {1'b0,digit_2[6:0]};
    					4'd3 : data_sta <= {1'b0,digit_3[6:0]};
    					4'd4 : data_sta <= {1'b0,digit_4[6:0]};
    					4'd5 : data_sta <= {1'b0,digit_5[6:0]};
    					4'd6 : data_sta <= {1'b0,digit_6[6:0]};
    					4'd7 : data_sta <= {1'b0,digit_7[6:0]};
    					4'd8 : data_sta <= {1'b0,digit_8[6:0]};
    					4'd9 : data_sta <= {1'b0,digit_9[6:0]};
    					default : data_sta <= 8'b0111_1111;
    				endcase
    			end

    			6'b100_000 : begin
    				case(hour[7:4])
    					4'd0 : data_sta <= digit_0;
    					4'd1 : data_sta <= digit_1;
    					4'd2 : data_sta <= digit_2;
    					4'd3 : data_sta <= digit_3;
    					4'd4 : data_sta <= digit_4;
    					4'd5 : data_sta <= digit_5;
    					4'd6 : data_sta <= digit_6;
    					4'd7 : data_sta <= digit_7;
    					4'd8 : data_sta <= digit_8;
    					4'd9 : data_sta <= digit_9;
    					default : data_sta <= 8'b1111_1111;
    				endcase
    			end

    			default : data_sta <= 8'b1111_1111;

    		endcase
    	end
    end

    /*output sel_out*/
    always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		sel_out <= 6'd0;
    	end else begin
    		sel_out <= sel_out_temp;
    	end
    end

	BCD_Con inst_BCD_Con (
		.clk(clk),
		.rst_n(rst_n),
		.hours(hours),
		.minutes(minutes),
		.seconds(seconds),
		.sel_in(sel_in),
		.hour(hour),
		.minute(minute),
		.second(second),
		.sel_out(sel_out_temp)
	);


endmodule
