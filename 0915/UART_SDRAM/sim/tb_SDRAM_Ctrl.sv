
`timescale 1ns/1ps
module tb_SDRAM_Ctrl (); /* this is automatically generated */

	

	reg sys_clk;
	reg sys_rst_n;

	/**/
	wire  [3:0] init_cmd;
	wire  [1:0] init_ban;
	wire [12:0] init_addr;
	wire        init_end;

	/*Clk_Gen*/
	wire clk_50m;
	wire clk_100m;
	wire clk_100m_shift;
	wire locked;
	wire rst_n;

	/*sdram_model_plus*/
	wire [12:0] sdram_addr;
	wire [1:0] sdram_ban;
	wire [3:0] sdram_cmd;
	wire [15:0] sdram_dq;

	/*SDRAM_ARef*/
	wire aref_en;
	wire aref_req;
	wire [3:0] aref_cmd;
	wire [1:0] aref_ban;
	wire [12:0] aref_addr;
	wire aref_end;

	/*SDRAM_Write*/
	reg wr_en;
	reg [15:0] wr_data;
	wire [9:0] wr_burst_len;
	wire wr_end;
	wire [3:0] wr_cmd;
	wire [1:0] wr_ban;
	wire [12:0] wr_sdram_addr;
	wire wr_sdram_en;
	wire [15:0] wr_sdram_data;
	wire sdram_wr_ack;

	/*SDRAM_Read*/
	reg rd_en;
	wire rd_end;
	wire [3:0] rd_cmd;
	wire [1:0] rd_ban;
	wire [13:0] rd_sdram_addr;
	wire [15:0] rd_sdram_data;

	/*SDRAM_Arbit*/
	reg wr_req;
	reg rd_req;
	wire sdram_cke;
	wire sdram_cs_n;
	wire sdram_cas_n;
	wire sdram_ras_n;
	wire sdram_we_n;


	//defparam
	//重定义仿真模型中的相关参数
	defparam inst_sdram_model_plus.addr_bits = 13;
	defparam inst_sdram_model_plus.data_bits = 16;
	defparam inst_sdram_model_plus.col_bits = 9;
	defparam inst_sdram_model_plus.mem_sizes = 2*1024*1024;

	
	//系统时钟、复位
	initial begin
		sys_clk = 1'd0;
		sys_rst_n = 1'd0;
		#200
		sys_rst_n = 1'd1;
	end

	always #10 sys_clk <= !sys_clk;	//100MMHz

	//rst_n：复位信号
	assign rst_n = sys_rst_n && locked;

	/*wr_req：写使能*/
	always@(posedge clk_100m or negedge rst_n) begin
		if(~rst_n)
			wr_req <=  1'b1; 
		else if(wr_data == 16'd10)      
			wr_req <=  1'b0;
		else  begin
			wr_req <= wr_req;
		end
	end

	/*wr_data*/
	always @(posedge clk_100m or negedge rst_n) begin
		if(~rst_n) begin
			wr_data <= 16'd0;
		end else if(wr_data == 16'd10) begin
			wr_data <= 16'd0;
		end else if(sdram_wr_ack) begin
			wr_data <= wr_data + 16'd1;
		end else begin
			wr_data <= wr_data;
		end
	end

	/*rd_req:读数据使能*/
	always @(posedge clk_100m or negedge rst_n) begin
		if(~rst_n) begin
			rd_req <= 1'b0;
		end else if(wr_req == 1'b0) begin
			rd_req <= 1'b1;
		end else begin
			rd_req <= rd_req;
		end
	end

	Clk_Gen inst_Clk_Gen (
		.areset(!sys_rst_n),
		.inclk0(sys_clk),
		.c0(clk_50m),
		.c1(clk_100m),
		.c2(clk_100m_shift),
		.locked(locked));

	sdram_model_plus inst_sdram_model_plus (
		.Dq(sdram_dq), 
		.Addr(sdram_addr), 
		.Ba(sdram_ban), 
		.Clk(clk_100m_shift), 
		.Cke(sdram_cke), 
		.Cs_n(sdram_cs_n), 
		.Ras_n(sdram_ras_n), 
		.Cas_n(sdram_cas_n), 
		.We_n(sdram_we_n), 
		.Dqm(2'b00),
		.Debug(1'b1));

	SDRAM_Ctrl inst_SDRAM_Ctrl
		(
			.clk           (clk_100m),
			.rst_n         (rst_n),
			.wr_req        (wr_req),
			.wr_addr       (24'h000_000),
			.wr_data       (wr_data),
			.wr_burst_len  (10'd10),
			.rd_req        (rd_req),
			.rd_addr       (24'h000_000),
			.rd_burst_len  (10'd10),
			.sdram_cke     (sdram_cke),
			.sdram_cs_n    (sdram_cs_n),
			.sdram_cas_n   (sdram_cas_n),
			.sdram_ras_n   (sdram_ras_n),
			.sdram_we_n    (sdram_we_n),
			.sdram_ban     (sdram_ban),
			.sdram_addr    (sdram_addr),
			.rd_ack        (rd_ack),
			.rd_sdram_data (rd_sdram_data),
			.sdram_wr_ack  (sdram_wr_ack),
			.init_end      (init_end),
			.sdram_dq      (sdram_dq)
		);

	
endmodule
