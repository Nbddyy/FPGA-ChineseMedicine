// This is a simple example.
// You can make a your own header file and set its path to settings.
// (Preferences > Package Settings > Verilog Gadget > Settings - User)
//
//		"header": "Packages/Verilog Gadget/template/verilog_header.v"
//
// -----------------------------------------------------------------------------
// Copyright (c) 2014-2023 All rights reserved
// -----------------------------------------------------------------------------
// Author : Nbddyy qq1877117587@outlook.com
// File   : ADC_DATA_XDH.v
// Create : 2023-11-02 15:13:45
// Revise : 2023-11-07 20:31:41
// Editor : sublime text4, tab size (4)
// Descri : 
// -----------------------------------------------------------------------------
module ADC_DATA_XDH (
	input adc_clk,    		//外部输出的ADC时钟信号 38.4mhz
	input wire main_clk,	//230.4mhz

	input rst_n,  // Asynchronous reset active low
	
	input wire [15:0] adc_data,

	output reg signed [15:0] subband_ch1_data_real,
	output reg signed [15:0] subband_ch1_data_imaginary,
	output reg signed [15:0] subband_ch2_data_real,
	output reg signed [15:0] subband_ch2_data_imaginary,
	output reg signed [15:0] subband_ch3_data_real,
	output reg signed [15:0] subband_ch3_data_imaginary,
	output reg signed [15:0] subband_ch4_data_real,
	output reg signed [15:0] subband_ch4_data_imaginary,
	output reg signed [15:0] subband_ch5_data_real,
	output reg signed [15:0] subband_ch5_data_imaginary,
	output reg signed [15:0] subband_ch6_data_real,
	output reg signed [15:0] subband_ch6_data_imaginary,
	output reg signed [15:0] subband_ch7_data_real,
	output reg signed [15:0] subband_ch7_data_imaginary,
	output reg signed [15:0] subband_ch8_data_real,
	output reg signed [15:0] subband_ch8_data_imaginary,
	output reg signed [15:0] subband_ch9_data_real,
	output reg signed [15:0] subband_ch9_data_imaginary,
	output reg signed [15:0] subband_ch10_data_real,
	output reg signed [15:0] subband_ch10_data_imaginary,
	output reg signed [15:0] subband_ch11_data_real,
	output reg signed [15:0] subband_ch11_data_imaginary,
	output reg signed [15:0] subband_ch12_data_real,
	output reg signed [15:0] subband_ch12_data_imaginary,
	output reg signed [15:0] subband_ch13_data_real,
	output reg signed [15:0] subband_ch13_data_imaginary,
	output reg signed [15:0] subband_ch14_data_real,
	output reg signed [15:0] subband_ch14_data_imaginary,
	output reg signed [15:0] subband_ch15_data_real,
	output reg signed [15:0] subband_ch15_data_imaginary,
	output reg signed [15:0] subband_ch16_data_real,
	output reg signed [15:0] subband_ch16_data_imaginary,
	output reg signed [15:0] subband_ch17_data_real,
	output reg signed [15:0] subband_ch17_data_imaginary,
	output reg signed [15:0] subband_ch18_data_real,
	output reg signed [15:0] subband_ch18_data_imaginary,
	output reg signed [15:0] subband_ch19_data_real,
	output reg signed [15:0] subband_ch19_data_imaginary,
	output reg signed [15:0] subband_ch20_data_real,
	output reg signed [15:0] subband_ch20_data_imaginary,
	output reg signed [15:0] subband_ch21_data_real,
	output reg signed [15:0] subband_ch21_data_imaginary,
	output reg signed [15:0] subband_ch22_data_real,
	output reg signed [15:0] subband_ch22_data_imaginary,
	output reg signed [15:0] subband_ch23_data_real,
	output reg signed [15:0] subband_ch23_data_imaginary,
	output reg signed [15:0] subband_ch24_data_real,
	output reg signed [15:0] subband_ch24_data_imaginary,
	output reg signed [15:0] subband_ch25_data_real,
	output reg signed [15:0] subband_ch25_data_imaginary,
	output reg signed [15:0] subband_ch26_data_real,
	output reg signed [15:0] subband_ch26_data_imaginary,
	output reg signed [15:0] subband_ch27_data_real,
	output reg signed [15:0] subband_ch27_data_imaginary,
	output reg signed [15:0] subband_ch28_data_real,
	output reg signed [15:0] subband_ch28_data_imaginary,
	output reg signed [15:0] subband_ch29_data_real,
	output reg signed [15:0] subband_ch29_data_imaginary,
	output reg signed [15:0] subband_ch30_data_real,
	output reg signed [15:0] subband_ch30_data_imaginary,

	output reg subband_dataout_valid
);

	wire [31:0] m_axis_data_tdata;
	reg signed [15:0] m_axis_data_tdata_sin;
	reg signed [15:0] m_axis_data_tdata_cos;

	wire signed [31:0] spectrum_shift_righ_1_real;
	wire signed [31:0] spectrum_shift_righ_1_imaginary;

	// wire signed [32:0] spectrum_shift_righ_1;

	/*检测adc_clk上升沿*/
	reg adc_clk_r1;
	reg adc_clk_r2;
	reg adc_clk_rise_edge;

	always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			adc_clk_r1 <= 1'd0;
			adc_clk_r2 <= 1'd0;
			adc_clk_rise_edge <= 1'd0;
		end else begin
			adc_clk_r1 <= adc_clk;
			adc_clk_r2 <= adc_clk_r1;
			adc_clk_rise_edge <= adc_clk_r1 && (!adc_clk_r2);
		end
	end

	/***************************************************************/
	/*
	将(-11.8,-6.8,-1.8)频谱搬移至(-7,-2,3)
	F(w-w0) = F(w)*cos(wt) + [F(w)*sin(wt)]j 	j在这里表示虚部
	*/

	/*生成4.8MHz的正弦波和余弦波*/
	dds_compiler_sin_cos_4M8 inst_dds_compiler_sin_cos_4M8 (
		.aclk(adc_clk),                                  // input wire aclk
		.s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
		.s_axis_config_tdata(32'd536_870_912),    // input wire [31 : 0] s_axis_config_tdata
		.m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
		.m_axis_data_tdata(m_axis_data_tdata)        // output wire [31 : 0] m_axis_data_tdata
	);

	always @(posedge adc_clk or negedge rst_n) begin
		if(~rst_n) begin
			m_axis_data_tdata_sin <= 16'd0;
			m_axis_data_tdata_cos <= 16'd0;
		end else begin
			m_axis_data_tdata_sin <= m_axis_data_tdata[31:16];
			m_axis_data_tdata_cos <= m_axis_data_tdata[15:0];
		end
	end

	/*实现频谱右移4.8MHz, 获取频谱右移后的实部*/
	mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_1 (
		.CLK(adc_clk),  // input wire CLK
		.A(adc_data),      // input wire [15 : 0] A
		.B(m_axis_data_tdata_cos),      // input wire [15 : 0] B
		.P(spectrum_shift_righ_1_real)      // output wire [31 : 0] P
	);

	/*实现频谱右移4.8MHz, 获取频谱右移后的虚部*/
	mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_2 (
		.CLK(adc_clk),  // input wire CLK
		.A(adc_data),      // input wire [15 : 0] A
		.B(m_axis_data_tdata_sin),      // input wire [15 : 0] B
		.P(spectrum_shift_righ_1_imaginary)      // output wire [31 : 0] P
	);

	// /*将实部和虚部相加得到频谱右移后的结果*/
	// addsub_real_imaginary isnt_addsub_real_imaginary (
	//  	.A(spectrum_shift_righ_1_real),      // input wire [31 : 0] A
	//  	.B(spectrum_shift_righ_1_imaginary),      // input wire [31 : 0] B
	//  	.CLK(adc_clk),  // input wire CLK,
	//		.ADD(1'd1),		//input wire ADD
	//  	.S(spectrum_shift_righ_1)      // output wire [32 : 0] S
	// );

	/*************************************************/
	/*频谱搬移的结果进行位宽截取*/
	reg signed [15:0] spectrum_shift_righ_1_real_intercept;
	reg signed [15:0] spectrum_shift_righ_1_imaginary_intercept;

	wire [7:0] vio_intercept_select_1;

	vio_real_imaginary_intercept inst_vio_real_imaginary_intercept_1 (
		.clk(adc_clk),                // input wire clk
		.probe_in0(vio_intercept_select_1),    // input wire [7 : 0] probe_in0
		.probe_out0(vio_intercept_select_1)  // output wire [7 : 0] probe_out0
	);

	always @(posedge adc_clk or negedge rst_n) begin
		if(~rst_n) begin
			spectrum_shift_righ_1_real_intercept <= 16'd0;
			spectrum_shift_righ_1_imaginary_intercept <= 16'd0;
		end else begin
			case(vio_intercept_select_1)
				8'd0 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[30-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[30-:16];
				end

				8'd1 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[30-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[30-:16];
				end

				8'd2 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[29-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[29-:16];
				end

				8'd3 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[28-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[28-:16];
				end

				8'd4 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[27-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[27-:16];
				end

				8'd5 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[26-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[26-:16];
				end

				8'd6 : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[25-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[25-:16];
				end

				default : begin
					spectrum_shift_righ_1_real_intercept <= spectrum_shift_righ_1_real[30-:16];
					spectrum_shift_righ_1_imaginary_intercept <= spectrum_shift_righ_1_imaginary[30-:16];
				end
			endcase
		end
	end

	/***************************************************************/
	/*将各个信道中心频点搬移至0位置所需的频率关键字存储在数组中*/
	wire [31:0] fword [0:29];

	//DUC
	assign fword[0] = 32'd764295396; 		
	assign fword[1] = 32'd727012693; 		
	assign fword[2] = 32'd689729991; 		
	assign fword[3] = 32'd652447289; 		
	assign fword[4] = 32'd615164587; 		
	assign fword[5] = 32'd577881884; 		
	assign fword[6] = 32'd540599182; 		
	assign fword[7] = 32'd503316480; 		
	assign fword[8] = 32'd466033778; 		
	assign fword[9] = 32'd428751076; 		
	assign fword[10] = 32'd391468373; 		
	assign fword[11] = 32'd354185671; 		
	assign fword[12] = 32'd316902969; 		
	assign fword[13] = 32'd279620267; 		
	assign fword[14] = 32'd242337564; 		
	assign fword[15] = 32'd205054862; 		
	assign fword[16] = 32'd167772160; 		
	assign fword[17] = 32'd130489458; 		
	assign fword[18] = 32'd93206756; 		
	assign fword[19] = 32'd55924053; 		
	assign fword[20] = 32'd18641351;

	//DDC 		
	assign fword[21] = 32'd18641351; 		
	assign fword[22] = 32'd55924053; 		
	assign fword[23] = 32'd93206756; 		
	assign fword[24] = 32'd130489458; 		
	assign fword[25] = 32'd167772160; 		
	assign fword[26] = 32'd205054862; 		
	assign fword[27] = 32'd242337564; 		
	assign fword[28] = 32'd279620267; 	
	assign fword[29] = 32'd316902969;	
	
	/*存放各个信道频谱搬移的作用的正弦波和余弦波*/
	wire signed [31:0] spectrum_shift [0:29];

	wire signed [31:0] spectrum_shift_righ_2_real_ac [0:29];
	wire signed [31:0] spectrum_shift_righ_2_real_bd [0:29];
	wire signed [31:0] spectrum_shift_righ_2_imaginary_bc [0:29];
	wire signed [31:0] spectrum_shift_righ_2_imaginary_ad [0:29];

	wire signed [32:0] spectrum_shift_righ_2_real_duc [0:29];
	wire signed [32:0] spectrum_shift_righ_2_imaginary_duc [0:29]; 
	wire signed [32:0] spectrum_shift_righ_2_real_ddc [0:29];
	wire signed [32:0] spectrum_shift_righ_2_imaginary_ddc [0:29]; 

	reg signed [31:0] spectrum_shift_righ_2_real [0:29];
	reg signed [31:0] spectrum_shift_righ_2_imaginary [0:29];

	reg signed [15:0] spectrum_shift_righ_2_real_intercept [0:29];
	reg signed [15:0] spectrum_shift_righ_2_imaginary_intercept [0:29];

	wire m_axis_data_tvalid_real [0:29];
	wire m_axis_data_tvalid_imaginary [0:29];

	wire [39:0] m_axis_data_tdata_real [0:29];
	wire [39:0] m_axis_data_tdata_imaginary [0:29];

	reg [15:0] m_axis_data_tdata_real_intercept [0:29];
	reg [15:0] m_axis_data_tdata_imaginary_intercept [0:29];

	wire [7:0] vio_intercept_select_2;
	wire [7:0] vio_intercept_select_3;

	vio_real_imaginary_intercept inst_vio_real_imaginary_intercept_2 (
		.clk(adc_clk),                // input wire clk
		.probe_in0(vio_intercept_select_2),    // input wire [7 : 0] probe_in0
		.probe_out0(vio_intercept_select_2)  // output wire [7 : 0] probe_out0
	);

	vio_real_imaginary_intercept inst_vio_real_imaginary_intercept_3 (
		.clk(adc_clk),                // input wire clk
		.probe_in0(vio_intercept_select_3),    // input wire [7 : 0] probe_in0
		.probe_out0(vio_intercept_select_3)  // output wire [7 : 0] probe_out0
	);

	/*划分成30等分信道，分别将其信道中心频点移至0，然后过滤出该信道所在频带*/
	genvar i;

	generate for(i = 0; i < 30; i = i + 1) begin : generate_30_dds_compiler_sin_cos_4M8

		/*生成各个信道搬移所需的sin(w0t)和cos(w0t)*/
		dds_compiler_sin_cos_4M8 inst_dds_compiler_sin_cos (
			.aclk(adc_clk),                                  // input wire aclk
			.s_axis_config_tvalid(1'd1),  // input wire s_axis_config_tvalid
			.s_axis_config_tdata(fword[i]),    // input wire [31 : 0] s_axis_config_tdata
			.m_axis_data_tvalid(),      // output wire m_axis_data_tvalid
			.m_axis_data_tdata(spectrum_shift[i])        // output wire [31 : 0] m_axis_data_tdata
		);


		/*信道中心频点在0左边，则频谱右移
		(spectrum_shift_righ_1_real_intercept + spectrum_shift_righ_1_imaginary_intercept) * (spectrum_shift[i][15:0] + spectrum_shift[i][31:16])
		real part : spectrum_shift_righ_1_real_intercept * spectrum_shift[i][15:0] - spectrum_shift_righ_1_imaginary_intercept * spectrum_shift[i][31:16]
		imaginary part : spectrum_shift_righ_1_real_intercept * spectrum_shift[i][31:16] + spectrum_shift_righ_1_imaginary_intercept * spectrum_shift[i][15:0]
		*/


		/*信道中心频点在0右边，则频谱左移
		(spectrum_shift_righ_1_real_intercept + spectrum_shift_righ_1_imaginary_intercept) * (spectrum_shift[i][15:0] - spectrum_shift[i][31:16])
		real part : spectrum_shift_righ_1_real_intercept * spectrum_shift[i][15:0] + spectrum_shift_righ_1_imaginary_intercept * spectrum_shift[i][31:16]
		imaginary part : spectrum_shift_righ_1_imaginary_intercept * spectrum_shift[i][15:0] - spectrum_shift_righ_1_real_intercept * spectrum_shift[i][31:16]
		*/

		/*************************************************************/
		/*将三十组ac、bd、bc、ad先求解出来*/

		/*ac*/
		mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_3 (
			.CLK(adc_clk),  // input wire CLK
			.A(spectrum_shift_righ_1_real_intercept),      // input wire [15 : 0] A
			.B(spectrum_shift[i][15:0]),      // input wire [15 : 0] B
			.P(spectrum_shift_righ_2_real_ac[i])      // output wire [31 : 0] P
		);

		/*bd*/
		mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_4 (
			.CLK(adc_clk),  // input wire CLK
			.A(spectrum_shift_righ_1_imaginary_intercept),      // input wire [15 : 0] A
			.B(spectrum_shift[i][31:16]),      // input wire [15 : 0] B
			.P(spectrum_shift_righ_2_real_bd[i])      // output wire [31 : 0] P
		);

		/*bc*/
		mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_5 (
			.CLK(adc_clk),  // input wire CLK
			.A(spectrum_shift_righ_1_imaginary_intercept),      // input wire [15 : 0] A
			.B(spectrum_shift[i][15:0]),      // input wire [15 : 0] B
			.P(spectrum_shift_righ_2_imaginary_bc[i])      // output wire [31 : 0] P
		);

		/*ad*/
		mult_gen_spectrum_center_2m_band_width_10m inst_mult_gen_spectrum_center_2m_band_width_10m_6 (
			.CLK(adc_clk),  // input wire CLK
			.A(spectrum_shift_righ_1_real_intercept),      // input wire [15 : 0] A
			.B(spectrum_shift[i][31:16]),      // input wire [15 : 0] B
			.P(spectrum_shift_righ_2_imaginary_ad[i])      // output wire [31 : 0] P
		);


		/*****************频谱右移*****************/
		/*real part : ac - bd*/
		addsub_real_imaginary inst_addsub_real_imaginary_2_real_duc (
			.A(spectrum_shift_righ_2_real_ac[i]),      // input wire [31 : 0] A
			.B(spectrum_shift_righ_2_real_bd[i]),      // input wire [31 : 0] B
			.CLK(adc_clk),  // input wire CLK
			.ADD(1'd0),  // input wire ADD
			.S(spectrum_shift_righ_2_real_duc[i])      // output wire [32 : 0] S
		);

		/*imaginary part : ad + bc*/
		addsub_real_imaginary inst_addsub_real_imaginary_2_imaginary_duc (
			.A(spectrum_shift_righ_2_imaginary_ad[i]),      // input wire [31 : 0] A
			.B(spectrum_shift_righ_2_imaginary_bc[i]),      // input wire [31 : 0] B
			.CLK(adc_clk),  // input wire CLK
			.ADD(1'd1),  // input wire ADD
			.S(spectrum_shift_righ_2_imaginary_duc[i])      // output wire [32 : 0] S
		);

		


		/*****************频谱左移*****************/
		/*real part : ac + bd*/
		addsub_real_imaginary inst_addsub_real_imaginary_2_real_ddc (
			.A(spectrum_shift_righ_2_real_ac[i]),      // input wire [31 : 0] A
			.B(spectrum_shift_righ_2_real_bd[i]),      // input wire [31 : 0] B
			.CLK(adc_clk),  // input wire CLK
			.ADD(1'd1),  // input wire ADD
			.S(spectrum_shift_righ_2_real_ddc[i])      // output wire [32 : 0] S
		);

		/*imaginary part : bc - ad*/
		addsub_real_imaginary inst_addsub_real_imaginary_2_imaginary_ddc (
			.A(spectrum_shift_righ_2_imaginary_bc[i]),      // input wire [31 : 0] A
			.B(spectrum_shift_righ_2_imaginary_ad[i]),      // input wire [31 : 0] B
			.CLK(adc_clk),  // input wire CLK
			.ADD(1'd0),  // input wire ADD
			.S(spectrum_shift_righ_2_imaginary_ddc[i])      // output wire [32 : 0] S
		);


		/*将各个信道的实部虚部存放在一起*/
		always @(posedge adc_clk or negedge rst_n) begin
			if(~rst_n) begin
				spectrum_shift_righ_2_real[i] <= 32'd0;
				spectrum_shift_righ_2_imaginary[i] <= 32'd0;
			end else if(i <= 21) begin
				spectrum_shift_righ_2_real[i] <= spectrum_shift_righ_2_real_duc[i];
				spectrum_shift_righ_2_imaginary[i] <= spectrum_shift_righ_2_imaginary_duc[i];
			end else begin
				spectrum_shift_righ_2_real[i] <= spectrum_shift_righ_2_real_ddc[i];
				spectrum_shift_righ_2_imaginary[i] <= spectrum_shift_righ_2_imaginary_ddc[i];
			end
		end

		/*调用VIO核截取各个信道*/
		always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			spectrum_shift_righ_2_real_intercept[i] <= 16'd0;
			spectrum_shift_righ_2_imaginary_intercept[i] <= 16'd0;
		end else begin
			case(vio_intercept_select_2)
				8'd0 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][30-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][30-:16];
				end

				8'd1 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][30-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][30-:16];
				end

				8'd2 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][29-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][29-:16];
				end

				8'd3 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][28-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][28-:16];
				end

				8'd4 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][27-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][27-:16];
				end

				8'd5 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][26-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][26-:16];
				end

				8'd6 : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][25-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][25-:16];
				end

				default : begin
					spectrum_shift_righ_2_real_intercept[i] <= spectrum_shift_righ_2_real[i][30-:16];
					spectrum_shift_righ_2_imaginary_intercept[i] <= spectrum_shift_righ_2_imaginary[i][30-:16];
				end
			endcase
		end
	end


		/*****************实部虚部求解*****************/
		fir_compiler_0 inst_fir_compiler_0_real_1 (
			.aclk(main_clk),                              // input wire aclk
			.s_axis_data_tvalid(adc_clk_rise_edge),  // input wire s_axis_data_tvalid;	ADC采样频率是38.4MHz，fir滤波器核工作频率是230.4MHz，则每隔六次采样一回
			.s_axis_data_tready(),  // output wire s_axis_data_tready
			.s_axis_data_tdata(spectrum_shift_righ_2_real_intercept[i]),    // input wire [15 : 0] s_axis_data_tdata
			.m_axis_data_tvalid(m_axis_data_tvalid_real[i]),  // output wire m_axis_data_tvalid
			.m_axis_data_tdata(m_axis_data_tdata_real[i])    // output wire [39 : 0] m_axis_data_tdata
		);

		fir_compiler_0 inst_fir_compiler_0_real_2 (
			.aclk(main_clk),                              // input wire aclk
			.s_axis_data_tvalid(adc_clk_rise_edge),  // input wire s_axis_data_tvalid;	ADC采样频率是38.4MHz，fir滤波器核工作频率是230.4MHz，则每隔六次采样一回
			.s_axis_data_tready(),  // output wire s_axis_data_tready
			.s_axis_data_tdata(spectrum_shift_righ_2_imaginary_intercept[i]),    // input wire [15 : 0] s_axis_data_tdata
			.m_axis_data_tvalid(m_axis_data_tvalid_imaginary[i]),  // output wire m_axis_data_tvalid
			.m_axis_data_tdata(m_axis_data_tdata_imaginary[i])    // output wire [39 : 0] m_axis_data_tdata
		);

		/*调用VIO核截取各个信道*/
		always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			m_axis_data_tdata_real_intercept[i] <= 16'd0;
			m_axis_data_tdata_imaginary_intercept[i] <= 16'd0;
		end else begin
			case(vio_intercept_select_2)
				8'd0 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][39-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][39-:16];
				end

				8'd1 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][38-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][38-:16];
				end

				8'd2 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][37-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][37-:16];
				end

				8'd3 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][36-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][36-:16];
				end

				8'd4 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][35-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][35-:16];
				end

				8'd5 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][34-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][34-:16];
				end

				8'd6 : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][33-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][33-:16];
				end

				default : begin
					m_axis_data_tdata_real_intercept[i] <= m_axis_data_tdata_real[i][38-:16];
					m_axis_data_tdata_imaginary_intercept[i] <= m_axis_data_tdata_imaginary[i][38-:16];
				end
			endcase
		end
	end

	end endgenerate

	/***************************************************************/
	always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			subband_ch1_data_real <= 16'd0;
			subband_ch1_data_imaginary <= 16'd0;
			subband_ch2_data_real <= 16'd0;
			subband_ch2_data_imaginary <= 16'd0;
			subband_ch3_data_real <= 16'd0;
			subband_ch3_data_imaginary <= 16'd0;
			subband_ch4_data_real <= 16'd0;
			subband_ch4_data_imaginary <= 16'd0;
			subband_ch5_data_real <= 16'd0;
			subband_ch5_data_imaginary <= 16'd0;
			subband_ch6_data_real <= 16'd0;
			subband_ch6_data_imaginary <= 16'd0;
			subband_ch7_data_real <= 16'd0;
			subband_ch7_data_imaginary <= 16'd0;
			subband_ch8_data_real <= 16'd0;
			subband_ch8_data_imaginary <= 16'd0;
			subband_ch9_data_real <= 16'd0;
			subband_ch9_data_imaginary <= 16'd0;
			subband_ch10_data_real <= 16'd0;
			subband_ch10_data_imaginary <= 16'd0;
			subband_ch11_data_real <= 16'd0;
			subband_ch11_data_imaginary <= 16'd0;
			subband_ch12_data_real <= 16'd0;
			subband_ch12_data_imaginary <= 16'd0;
			subband_ch13_data_real <= 16'd0;
			subband_ch13_data_imaginary <= 16'd0;
			subband_ch14_data_real <= 16'd0;
			subband_ch14_data_imaginary <= 16'd0;
			subband_ch15_data_real <= 16'd0;
			subband_ch15_data_imaginary <= 16'd0;
			subband_ch16_data_real <= 16'd0;
			subband_ch16_data_imaginary <= 16'd0;
			subband_ch17_data_real <= 16'd0;
			subband_ch17_data_imaginary <= 16'd0;
			subband_ch18_data_real <= 16'd0;
			subband_ch18_data_imaginary <= 16'd0;
			subband_ch19_data_real <= 16'd0;
			subband_ch19_data_imaginary <= 16'd0;
			subband_ch20_data_real <= 16'd0;
			subband_ch20_data_imaginary <= 16'd0;
			subband_ch21_data_real <= 16'd0;
			subband_ch21_data_imaginary <= 16'd0;
			subband_ch22_data_real <= 16'd0;
			subband_ch22_data_imaginary <= 16'd0;
			subband_ch23_data_real <= 16'd0;
			subband_ch23_data_imaginary <= 16'd0;
			subband_ch24_data_real <= 16'd0;
			subband_ch24_data_imaginary <= 16'd0;
			subband_ch25_data_real <= 16'd0;
			subband_ch25_data_imaginary <= 16'd0;
			subband_ch26_data_real <= 16'd0;
			subband_ch26_data_imaginary <= 16'd0;
			subband_ch27_data_real <= 16'd0;
			subband_ch27_data_imaginary <= 16'd0;
			subband_ch28_data_real <= 16'd0;
			subband_ch28_data_imaginary <= 16'd0;
			subband_ch29_data_real <= 16'd0;
			subband_ch29_data_imaginary <= 16'd0;
			subband_ch30_data_real <= 16'd0;
			subband_ch30_data_imaginary <= 16'd0;
		end else begin
			subband_ch1_data_real <= m_axis_data_tdata_real_intercept[0];
			subband_ch2_data_real <= m_axis_data_tdata_real_intercept[1];
			subband_ch3_data_real <= m_axis_data_tdata_real_intercept[2];
			subband_ch4_data_real <= m_axis_data_tdata_real_intercept[3];
			subband_ch5_data_real <= m_axis_data_tdata_real_intercept[4];
			subband_ch6_data_real <= m_axis_data_tdata_real_intercept[5];
			subband_ch7_data_real <= m_axis_data_tdata_real_intercept[6];
			subband_ch8_data_real <= m_axis_data_tdata_real_intercept[7];
			subband_ch9_data_real <= m_axis_data_tdata_real_intercept[8];
			subband_ch10_data_real <= m_axis_data_tdata_real_intercept[9];
			subband_ch11_data_real <= m_axis_data_tdata_real_intercept[10];
			subband_ch12_data_real <= m_axis_data_tdata_real_intercept[11];
			subband_ch13_data_real <= m_axis_data_tdata_real_intercept[12];
			subband_ch14_data_real <= m_axis_data_tdata_real_intercept[13];
			subband_ch15_data_real <= m_axis_data_tdata_real_intercept[14];
			subband_ch16_data_real <= m_axis_data_tdata_real_intercept[15];
			subband_ch17_data_real <= m_axis_data_tdata_real_intercept[16];
			subband_ch18_data_real <= m_axis_data_tdata_real_intercept[17];
			subband_ch19_data_real <= m_axis_data_tdata_real_intercept[18];
			subband_ch20_data_real <= m_axis_data_tdata_real_intercept[19];
			subband_ch21_data_real <= m_axis_data_tdata_real_intercept[20];
			subband_ch22_data_real <= m_axis_data_tdata_real_intercept[21];
			subband_ch23_data_real <= m_axis_data_tdata_real_intercept[22];
			subband_ch24_data_real <= m_axis_data_tdata_real_intercept[23];
			subband_ch25_data_real <= m_axis_data_tdata_real_intercept[24];
			subband_ch26_data_real <= m_axis_data_tdata_real_intercept[25];
			subband_ch27_data_real <= m_axis_data_tdata_real_intercept[26];
			subband_ch28_data_real <= m_axis_data_tdata_real_intercept[27];
			subband_ch29_data_real <= m_axis_data_tdata_real_intercept[28];
			subband_ch30_data_real <= m_axis_data_tdata_real_intercept[29];

			subband_ch1_data_imaginary <= m_axis_data_tdata_imaginary_intercept[0]; 
			subband_ch2_data_imaginary <= m_axis_data_tdata_imaginary_intercept[1]; 
			subband_ch3_data_imaginary <= m_axis_data_tdata_imaginary_intercept[2]; 
			subband_ch4_data_imaginary <= m_axis_data_tdata_imaginary_intercept[3]; 		
			subband_ch5_data_imaginary <= m_axis_data_tdata_imaginary_intercept[4]; 			
			subband_ch6_data_imaginary <= m_axis_data_tdata_imaginary_intercept[5]; 			
			subband_ch7_data_imaginary <= m_axis_data_tdata_imaginary_intercept[6]; 			
			subband_ch8_data_imaginary <= m_axis_data_tdata_imaginary_intercept[7]; 			
			subband_ch9_data_imaginary <= m_axis_data_tdata_imaginary_intercept[8]; 			
			subband_ch10_data_imaginary <= m_axis_data_tdata_imaginary_intercept[9]; 			
			subband_ch11_data_imaginary <= m_axis_data_tdata_imaginary_intercept[10]; 			
			subband_ch12_data_imaginary <= m_axis_data_tdata_imaginary_intercept[11]; 			
			subband_ch13_data_imaginary <= m_axis_data_tdata_imaginary_intercept[12]; 			
			subband_ch14_data_imaginary <= m_axis_data_tdata_imaginary_intercept[13]; 			
			subband_ch15_data_imaginary <= m_axis_data_tdata_imaginary_intercept[14]; 			
			subband_ch16_data_imaginary <= m_axis_data_tdata_imaginary_intercept[15]; 			
			subband_ch17_data_imaginary <= m_axis_data_tdata_imaginary_intercept[16]; 		
			subband_ch18_data_imaginary <= m_axis_data_tdata_imaginary_intercept[17]; 		
			subband_ch19_data_imaginary <= m_axis_data_tdata_imaginary_intercept[18]; 	
			subband_ch20_data_imaginary <= m_axis_data_tdata_imaginary_intercept[19]; 
			subband_ch21_data_imaginary <= m_axis_data_tdata_imaginary_intercept[20]; 
			subband_ch22_data_imaginary <= m_axis_data_tdata_imaginary_intercept[21]; 
			subband_ch23_data_imaginary <= m_axis_data_tdata_imaginary_intercept[22]; 
			subband_ch24_data_imaginary <= m_axis_data_tdata_imaginary_intercept[23]; 
			subband_ch25_data_imaginary <= m_axis_data_tdata_imaginary_intercept[24]; 
			subband_ch26_data_imaginary <= m_axis_data_tdata_imaginary_intercept[25]; 
			subband_ch27_data_imaginary <= m_axis_data_tdata_imaginary_intercept[26]; 
			subband_ch28_data_imaginary <= m_axis_data_tdata_imaginary_intercept[27]; 
			subband_ch29_data_imaginary <= m_axis_data_tdata_imaginary_intercept[28]; 
			subband_ch30_data_imaginary <= m_axis_data_tdata_imaginary_intercept[29]; 
		end
	end

	reg m_axis_data_tvalid_real_clap_1;
	reg m_axis_data_tvalid_real_clap_2;

	/*需要输出valid打两拍处理，之前的rise_edge做了两拍处理*/
	always @(posedge main_clk or negedge rst_n) begin
		if(~rst_n) begin
			m_axis_data_tvalid_real_clap_1 <= 1'd0;
			m_axis_data_tvalid_real_clap_2 <= 1'd0;
			subband_dataout_valid <= 1'd0;
 		end else begin
			m_axis_data_tvalid_real_clap_1 <= m_axis_data_tvalid_real[1];	//数据都是同一个CLK输出的, 信道并行输出
			m_axis_data_tvalid_real_clap_2 <= m_axis_data_tvalid_real_clap_1;
			subband_dataout_valid <= m_axis_data_tvalid_real_clap_2;
		end
	end


endmodule