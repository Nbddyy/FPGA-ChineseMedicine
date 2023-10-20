module adc_interface

(
    input               clk_200mhz,
    input               adc_clk_p   ,
    input               adc_clk_n   ,
    input   [7:0]       adc_data_p  ,
    input   [7:0]       adc_data_n  ,
	input               rstn_125m     ,
	
	input             rst_n,

    
    output     wire         o_adc_clk     ,
    output    wire   [15:0]  o_adc_data    ,
	output              o_adc_vild,
	
	input wire   lvds_rclk   //接收ADC的差分时钟信号已经经过转单端处理之后的。

);


//先将接收的所有差分的数据线全部转成单端信号

	wire [0:0] lvds_rxd[0:7];

	genvar i;
	generate
	for (i=0; i<8; i=i+1) begin : DATA_TO_SIG

		IBUFDS #(
			.DIFF_TERM("TRUE"),       // Differential Termination
			.IBUF_LOW_PWR("FALSE"),     // Low power="TRUE", Highest performance="FALSE" 
			.IOSTANDARD("DEFAULT")     // Specify the input I/O standard
		) IBUFDS_inst (
			.O(lvds_rxd[i] ),  // Buffer output
			.I(adc_data_p[i] ),  // Diff_p buffer input (connect directly to top-level port)
			.IB(adc_data_n[i]) // Diff_n buffer input (connect directly to top-level port)
		);

	end 
	endgenerate 



//调用 IDELAY IDELAY_CTRL 原语对数据线调整延时


	wire RDY;
	(* IODELAY_GROUP="LVDS_RCLK_GROUP"*)
	IDELAYCTRL IDELAYCTRL_inst(
		.RDY(RDY),
		.REFCLK(clk_200mhz),
		.RST(~rst_n)
	);

	wire [0:0] lvds_rxd_dly[0:7];
	wire [15:0] ADC_OUT;
	

	genvar j;
	generate
	for (j=0; j<8; j=j+1) begin : DATA_TO_IDELAY

		(* IODELAY_GROUP="LVDS_RCLK_GROUP"*)
		IDELAYE2 #(
			.CINVCTRL_SEL("FALSE"),  //是否反转时钟的极性
			.DELAY_SRC("IDATAIN"),  //(IDATAIN,DATAIN) 延迟信号来源：（1）管脚或经过BUF输出的信号（2）内部信号
			.HIGH_PERFORMANCE_MODE("TRUE"), //TRUE 选择高性能模式减小抖动
			.IDELAY_TYPE("FIXED"), //延迟模式（1） FIXED 固定，不能用VIO调，只能手动修改  （2） VAR_LOAD 可以用变量来动态更改延迟比较灵活
			.IDELAY_VALUE(0),//(0-31)延迟的值，只在FIXED模式下有用(0值也有延迟)，其他模式不关心,为0即可。要注意固定模式的0的延迟值与VARLOAD模式的0值延迟不一样。
			.PIPE_SEL("FALSE"),
			.REFCLK_FREQUENCY(200.0),  //(200,300)  参考时钟频率
			.SIGNAL_PATTERN("DATA") //(DATA,CLOCK) 确定延迟的是时钟还是数据，以确定不同路径上的抖动
			)
			IDELAYE2_inst(
			.CNTVALUEOUT(),//5-bit output 延迟系数的输出，通过对它观察就可以知道原语此时的工作状态，它在什么延迟系数下工作
			.DATAOUT(lvds_rxd_dly[j]),//1bit output  经过延迟过后的数据
			.C(),  //工作时钟   FIXED下不需要，因为不需要设置时序
			.CE(1'b0),//1-bit input  控制抽头系数变化
			.CINVCTRL(1'b0),// bit input 使时钟极性反转
			.CNTVALUEIN(5'd0),//5-bit 设置延迟值，FIXED模式不在此设置，在上面参数中设置
			.DATAIN(),  //1_bit  input  需要延迟的信号，内部信号放入，
			.IDATAIN(lvds_rxd[j]),//1-bit input     管脚信号放入
			.INC(1'b0),   
			.LD(1'b1),  //拉高，设置的延迟值才有效
			.LDPIPEEN(1'b0),
			.REGRST(1'b0)
		   
			);
			//数据的位置与时钟的上下沿，延迟调整到一个好的建立和保持时间后，再进行IDDR,采集的数据就稳定了
		// IDDR #(
			// .DDR_CLK_EDGE("OPPOSITE_EDGE"),
			// .INIT_Q(1'b0),
			// .SRTYPE("ASYNC")
			// )IDDR_inst(
			
				// .Q1(ADC_OUT[2*j]),  //output  上升沿
				// .Q2(ADC_OUT[2*j+1]),//output 下降沿
				// .C(lvds_rclk),
				// .CE(1'b1),
				// .D(lvds_rxd_dly[j]),
				// .R(1'b0),
				// .S(1'b0)
			
			// );
			
			
			  IDDR #(
				  .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
												  //    or "SAME_EDGE_PIPELINED" 
				  .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
				  .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
				  .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
			   ) IDDR_inst (
				  .Q1(ADC_OUT[2*j]), // 1-bit output for positive edge of clock
				  .Q2(ADC_OUT[2*j+1]), // 1-bit output for negative edge of clock
				  .C(lvds_rclk),   // 1-bit clock input
				  .CE(1'b1), // 1-bit clock enable input
				  .D(lvds_rxd_dly[j]),   // 1-bit DDR data input
				  .R(1'b0),   // 1-bit reset
				  .S(1'b0)    // 1-bit set
			   );
			
			
			
			
			
			
			
			
			

		end
	endgenerate





	reg [15:0] ADC_OUT_d1;
	
	always @ (posedge lvds_rclk)
	begin
		if(~rst_n)
			begin 
				ADC_OUT_d1 <= 16'd0;
			end 
		else 
			begin 
				ADC_OUT_d1 <= ADC_OUT;
			end 
	end 
	
	assign o_adc_data = ADC_OUT_d1 ;
	assign o_adc_clk = lvds_rclk;

















endmodule





