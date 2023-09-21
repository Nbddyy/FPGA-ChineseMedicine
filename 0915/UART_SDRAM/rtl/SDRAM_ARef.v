module SDRAM_ARef 
#(
	parameter cnt_aref_max = 16'd749,
	parameter cnt_aref_num_max = 2'd2,
	parameter trp_max = 4'd2,				//具体周期数参考手册
	parameter trfc_max = 4'd7
)
(
	input clk,
	input rst_n,
	input init_end,
	input aref_en,
	output reg aref_req,
	output reg [3:0] aref_cmd,
	output [1:0] aref_ban,
	output [12:0] aref_addr,
	output aref_end
);

	//定义Auto Refresh模块下存在的几种状态
	parameter IDLE = 6'b000_001;
	parameter PRE = 6'b000_010;
	parameter TRP = 6'b000_100;
	parameter AR = 6'b001_000;
	parameter TRFC = 6'b010_000;
	parameter END = 6'b100_000;

	//定义几种状态下的四位指令Data
	parameter NOP_CMD = 4'b0111;
	parameter PRE_CMD =  4'b0010;
	parameter AR_CMD = 4'b0001;
	parameter LMR_CMD = 4'b0000;

	reg [15:0] cnt_aref;
	wire aref_flag;
	reg [5:0] aref_state;
	reg [3:0] cnt_clk;
	reg cnt_clk_rst;
	reg [1:0] cnt_aref_num;
	wire trp_flag;
	wire trfc_flag;

	/*用于记录Auto Refresh的周期数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_aref <= 16'd0;
		end else if(!init_end || cnt_aref == cnt_aref_max) begin
			cnt_aref <= 16'd0;
		end else begin
			cnt_aref <= cnt_aref + 16'd1;
		end
	end

	/*temp aref_flag*/
	assign aref_flag = (aref_state == PRE) ? 1'd1 : 1'd0;

	/*aref_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			aref_state <= IDLE;
		end else begin
			case(aref_state)
				IDLE : aref_state <= (aref_en) ? PRE : IDLE;
				PRE : aref_state <= TRP;
				TRP : aref_state <= (trp_flag) ? AR : TRP;
				AR : aref_state <= TRFC;
				
				TRFC : begin
					if(trfc_flag && cnt_aref_num == cnt_aref_num_max) begin
						aref_state <= END;
					end else if(trfc_flag) begin
						aref_state <= AR;
					end else begin
						aref_state <= aref_state;
					end
				end 

				END : aref_state <= IDLE;
				default : aref_state <= IDLE;
			endcase
		end
	end

	/*temp cnt_clk*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_clk <= 4'd0;
		end else if(cnt_clk_rst) begin
			cnt_clk <= 4'd0;
		end else begin
			cnt_clk <= cnt_clk + 4'd1;
		end
	end

	/*用于cnt_clk清零的标识*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_clk_rst <= 1'd1;
		end else begin
			case(aref_state)
				IDLE : cnt_clk_rst <= (aref_en) ? 1'd0 : 1'd1;
				PRE : cnt_clk_rst <= 1'd0;
				TRP : cnt_clk_rst <= (cnt_clk == trp_max - 4'd1) ? 1'd1 : 1'd0;
				AR : cnt_clk_rst <= 1'd0;
				TRFC : cnt_clk_rst <= (cnt_clk == trfc_max - 4'd1) ? 1'd1 : 1'd0;
				default : cnt_clk_rst <= 1'd1;
			endcase
		end
	end

	/*用于记录command执行过程中的Auto Refresh个数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_aref_num <= 2'd0;
		end else begin
			case(aref_state)
				AR : cnt_aref_num <= cnt_aref_num + 2'd1;
				END : cnt_aref_num <= 2'd0;
				default : cnt_aref_num <= cnt_aref_num;
			endcase
		end
	end

	/*temp trp_flag*/
	assign trp_flag = (aref_state == TRP && cnt_clk == trp_max) ? 1'd1 : 1'd0;

	/*temp trfc_flag*/
	assign trfc_flag = (aref_state == TRFC && cnt_clk == trfc_max) ? 1'd1 : 1'd0;

	/*output aref_req*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			aref_req <= 1'd0;
		end else if(aref_state == PRE) begin
			aref_req <= 1'd0;
		end else if(cnt_aref == cnt_aref_max - 16'd1) begin
			aref_req <= 1'd1;
		end else begin
			aref_req <= aref_req;
		end
	end

	/*output aref_cmd*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			aref_cmd <= NOP_CMD;
		end else begin
			case(aref_state)
				IDLE : aref_cmd <= NOP_CMD;
				PRE : aref_cmd <= PRE_CMD;
				TRP : aref_cmd <= NOP_CMD;
				AR : aref_cmd <= AR_CMD;
				TRFC : aref_cmd <= NOP_CMD;
				default : aref_cmd <= NOP_CMD;
			endcase
		end
	end

	/*output aref_ban*/	
	assign aref_ban = 2'b11;

	/*output aref_addr*/
	assign aref_addr = 13'h1FFF;

	/*output aref_end*/
	assign aref_end = (aref_state == END) ? 1'd1 : 1'd0;

endmodule