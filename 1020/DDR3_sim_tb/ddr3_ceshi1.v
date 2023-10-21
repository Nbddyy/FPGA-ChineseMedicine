	`timescale 1ns / 1ps
	//////////////////////////////////////////////////////////////////////////////////
	// Company: 
	// Engineer: 
	// 
	// Create Date: 2021/02/04 18:49:59
	// Design Name: 
	// Module Name: ddr3_ceshi1
	// Project Name: 
	// Target Devices: 
	// Tool Versions: 
	// Description: 
	// 
	// Dependencies: 
	// 
	// Revision:
	// Revision 0.01 - File Created
	// Additional Comments:
	// 
	//////////////////////////////////////////////////////////////////////////////////


	module ddr3_ceshi1(

		inout [63:0] ddr3_dq,
		inout [7:0]  ddr3_dqs_n,
		inout [7:0]  ddr3_dqs_p,

		output [14:0] ddr3_addr,
		output [2:0] ddr3_ba,
		output       ddr3_ras_n,
		output       ddr3_cas_n,
		output       ddr3_we_n,
		output       ddr3_reset_n,
		output       ddr3_ck_p,
		output       ddr3_ck_n,
		output       ddr3_cke,
		output       ddr3_cs_n,
		output       [7:0]  ddr3_dm,
		output       ddr3_odt,
		
		output ui_clk,
		output ui_clk_sync_rst,
		
		input        clk100m_i,
		input [511:0] app_wdf_data		//通过tb文件传入随机数
	
		);
		
		
	/*clk_wiz_0 pins*/
	wire init_calib_complete ;
		
	wire clk_ref_i;
	wire sys_clk_i;
	wire clk_200m;
	
	assign clk_ref_i = clk_200m;
	assign sys_clk_i = clk_200m;
		
	wire locked ;

	/*mig_7series_0 pins*/
	parameter IDLE = 4'b0001;
	parameter WRITE = 4'b0010;
	parameter READ = 4'b0100;
	parameter END = 4'b1000;

	reg [3:0] ddr3_status;
	
	wire app_rdy;
	wire app_wdf_rdy;

	reg [2:0] app_cmd;
	wire app_en;
	wire app_wdf_end;
	wire app_wdf_wren;

	wire [511:0] app_rd_data;
	wire app_rd_data_valid;

	wire [28:0] app_addr;
	reg [28:0] wr_addr;
	reg [28:0] rd_addr;

	reg w_r_flag;	//用来进行判断
	always @(posedge ui_clk) begin
		if(ui_clk_sync_rst) begin
			w_r_flag <= 1'd1;
		end else begin
			case(ddr3_status)
				WRITE : w_r_flag <= (wr_addr == 8'd64) ? !w_r_flag : w_r_flag;
				READ : w_r_flag <= (rd_addr == 8'd64) ? !w_r_flag : w_r_flag;
				default : w_r_flag <= w_r_flag;
			endcase
		end
	end

	/*status transition logic*/
	always @(posedge ui_clk) begin
		if(ui_clk_sync_rst) begin
			ddr3_status <= IDLE;
		end else if(init_calib_complete) begin
			case(ddr3_status)
				IDLE : ddr3_status <= WRITE; 

				WRITE : ddr3_status <= (wr_addr == 8'd64) ? READ : ddr3_status;

				READ : ddr3_status <= (rd_addr == 8'd64) ? END : ddr3_status;

				END : ddr3_status <= IDLE;
				default : ddr3_status <= IDLE;
			endcase
		end else begin
			ddr3_status <= IDLE;
		end
	end

	/*wr_addr*/
	always @(posedge ui_clk) begin
		if(ui_clk_sync_rst) begin
			wr_addr <= 29'd0;
		end else if(wr_addr == 8'd64) begin
			wr_addr <= 29'd0;
		end else begin
			wr_addr <= ((ddr3_status == WRITE) && app_wdf_rdy && app_rdy) ? wr_addr + 29'd8 : wr_addr;
		end
	end

	/*rd_addr*/
	always @(posedge ui_clk) begin
		if(ui_clk_sync_rst) begin
			rd_addr <= 29'd0;
		end else if(rd_addr == 8'd64 && app_wdf_rdy && app_rdy) begin
			rd_addr <= 29'd0;
		end else begin
			rd_addr <= ((ddr3_status == READ) && app_rdy) ? rd_addr + 29'd8 : rd_addr;
		end
	end

	
	/*app_cmd*/
	always @(*) begin
		if(ui_clk_sync_rst) begin
			app_cmd <= 3'b001;
		end else begin
			case(ddr3_status)
				WRITE : app_cmd <= 3'b000;
				default : app_cmd <= 3'b001;
			endcase
		end
	end

	assign app_addr = (ddr3_status == WRITE) ? wr_addr : (ddr3_status == READ) ? rd_addr : 29'd0;

	/*app_en app_wdf_wren app_wdf_end*/
	assign app_en = ( ( (ddr3_status == WRITE && app_wdf_rdy) || ddr3_status == READ) && app_rdy) ? 1'd1 : 1'd0;

	assign app_wdf_wren = (ddr3_status == WRITE && app_wdf_rdy && app_rdy) ? 1'd1 : 1'd0;
	
	assign app_wdf_end = app_wdf_wren;



	/*************************************************/

	clk_wiz_0 clk_wiz_0
   (
    // Clock out ports
    .clk_out1(clk_200m),     // output clk_out1
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk100m_i));      // input clk_in1	
		
	mig_7series_0 u_mig_7series_0 (

    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [14:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [63:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [7:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [7:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
      
	.ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
    .ddr3_dm                        (ddr3_dm),  // output [7:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt

    // Application interface ports
    .app_addr                       (app_addr),  // input [28:0]		app_addr
    .app_cmd                        (app_cmd),  // input [2:0]		app_cmd
    .app_en                         (app_en),  // input				app_en
    .app_wdf_data                   (app_wdf_data),  // input [511:0]		app_wdf_data
    .app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren

    .app_rd_data                    (app_rd_data),  // output [511:0]		app_rd_data
    .app_rd_data_end                (),  // output			app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
    .app_rdy                        (app_rdy),  // output			app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy

    .app_sr_req                     (1'b0),  // input			app_sr_req
    .app_ref_req                    (1'b0),  // input			app_ref_req
    .app_zq_req                     (1'b0),  // input			app_zq_req

    .app_sr_active                  (),  // output			app_sr_active
    .app_ref_ack                    (),  // output			app_ref_ack
    .app_zq_ack                     (),  // output			app_zq_ack


    .ui_clk                         (ui_clk),  			// output			ui_clk : 输出给app操作的时钟
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst : 输出给app操作的复位, 高电平有效
    .app_wdf_mask                   (64'd0),  // input [63:0]		app_wdf_mask

    // System Clock Ports
    .sys_clk_i                       (sys_clk_i),
    // Reference Clock Ports
    .clk_ref_i                      (clk_ref_i),
    .sys_rst                        (locked) // input sys_rst
    );
	


		
		
	endmodule
