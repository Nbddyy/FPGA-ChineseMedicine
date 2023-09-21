module SDRAM_Ctrl (
	input clk,
	input rst_n,
	input wr_req,
	input [23:0] wr_addr,
	input [15:0] wr_data,
	input [9:0] wr_burst_len,
	input rd_req,
	input [23:0] rd_addr,
	input [9:0] rd_burst_len,
	output sdram_cke,
	output sdram_cs_n,
	output sdram_cas_n,
	output sdram_ras_n,
	output sdram_we_n,
	output [1:0] sdram_ban,
	output [12:0] sdram_addr,
	output rd_ack,
	output [15:0] rd_sdram_data, 
	output sdram_wr_ack,
	output init_end,
	inout [15:0] sdram_dq
);

	/*SDRAM_Init*/
	wire [3:0] init_cmd;
	wire [1:0] init_ban;
	wire [12:0] init_addr;

	/*SDRAM_Aref*/
	wire aref_en;
	wire aref_req;
	wire [3:0] aref_cmd;
	wire [1:0] aref_ban;
	wire [12:0] aref_addr;
	wire aref_end;

	/*SDRAM_Write*/
	wire wr_en;
	wire wr_end;
	wire [3:0] wr_cmd;
	wire [1:0] wr_ban;
	wire [12:0] wr_sdram_addr;
	wire wr_sdram_en;
	wire [15:0] wr_sdram_data;

	/*SDRAM_Read*/
	wire rd_en;
	wire rd_end;
	wire [3:0] rd_cmd;
	wire [1:0] rd_ban;
	wire [12:0] rd_sdram_addr;

	SDRAM_Init inst_SDRAM_Init (
		.clk       (clk),
		.rst_n     (rst_n),
		.init_cmd  (init_cmd),
		.init_ban  (init_ban),
		.init_addr (init_addr),
		.init_end  (init_end)
	);


	SDRAM_ARef inst_SDRAM_ARef (
		.clk       (clk),
		.rst_n     (rst_n),
		.init_end  (init_end),
		.aref_en   (aref_en),
		.aref_req  (aref_req),
		.aref_cmd  (aref_cmd),
		.aref_ban  (aref_ban),
		.aref_addr (aref_addr),
		.aref_end  (aref_end)
	);

	SDRAM_Write inst_SDRAM_Write (
		.clk           (clk),
		.rst_n         (rst_n),
		.init_end      (init_end),
		.wr_en         (wr_en),
		.wr_addr       (wr_addr),
		.wr_data       (wr_data),
		.wr_burst_len  (wr_burst_len),
		.wr_end        (wr_end),
		.wr_cmd        (wr_cmd),
		.wr_ban        (wr_ban),
		.wr_sdram_addr (wr_sdram_addr),
		.wr_sdram_en   (wr_sdram_en),
		.wr_sdram_data (wr_sdram_data),
		.wr_ack        (sdram_wr_ack)
	);

	SDRAM_Read inst_SDRAM_Read (
		.clk           (clk),
		.rst_n         (rst_n),
		.init_end      (init_end),
		.rd_en         (rd_en),
		.rd_burst_len  (rd_burst_len),
		.rd_addr       (rd_addr),
		.rd_data       (sdram_dq),
		.rd_end        (rd_end),
		.rd_cmd        (rd_cmd),
		.rd_ban        (rd_ban),
		.rd_sdram_addr (rd_sdram_addr),
		.rd_ack        (rd_ack),
		.rd_sdram_data (rd_sdram_data)
	);


	SDRAM_Arbit inst_SDRAM_Arbit (
		.clk           (clk),
		.rst_n         (rst_n),
		.init_cmd      (init_cmd),
		.init_ban      (init_ban),
		.init_addr     (init_addr),
		.init_end      (init_end),
		.aref_req      (aref_req),
		.aref_cmd      (aref_cmd),
		.aref_ban      (aref_ban),
		.aref_addr     (aref_addr),
		.aref_end      (aref_end),
		.wr_req        (wr_req),
		.wr_cmd        (wr_cmd),
		.wr_ban        (wr_ban),
		.wr_sdram_addr (wr_sdram_addr),
		.wr_sdram_en   (wr_sdram_en),
		.wr_sdram_data (wr_sdram_data),
		.wr_end        (wr_end),
		.rd_req        (rd_req),
		.rd_cmd        (rd_cmd),
		.rd_ban        (rd_ban),
		.rd_sdram_addr (rd_sdram_addr),
		.rd_end        (rd_end),
		.aref_en       (aref_en),
		.wr_en         (wr_en),
		.rd_en         (rd_en),
		.sdram_cke     (sdram_cke),
		.sdram_cs_n    (sdram_cs_n),
		.sdram_cas_n   (sdram_cas_n),
		.sdram_ras_n   (sdram_ras_n),
		.sdram_we_n    (sdram_we_n),
		.sdram_ban     (sdram_ban),
		.sdram_addr    (sdram_addr),
		.sdram_dq      (sdram_dq)
	);


endmodule