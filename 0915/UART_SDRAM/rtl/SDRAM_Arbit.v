module SDRAM_Arbit 
(
	input clk,
	input rst_n,
	input [3:0] init_cmd,
	input [1:0] init_ban,
	input [12:0] init_addr,
	input init_end,
	input aref_req,
	input [3:0] aref_cmd,
	input [1:0] aref_ban,
	input [12:0] aref_addr,
	input aref_end,
	input wr_req,
	input [3:0] wr_cmd,
	input [1:0] wr_ban,
	input [12:0] wr_sdram_addr,
	input wr_sdram_en,
	input [15:0] wr_sdram_data,
	input wr_end,
	input rd_req,
	input [3:0] rd_cmd,
	input [1:0] rd_ban,
	input [12:0] rd_sdram_addr,
	input rd_end,
	output aref_en,
	output wr_en,
	output rd_en,
	output sdram_cke,
	output sdram_cs_n,
	output sdram_cas_n,
	output sdram_ras_n,
	output sdram_we_n,
	output reg [1:0] sdram_ban,
	output reg [12:0] sdram_addr,
	inout [15:0] sdram_dq
);

	//定义仲裁模块下存在的几种状态
	parameter IDLE = 5'b00_001;
	parameter ARBIT = 5'b00_010;
	parameter AREF =  5'b00_100;
	parameter WRITE = 5'b01_000;
	parameter READ = 5'b10_000;

	parameter NOP_CMD = 4'b0111;
	parameter NOP_BAN = 2'b11;
	parameter NOP_ADDR = 13'h1FFF;

	reg [4:0] arbit_state;
	reg [3:0] sdram_cmd;

	/*arbit_state transition logic*/
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			arbit_state <= IDLE;
		end else begin
			case(arbit_state)
				IDLE : arbit_state <= (init_end) ? ARBIT : arbit_state;

				ARBIT : begin
					if(aref_req) begin
						arbit_state <= AREF;
					end else if(wr_req) begin
						arbit_state <= WRITE;
					end else if(rd_req) begin
						arbit_state <= READ;
					end else begin
						arbit_state <= arbit_state;
					end
				end

				WRITE : arbit_state <= (wr_end) ? ARBIT : arbit_state;
				READ : arbit_state <= (rd_end) ? ARBIT : arbit_state;
				AREF : arbit_state <= (aref_end) ? ARBIT : arbit_state;
				default : arbit_state <= ARBIT;
			endcase
		end
	end

	/*temp sdram_cmd*/
	always @(*) begin
		case(arbit_state)
			IDLE : sdram_cmd <= init_cmd;
			ARBIT : sdram_cmd <= NOP_CMD;
			WRITE : sdram_cmd <= wr_cmd;
			READ : sdram_cmd <= rd_cmd;
			AREF : sdram_cmd <= aref_cmd;
			default : sdram_cmd <= NOP_CMD;
		endcase
	end

	assign sdram_cke = 1'b1;

	/*series _n*/
	assign sdram_cs_n = sdram_cmd[3];
	assign sdram_cas_n = sdram_cmd[1];
	assign sdram_ras_n = sdram_cmd[2];
	assign sdram_we_n = sdram_cmd[0];

	/*output sdram_ban*/
	always@(*) begin
		case(arbit_state)
			IDLE : sdram_ban <= init_ban;
			ARBIT : sdram_ban <= NOP_BAN;
			WRITE : sdram_ban <= wr_ban;
			READ : sdram_ban <= rd_ban;
			AREF : sdram_ban <= aref_ban;
			default : sdram_ban <= NOP_BAN;
		endcase
	end 

	/*output sdram_addr*/
	always@(*) begin
		case(arbit_state)
			IDLE : sdram_addr <= init_addr;
			ARBIT : sdram_addr <= NOP_ADDR;
			WRITE : sdram_addr <= wr_sdram_addr;
			READ : sdram_addr <= rd_sdram_addr;
			AREF : sdram_addr <= aref_addr;
			default : sdram_addr <= NOP_ADDR;
		endcase
	end 

	/*series en*/
	assign aref_en = (arbit_state == AREF) ? 1'b1 : 1'b0;
	assign wr_en = (arbit_state == WRITE) ? 1'b1 : 1'b0;
	assign rd_en = (arbit_state == READ) ? 1'b1 : 1'b0;

	assign sdram_dq = (wr_en) ? wr_sdram_data : 16'bz;
	
endmodule