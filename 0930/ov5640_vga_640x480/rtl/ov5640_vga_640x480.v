`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : EmbedFire
// Create Date   : 2019/11/01
// Module Name   : ov5640_vga_640x480
// Project Name  : ov5640_vga_640x480
// Target Devices: Altera EP4CE10F17C8N
// Tool Versions : Quartus 13.0
// Description   : 顶层模块
// 
// Revision      : V1.0
// Additional Comments:
// 
// 实验平台: 野火_征途Pro_FPGA开发板
// 公司    : http://www.embedfire.com
// 论坛    : http://www.firebbs.cn
// 淘宝    : https://fire-stm32.taobao.com
////////////////////////////////////////////////////////////////////////

module  ov5640_vga_640x480
(
    input   wire            sys_clk     ,  //系统时钟
    input   wire            sys_rst_n   ,  //系统复位，低电平有效
//摄像头接口
    input   wire            ov5640_pclk ,  //摄像头数据像素时钟
    input   wire            ov5640_vsync,  //摄像头场同步信号
    input   wire            ov5640_href ,  //摄像头行同步信号
    input   wire    [7:0]   ov5640_data ,  //摄像头数据
    output  wire            ov5640_rst_n,  //摄像头复位信号，低电平有效
    output  wire            ov5640_pwdn ,  //摄像头时钟选择信号, 1:使用摄像头自带的晶振
    output  wire            sccb_scl    ,  //摄像头SCCB_SCL线
    inout   wire            sccb_sda    ,  //摄像头SCCB_SDA线
//SDRAM接口
    output  wire            sdram_clk   ,  //SDRAM 时钟
    output  wire            sdram_cke   ,  //SDRAM 时钟使能
    output  wire            sdram_cs_n  ,  //SDRAM 片选
    output  wire            sdram_ras_n ,  //SDRAM 行有效
    output  wire            sdram_cas_n ,  //SDRAM 列有效
    output  wire            sdram_we_n  ,  //SDRAM 写有效
    output  wire    [1:0]   sdram_ba    ,  //SDRAM Bank地址
    output  wire    [1:0]   sdram_dqm   ,  //SDRAM 数据掩码
    output  wire    [12:0]  sdram_addr  ,  //SDRAM 地址
    inout   wire    [15:0]  sdram_dq    ,  //SDRAM 数据
//VGA接口
    output  wire            vga_hs      ,  //行同步信号
    output  wire            vga_vs      ,  //场同步信号
    output  wire    [15:0]  vga_rgb     ,   //红绿蓝三原色输出 
	 
	 input   wire            KEY_IN1,
	 input   wire            KEY_IN2,  
	 input   wire            KEY_IN3,
	 input   wire            KEY_IN4,
	 
	 output  wire            stcp        ,   //输出数据存储寄时钟
	 output  wire            shcp        ,   //移位寄存器的时钟输入
	 output  wire            ds          ,   //串行数据输入
	 output  wire            oe              //输出使能信号
	 
	 
	 
	 
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//

//parameter define
parameter   H_PIXEL     =   24'd640 ;   //水平方向像素个数,用于设置SDRAM缓存大小
parameter   V_PIXEL     =   24'd480 ;   //垂直方向像素个数,用于设置SDRAM缓存大小

//wire  define
wire            clk_100m        ;   //100mhz时钟,SDRAM操作时钟
wire            clk_100m_shift  ;   //100mhz时钟,SDRAM相位偏移时钟
wire            clk_25m         ;   //25mhz时钟,提供给vga驱动时钟
wire            locked          ;   //PLL锁定信号
wire            rst_n           ;   //复位信号(sys_rst_n & locked)
wire            cfg_done        ;   //摄像头初始化完成
wire            wr_en           ;   //sdram写使能
wire   [15:0]   wr_data         ;   //sdram写数据
wire            rd_en           ;   //sdram读使能
wire   [15:0]   rd_data         ;   //sdram读数据
wire            sdram_init_done ;   //SDRAM初始化完成
wire            sys_init_done   ;   //系统初始化完成(SDRAM初始化+摄像头初始化)

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//

//rst_n:复位信号(sys_rst_n & locked)
assign  rst_n = sys_rst_n & locked;

//sys_init_done:系统初始化完成(SDRAM初始化+摄像头初始化)
assign  sys_init_done = sdram_init_done & cfg_done;

//ov5640_rst_n:摄像头复位,固定高电平
assign  ov5640_rst_n = 1'b1;

//ov5640_pwdn
assign  ov5640_pwdn = 1'b0;



wire pll_clk50mhz;

//------------- clk_gen_inst -------------
clk_gen clk_gen_inst(

    .areset     (~sys_rst_n     ),
    .inclk0     (sys_clk        ),
    .c0         (clk_100m       ),
    .c1         (clk_100m_shift ),
    .c2         (clk_25m        ),
	 .c3          (pll_clk50mhz),
    .locked     (locked         )

);

//------------- ov5640_top_inst -------------
ov5640_top  ov5640_top_inst(

    .sys_clk         (clk_25m       ),   //系统时钟
    .sys_rst_n       (rst_n         ),   //复位信号
    .sys_init_done   (sys_init_done ),   //系统初始化完成(SDRAM + 摄像头)

    .ov5640_pclk     (ov5640_pclk   ),   //摄像头像素时钟
    .ov5640_href     (ov5640_href   ),   //摄像头行同步信号
    .ov5640_vsync    (ov5640_vsync  ),   //摄像头场同步信号
    .ov5640_data     (ov5640_data   ),   //摄像头图像数据

    .cfg_done        (cfg_done      ),   //寄存器配置完成
    .sccb_scl        (sccb_scl      ),   //SCL
    .sccb_sda        (sccb_sda      ),   //SDA
    .ov5640_wr_en    (wr_en         ),   //图像数据有效使能信号
    .ov5640_data_out (wr_data       )    //图像数据

);

//------------- sdram_top_inst -------------
sdram_top   sdram_top_inst(

    .sys_clk            (clk_100m       ),  //sdram 控制器参考时钟
    .clk_out            (clk_100m_shift ),  //用于输出的相位偏移时钟
    .sys_rst_n          (rst_n          ),  //系统复位
//用户写端口
    .wr_fifo_wr_clk     (ov5640_pclk    ),  //写端口FIFO: 写时钟
    .wr_fifo_wr_req     (wr_en          ),  //写端口FIFO: 写使能
    .wr_fifo_wr_data    (wr_data        ),  //写端口FIFO: 写数据
    .sdram_wr_b_addr    (24'd0          ),  //写SDRAM的起始地址
    .sdram_wr_e_addr    (H_PIXEL*V_PIXEL),  //写SDRAM的结束地址
    .wr_burst_len       (10'd512        ),  //写SDRAM时的数据突发长度
    .wr_rst             (~rst_n         ),  //写端口复位: 复位写地址,清空写FIFO
//用户读端口
    .rd_fifo_rd_clk     (clk_25m        ),  //读端口FIFO: 读时钟
    .rd_fifo_rd_req     (rd_en          ),  //读端口FIFO: 读使能
    .rd_fifo_rd_data    (rd_data        ),  //读端口FIFO: 读数据
    .sdram_rd_b_addr    (24'd0          ),  //读SDRAM的起始地址
    .sdram_rd_e_addr    (H_PIXEL*V_PIXEL),  //读SDRAM的结束地址
    .rd_burst_len       (10'd512        ),  //从SDRAM中读数据时的突发长度
    .rd_rst             (~rst_n         ),  //读端口复位: 复位读地址,清空读FIFO
//用户控制端口
    .read_valid         (1'b1           ),  //SDRAM 读使能
    .pingpang_en        (1'b1           ),  //SDRAM 乒乓操作使能
    .init_end           (sdram_init_done),  //SDRAM 初始化完成标志
//SDRAM 芯片接口
    .sdram_clk          (sdram_clk      ),  //SDRAM 芯片时钟
    .sdram_cke          (sdram_cke      ),  //SDRAM 时钟有效
    .sdram_cs_n         (sdram_cs_n     ),  //SDRAM 片选
    .sdram_ras_n        (sdram_ras_n    ),  //SDRAM 行有效
    .sdram_cas_n        (sdram_cas_n    ),  //SDRAM 列有效
    .sdram_we_n         (sdram_we_n     ),  //SDRAM 写有效
    .sdram_ba           (sdram_ba       ),  //SDRAM Bank地址
    .sdram_addr         (sdram_addr     ),  //SDRAM 行/列地址
    .sdram_dq           (sdram_dq       ),  //SDRAM 数据
    .sdram_dqm          (sdram_dqm      )   //SDRAM 数据掩码

);




	wire SDRAM_HSYNC;
	wire SDRAM_VSYNC;
	wire [15:0] SDRAM_VGA_RGB;

	wire vga_ctrl_de;



//------------- vga_ctrl_inst -------------
vga_ctrl    vga_ctrl_inst
(
    .vga_clk        (clk_25m    ),  //输入工作时钟,频率25MHz
    .sys_rst_n      (rst_n      ),  //输入复位信号,低电平有效
    .pix_data       (rd_data    ),  //待显示数据输入

    .pix_data_req   (rd_en      ),  //数据请求信号
    .hsync          (SDRAM_HSYNC     ),  //输出行同步信号
    .vsync          (SDRAM_VSYNC     ),  //输出场同步信号
	 
	 . vga_ctrl_de(vga_ctrl_de),
	 
    .rgb            (SDRAM_VGA_RGB    )   //输出像素信息
);



	   wire            RGB_hsync       ;   //输出行同步信号
      wire            RGB_vsync       ;   //输出场同步信号
      wire    [15:0]  RGB_rgb          ;   //输出像素点色彩信息
	
	   wire             GRAY_hsync       ;   //输出行同步信号
	   wire             GRAY_vsync       ;   //输出场同步信号
	  wire  [7:0]         GRAY_dout     ;
	 
	  wire  [7:0]       TWO_VALUE_dout;
	  wire 				 TWO_VALUE_hsync_r;
	  wire 			    TWO_VALUE_vsync_r;
	 
	  wire[7:0]         SOBEL_data_out;
	  wire                   SOBEL_hs;
	  wire                   SOBEL_vs;

	  
	  
	  wire [7:0] GRAY_DATAOUT;
	  wire GRAY_HSYNC_OUT;
	  wire GRAY_VSYNC_OUT;
	  
	  wire [7:0] final_vga_r;
	  wire [7:0] final_vga_g;
	  wire [7:0] final_vga_b;
	  wire       final_out_hs;
	  wire       final_out_vs;
	  
	  
	  	wire KEY1_FLAG;
	  wire KEY2_FLAG;
	   wire KEY3_FLAG;
	   wire KEY4_FLAG;
		
		wire[7:0]                       ycbcr_y;
		

//	RGB_TO_GRAY RGB_TO_GRAY
//		(
//			 .  vga_clk(clk_25m)     ,   //输入工作时钟,频率25MHz
//			 .  sys_rst_n(rst_n)   ,   //输入复位信号,低电平有效
//			 
//			 . din(SDRAM_VGA_RGB)    ,   //输入像素点色彩信息
//			 . hsync(SDRAM_HSYNC)       ,   //输出行同步信号
//			 . vsync(SDRAM_VSYNC)       ,   //输出场同步信号
//			 
//			 . dout(GRAY_DATAOUT),
//			.   GRAY_HSYNC_OUT(GRAY_HSYNC_OUT),
//		  .  GRAY_VSYNC_OUT(GRAY_VSYNC_OUT)
//			 
//		);	
		
		
	wire rgb_to_ycbcr_de;	
		
		
	rgb_to_ycbcr rgb_to_ycbcr_m0(
    .clk                        (clk_25m                ),
    .rst                        (~rst_n                   ),
    .rgb_r                      ({SDRAM_VGA_RGB[15:11],3'd0}  ),
    .rgb_g                      ({SDRAM_VGA_RGB[10:5],2'd0}   ),
    .rgb_b                      ({SDRAM_VGA_RGB[4:0],3'd0}    ),
    .rgb_hs                     (SDRAM_HSYNC                       ),
    .rgb_vs                     (SDRAM_VSYNC                       ),
    .rgb_de                     ( vga_ctrl_de                      ),
    .ycbcr_y                    (GRAY_DATAOUT                  ),
    .ycbcr_cb                   (                         ),
    .ycbcr_cr                   (                         ),
    .ycbcr_hs                   ( GRAY_HSYNC_OUT                ),
    .ycbcr_vs                   ( GRAY_VSYNC_OUT                ),
    .ycbcr_de                   ( rgb_to_ycbcr_de                )
);	
		
		
		
		
		
		
		
		wire TWO_VALUE_de;
		
		
	TWO_VALUE TWO_VALUE
		(
			. vga_clk(clk_25m)     ,   //输入工作时钟,频率25MHz
			. sys_rst_n(rst_n)   ,   //输入复位信号,低电平有效
			 
			. din(GRAY_DATAOUT)    ,   //输入像素点色彩信息
			. hsync(GRAY_HSYNC_OUT)       ,   //输出行同步信号
			. vsync(GRAY_VSYNC_OUT)       ,   //输出场同步信号
			 
			. de(rgb_to_ycbcr_de),
		   . TWO_VALUE_de(TWO_VALUE_de),	
			 
		   . dout(TWO_VALUE_dout),
		   . hsync_r(TWO_VALUE_hsync_r),
	   	. vsync_r(TWO_VALUE_vsync_r)
			 
		);
	
	wire [7:0] sobel_yuzhi_out ;
	
	SOBEL_YUZHI SOBEL_YUZHI
	(
		.  vga_clk(clk_25m)     ,   //输入工作时钟,频率25MHz
		.  sys_rst_n(rst_n)   ,   //输入复位信号,低电平有效
		
		. key4_flag(KEY4_FLAG),
		
		. sobel_yuzhi_out(sobel_yuzhi_out)
		
		
	);
	
	
	
	
	

	
	
	SOBEL SOBEL(
	
	. sys_rst_n(rst_n),
	. vga_clk(clk_25m),
	
	. sobel_yuzhi_out(sobel_yuzhi_out),
	
	. ycbcr_de(TWO_VALUE_de),
	
	. ycbcr_hs(TWO_VALUE_hsync_r),
	. ycbcr_vs(TWO_VALUE_vsync_r),

	. data_in(TWO_VALUE_dout),
	
	. data_out(SOBEL_data_out),
	. sobel_hs(SOBEL_hs),
	. sobel_vs(SOBEL_vs)

	);
	
	
	
	
	
	
	
	
	DISPLAY_SELECT DISPLAY_SELECT(
	
	 . vga_clk(clk_25m),
	 . sys_rst_n(rst_n),
	
	 . RGB_hsync(SDRAM_HSYNC)       ,   //输出行同步信号
    . RGB_vsync(SDRAM_VSYNC)       ,   //输出场同步信号
    . RGB_rgb(SDRAM_VGA_RGB)          ,   //输出像素点色彩信息
	
	 .  GRAY_hsync(GRAY_hsync)       ,   //输出行同步信号
	 . GRAY_vsync(GRAY_vsync)       ,   //输出场同步信号
	 . GRAY_dout(GRAY_dout)     ,
	 
	 . TWO_VALUE_dout(TWO_VALUE_dout),
	 . TWO_VALUE_hsync_r(TWO_VALUE_hsync_r),
	 . TWO_VALUE_vsync_r(TWO_VALUE_vsync_r),
	 
	 . SOBEL_data_out(SOBEL_data_out),
	 . SOBEL_hs(SOBEL_hs),
	 . SOBEL_vs(SOBEL_vs),
	 
	 . KEY1_FLAG(KEY1_FLAG),
	 . KEY2_FLAG(KEY2_FLAG),
	 . KEY3_FLAG(KEY3_FLAG),
	 . KEY4_FLAG(KEY4_FLAG),
	 
	 . final_out_hs(final_out_hs),
	 . final_out_vs(final_out_vs),
	 . final_vga_r(final_vga_r),
	 . final_vga_g(final_vga_g),
	 . final_vga_b(final_vga_b)
	
	);
	
	
	
	
	assign vga_hs = final_out_hs;
	assign vga_vs = final_out_vs;
	assign vga_rgb = {final_vga_r[7:3], final_vga_g[7:2], final_vga_b[7:3] };
	
//	assign vga_hs = SDRAM_HSYNC;
//	assign vga_vs = SDRAM_VSYNC;
//	assign vga_rgb = SDRAM_VGA_RGB;
//	
	
	
	

	
	

	
	Key_check_module Key_check_module//按键检测模块，延时消抖
	(	
	. Clk_50mhz(clk_25m),//50M时钟
	. Rst_n(rst_n),//全局复位信号
		
	. Left(KEY_IN3),//左按键
	. Right(KEY_IN4),//右按键
	. Up(KEY_IN1),//上按键
	. Down(KEY_IN2),//下按键
		
	. Key_left(KEY3_FLAG),//左按键寄存器
	. Key_right(KEY4_FLAG),//右按键寄存器
	. Key_up(KEY1_FLAG),//上按键寄存器
	. Key_down(KEY2_FLAG)//下按键寄存器
	);
		
	
	
		
		top_seg_595 top_seg_595
	(
		 . sys_clk(pll_clk50mhz)     ,   //系统时钟，频率50MHz
		 . sys_rst_n(rst_n)   ,   //复位信号，低电平有效
		 
		 . game_score(sobel_yuzhi_out),

		 . stcp(stcp)        ,   //输出数据存储寄时钟
		 . shcp(shcp)        ,   //移位寄存器的时钟输入
		 . ds(ds)          ,   //串行数据输入
		 . oe(oe)              //输出使能信号
	);
	
	
	
	
	





































































endmodule































