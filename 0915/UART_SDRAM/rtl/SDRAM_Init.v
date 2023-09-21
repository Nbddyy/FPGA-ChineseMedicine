module SDRAM_Init 
#(
	parameter cnt_200us_max = 16'd19_999,	//时钟频率为100MHz
	parameter trp_max = 4'd2,				//具体周期数参考手册
	parameter trfc_max = 4'd7,
	parameter tmrd_max = 4'd3,
	parameter cnt_init_aref_max = 2'd2		//初始化中Auto Refrsh的个数(本次手册最少为2)
)
(
	input clk,
	input rst_n,
	output reg [3:0] init_cmd,
	output reg [1:0] init_ban,
	output reg [12:0] init_addr,
	output reg init_end
);

	//定义初始化存在的几种状态
	parameter IDLE = 8'b0000_0001;
	parameter PRE = 8'b0000_0010;
	parameter TRP = 8'b0000_0100;
	parameter AR = 8'b0000_1000;
	parameter TRFC = 8'b0001_0000;
	parameter LMR = 8'b0010_0000;
	parameter TMRD = 8'b0100_0000;
	parameter END = 8'b1000_0000;

	//定义几种状态下的四位指令Data
	parameter NOP_CMD = 4'b0111;
	parameter PRE_CMD =  4'b0010;
	parameter AR_CMD = 4'b0001;
	parameter LMR_CMD = 4'b0000;

	reg [15:0] cnt_200us;
	reg stable_flag;
	reg [7:0] init_state;
	reg [3:0] cnt_clk;
	wire cnt_clk_rst;
	reg [1:0] cnt_init_aref;
	reg trp_flag;
	reg trfc_flag;
	reg tmrd_flag;

	/*等待时钟稳定后进行初始command*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_200us <= 16'd0;
		end else if(cnt_200us == cnt_200us_max) begin
			cnt_200us <= cnt_200us_max;
		end else begin
			cnt_200us <= cnt_200us + 16'd1;
		end
	end

	/*stable clk flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			stable_flag <= 1'd0;
		end else if(cnt_200us == cnt_200us_max - 16'd1) begin
			stable_flag <= 1'd1;
		end else begin
			stable_flag <= 1'd0;
		end
	end

	/*init_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			init_state <= IDLE;
		end else begin
			case(init_state) 
				IDLE : init_state <= (stable_flag) ? PRE : IDLE;
				PRE : init_state <= TRP;
				TRP : init_state <= (trp_flag) ? AR : TRP;
				AR : init_state <= TRFC;

				TRFC : begin
					if(trfc_flag && cnt_init_aref != 2'd2) begin
						init_state <= AR;
					end else if(trfc_flag && cnt_init_aref == 2'd2) begin
						init_state <= LMR;
					end else begin
						init_state <= init_state;
					end
				end

				LMR : init_state <= TMRD;
				TMRD : init_state <= (tmrd_flag) ? END : TMRD;
				default : init_state <= IDLE;
			endcase
		end
	end

	/*temp cnt_clk*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_clk <= 4'd0;
		end else begin
			case(init_state)
				IDLE : cnt_clk <= 4'd0;
				PRE : cnt_clk <= cnt_clk + 4'd1;
				TRP : cnt_clk <= (cnt_clk == trp_max) ? 4'd0 : cnt_clk + 4'd1;
				AR : cnt_clk <= cnt_clk + 4'd1;
				TRFC : cnt_clk <= (cnt_clk == trfc_max) ? 4'd0 : cnt_clk + 4'd1;
				LMR : cnt_clk <= cnt_clk + 4'd1;
				TMRD : cnt_clk <= (cnt_clk == tmrd_max) ? 4'd0 : cnt_clk + 4'd1;
				END : cnt_clk <= 4'd0;
			endcase
		end
	end

	/*组合逻辑下cnt_clk取0的使能信号*/
	assign cnt_clk_rst = (cnt_clk == 4'd0) ? 1'd1 : 1'd0;

	/*用于记录Auto Refresh的个数*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_init_aref <= 2'd0;
		end else if(cnt_init_aref == cnt_init_aref_max) begin
			cnt_init_aref <= cnt_init_aref;
		end else if(init_state == TRFC && cnt_clk == trfc_max - 4'd1) begin
			cnt_init_aref <= cnt_init_aref + 2'd1;
		end else begin
			cnt_init_aref <= cnt_init_aref;
		end
	end

	/*temp trp_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			trp_flag <= 1'd0;
		end else if(init_state == TRP && cnt_clk == trp_max - 4'd1) begin
			trp_flag <= 1'd1;
		end else begin
			trp_flag <= 1'd0;
		end
	end

	/*temp trfc_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			trfc_flag <= 1'd0;
		end else if(init_state == TRFC && cnt_clk == trfc_max - 4'd1) begin
			trfc_flag <= 1'd1;
		end else begin
			trfc_flag <= 1'd0;
		end
	end

	/*temp tmrd_flag*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			tmrd_flag <= 1'd0;
		end else if(init_state == TMRD && cnt_clk == 4'd2) begin
			tmrd_flag <= 1'd1;
		end else begin
			tmrd_flag <= 1'd0;
		end
	end

	/*output init_cmd*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			init_cmd <= NOP_CMD;
		end else begin
			case(init_state)
				IDLE : init_cmd <= NOP_CMD;
				PRE : init_cmd <= PRE_CMD;
				TRP : init_cmd <= NOP_CMD;
				AR : init_cmd <= AR_CMD;
				TRFC : init_cmd <= NOP_CMD;
				LMR : init_cmd <= LMR_CMD;
				default : init_cmd <= NOP_CMD;
			endcase
		end
	end

	/*output init_ban*/	
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			init_ban <= 2'b11;
		end else begin
			init_ban <= (init_state == LMR) ? 2'b00 : 2'b11;
		end
	end

	/*output init_addr*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			init_addr <= 13'h1FFF;
		end else begin
			init_addr <= (init_state == LMR) ? 13'h0037 : 13'h1FFF;
		end
	end

	/*output init_end*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			init_end <= 1'd0;
		end else begin
			init_end <= (tmrd_flag) ? 1'd1 : init_end;
		end
	end

endmodule