module Data_Gen 
#(
	parameter cnt_1ms_max = 16'd49_999
)
(
	input clk,
	input rst_n,
	output  reg [7:0] hours,
	output reg [7:0] minutes,
	output reg [7:0] seconds,
	output reg [5:0] sel_gen
);

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

	/*output hours*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			hours <= 8'd15;
		end else if(hours == 8'd23 && minutes == 8'd59 && seconds == 8'd59 && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			hours <= 8'd0;
		end else if(minutes == 8'd59 && seconds == 8'd59 && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			hours <= hours + 8'd1;
		end else begin
			hours <= hours;
		end
	end

	/*output minutes*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			minutes <= 8'd57;
		end else if(minutes == 8'd59 && seconds == 8'd59 && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			minutes <= 8'd0;
		end else if(seconds == 8'd59 && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			minutes <= minutes + 8'd1;
		end else begin
			minutes <= minutes;
		end
	end

	/*output seconds*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			seconds <= 8'd34;
		end else if(seconds == 8'd59 && cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			seconds <= 8'd0;
		end else if(cnt_100 == 8'd99 && cnt_1ms == cnt_1ms_max) begin
			seconds <= seconds + 8'd1;
		end else begin
			seconds <= seconds;
		end
	end

	/*output sel_gen*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			sel_gen <= 6'd0;
		end else begin
			case(cnt_6)
				3'd0 : sel_gen <= 6'b000_001;
				3'd1 : sel_gen <= 6'b000_010;
				3'd2 : sel_gen <= 6'b000_100;
				3'd3 : sel_gen <= 6'b001_000;
				3'd4 : sel_gen <= 6'b010_000;
				3'd5 : sel_gen <= 6'b100_000;
				default : sel_gen <= 6'd0;
			endcase
		end
	end

endmodule
