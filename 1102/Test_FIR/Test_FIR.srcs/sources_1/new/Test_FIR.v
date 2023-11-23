module Test_FIR(
	input board_clk_50mhz,
	input board_rst_n	
);
	
	wire signed [31:0] m_axis_data_tdata_0;
	wire signed [31:0] m_axis_data_tdata_1;

	reg signed [15:0] m_axis_data_tdata_sin_0;
	reg signed [15:0] m_axis_data_tdata_cos_0;
	reg signed [15:0] m_axis_data_tdata_sin_1;
	reg signed [15:0] m_axis_data_tdata_cos_1;

	wire signed [16:0] mix_1_3_mhz_sin;

	wire signed [39:0] m_axis_data_tdata;

	always @(posedge board_clk_50mhz or negedge board_rst_n) begin
		if (!board_rst_n) begin
			// reset
			m_axis_data_tdata_sin_0 <= 16'd0;
			m_axis_data_tdata_cos_0 <= 16'd0;
		end else begin
			m_axis_data_tdata_sin_0 <= m_axis_data_tdata_0[31:16];
			m_axis_data_tdata_cos_0 <= m_axis_data_tdata_0[15:0];
		end
	end

	always @(posedge board_clk_50mhz or negedge board_rst_n) begin
		if(~board_rst_n) begin
			m_axis_data_tdata_sin_1 = 16'd0;
			m_axis_data_tdata_cos_1 = 16'd0;
		end else begin
			m_axis_data_tdata_sin_1 = m_axis_data_tdata_1[31:16];
			m_axis_data_tdata_cos_1 = m_axis_data_tdata_1[15:0];
		end
	end


	dds_compiler_0 inst_dds_compiler_0 (	//生成1MHz
  		.aclk(board_clk_50mhz),                                  // input wire aclk
  		.s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
  		.s_axis_config_tdata(32'd85899346),    // input wire [31 : 0] s_axis_config_tdata
  		.m_axis_data_tvalid(m_axis_data_tvalid),      // output wire m_axis_data_tvalid
  		.m_axis_data_tdata(m_axis_data_tdata_0)        // output wire [31 : 0] m_axis_data_tdata
	);

	dds_compiler_0 inst_dds_compiler_1 (	//生成3MHz
  		.aclk(board_clk_50mhz),                                  // input wire aclk
  		.s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
  		.s_axis_config_tdata(32'd257698038),    // input wire [31 : 0] s_axis_config_tdata
  		.m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
  		.m_axis_data_tdata(m_axis_data_tdata_1)        // output wire [31 : 0] m_axis_data_tdata
	);


	c_addsub_0 inst_c_addsub_0 (
		.A(m_axis_data_tdata_sin_0),      // input wire [15 : 0] A
		.B(m_axis_data_tdata_sin_1),      // input wire [15 : 0] B
		.CLK(board_clk_50mhz),  // input wire CLK
		.S(mix_1_3_mhz_sin)      // output wire [16 : 0] S
	);

	fir_compiler_0 inst_fir_compiler_0 (
		.aclk(board_clk_50mhz),                              // input wire aclk
		.s_axis_data_tvalid(1'd1),  // input wire s_axis_data_tvalid
		.s_axis_data_tready(),  // output wire s_axis_data_tready
		.s_axis_data_tdata(mix_1_3_mhz_sin[16:1]),    // input wire [15 : 0] s_axis_data_tdata
		.m_axis_data_tvalid(),  // output wire m_axis_data_tvalid
		.m_axis_data_tdata(m_axis_data_tdata)    // output wire [39 : 0] m_axis_data_tdata
	);

endmodule
