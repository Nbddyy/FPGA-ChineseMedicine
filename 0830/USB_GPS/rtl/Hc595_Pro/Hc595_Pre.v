module Hc595_Pre (
	input clk,
	input rst_n,
	input [7:0] data_pre,
	input [5:0] sel_in,
	output reg ds,
	output reg shcp,
	output reg stcp,
	output reg oe
);

	reg [1:0] cnt_4;	//用于确定shcp占4个clk的记录
	reg [3:0] cnt_14;   //用于串行输入位数的记录

	/*cnt_4的循环实现*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4 <= 2'd0;
		end else begin
			cnt_4 <= cnt_4 + 2'd1;
		end
	end

	/*cnt_14的循环计数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_14 <= 4'd0;
		end else if(cnt_14 == 4'd13 && cnt_4 == 2'd3) begin
			cnt_14 <= 4'd0;
		end else if(cnt_4 == 2'd3) begin
			cnt_14 <= cnt_14 + 4'd1;
		end else begin
			cnt_14 <= cnt_14;
		end
	end

	/*output shcp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			shcp <= 1'd0;
		end else if(cnt_4 == 2'd2) begin
			shcp <= 1'd1;
		end else if(cnt_4 == 2'd0) begin
			shcp <= 1'd0;
		end else begin
			shcp <= shcp;
		end
	end

	/*output stcp*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			stcp <= 1'd0;
		end else if(cnt_14 == 4'd13 && cnt_4 == 2'd3) begin
			stcp <= 1'd1;
		end else begin
			stcp <= 1'd0;
		end
	end

    /*output ds*/
    always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		ds <= 1'd0;
    	end else if(cnt_14 <= 4'd5) begin
    		ds <= sel_in[cnt_14];
    	end else begin
    		ds <= data_pre[4'd13 - cnt_14];
    	end
    end

    /*output oe*/
    always @(posedge clk or negedge rst_n) begin
    	if(~rst_n) begin
    		oe <= 1'd1;
    	end else begin
    		oe <= 1'd0;
    	end
    end

endmodule