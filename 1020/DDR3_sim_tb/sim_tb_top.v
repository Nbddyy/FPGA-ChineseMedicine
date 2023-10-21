

`timescale 1ns / 1ps

module sim_tb_top;


//	GSR GSR(.GSRI(1'b1));


    wire [63:00] tx_data			; 
		wire [00:00] tx_en   			;
		reg  [00:00] enable_i			;
 		reg          clk_200M      ;

		reg          i_wr_clk     ;
		reg  [63:0]  im_wr_data   ;
 		wire          i_wr_en      ;
 		
 		reg          i_rd_clk     ;
 		wire [63:0]  om_rd_data   ;
 		reg          i_rd_en      ;
 		
 		
		wire [28:0] ddr3_addr      ;               
    wire [2:0] ddr3_ba         ;              
    wire ddr3_cas_n            ;        
    wire ddr3_ck_n             ;        
    wire ddr3_ck_p             ;        
    wire ddr3_cke              ;        
    wire ddr3_ras_n            ;        
    wire ddr3_reset_n          ;        
    wire ddr3_we_n             ;        
    wire [63:0] ddr3_dq        ;               
    wire [7:0] ddr3_dqs_n            ;        
    wire [7:0] ddr3_dqs_p            ;        
    wire init_calib_complete   ;
    reg [511:0] app_wdf_data;    
    wire ui_clk;    
      
	  wire ddr3_cs_n             ;        
    wire [7:0] ddr3_dm               ;        
    wire ddr3_odt              ;        
		wire sys_clk_p             ;        
    wire sys_clk_n             ;        
//    wire sys_rst               ;        
	
	
	
	
	
	
	reg clk100m_i ;
	
	
	
    reg rst_n;
    initial begin
			clk_200M = 1'b1 ;
			clk100m_i = 1'b0;
			rst_n    = 1'b0 ;
			#100.1
			rst_n    = 1'b1 ;
		end
    
    	// initial begin
     		// enable_i = 0;
     	// wait(u_ddr3_mag.u_mig_7series_0.init_calib_complete == 1) //�ȴ�DDR��ʼ�����֮�󣬽�����ʹ�����ߡ�
     	// #10.1
     		// enable_i = 1;
     	// end
		
		always #2.5  clk_200M <= ~clk_200M ;//���ʱ������UIģ���AURORA����ģ�顣
		always @(posedge ui_clk or negedge rst_n) begin
			if(~rst_n) begin
				app_wdf_data <= 512'd0;
			end else begin
				app_wdf_data <= {$random} % 64;
			end
		end


		assign  sys_clk_p = clk_200M 	; // ����DDR�Ĳ��ʱ��
		assign  sys_clk_n = ~sys_clk_p 	; //����DDR�Ĳ��ʱ��
		
		always #5 clk100m_i = ~clk100m_i;
    
//    always #2.5 clk_ref = ~clk_ref;
 		
 		//**************************************************************************//

  //**************************************************************************//
  // Reset Generation
  //**************************************************************************//
  reg sys_rst_n;
  wire sys_rst;
  initial begin
    sys_rst_n = 1'b0;
    #20
      sys_rst_n = 1'b1;
   end

   assign sys_rst = sys_rst_n;
 		



    
/*
    
    
    ddr3_mag u_ddr3_mag(

	 .i_wr_clk(clk_200M)                        ,
	 .im_wr_data(tx_data)               ,
	 .i_wr_en(tx_en)                         ,
	
	 .i_rd_clk(clk_200M)                        ,
	 .i_rd_en(1)                         ,
   .om_rd_data(om_rd_data)              ,
	

	 // Memory interface ports
   .ddr3_addr(ddr3_addr)               ,
   .ddr3_ba(ddr3_ba)                  ,
   .ddr3_cas_n(ddr3_cas_n)                     ,
   .ddr3_ck_n(ddr3_ck_n)                      ,
   .ddr3_ck_p(ddr3_ck_p)                      ,
   .ddr3_cke(ddr3_cke)                       ,
   .ddr3_ras_n(ddr3_ras_n)                     ,
   .ddr3_reset_n(ddr3_reset_n)                   ,
   .ddr3_we_n(ddr3_we_n)                      ,
   .ddr3_dq(ddr3_dq)                  ,
   .ddr3_dqs_n(ddr3_dqs_n)                ,
   .ddr3_dqs_p(ddr3_dqs_p)                ,
   .init_calib_complete(init_calib_complete)            ,
      
	 .ddr3_cs_n(ddr3_cs_n)                      ,
   .ddr3_dm(ddr3_dm)                  ,
   .ddr3_odt(ddr3_odt)                       ,
    
    // System Clock Ports
   .sys_clk_p(sys_clk_p)                       ,
   .sys_clk_n(sys_clk_n)                       ,
   .sys_rst(sys_rst)                         

    );
    */
	
	
//////////////////////////////////////////////////////////////////////////////////////	
	
	
	ddr3_ceshi1 ddr3_ceshi1(

		. ddr3_dq(ddr3_dq),
		. ddr3_dqs_n(ddr3_dqs_n),
		. ddr3_dqs_p(ddr3_dqs_p),

		. ddr3_addr(ddr3_addr),
		. ddr3_ba(ddr3_ba),
		. ddr3_ras_n(ddr3_ras_n),
		. ddr3_cas_n(ddr3_cas_n),
		. ddr3_we_n(ddr3_we_n),
		. ddr3_reset_n(ddr3_reset_n),
		. ddr3_ck_p(ddr3_ck_p),
		. ddr3_ck_n(ddr3_ck_n),
		. ddr3_cke(ddr3_cke),
		. ddr3_cs_n(ddr3_cs_n),
		. ddr3_dm(ddr3_dm),
		. ddr3_odt(ddr3_odt),
		
		. ui_clk(ui_clk),
		. ui_clk_sync_rst(ui_clk_sync_rst),

		. clk100m_i(clk100m_i),
		. app_wdf_data(app_wdf_data)
		
		);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    
    /*
    
    //����һ�������ݵ�ģ��
    test_aurora_rtx #(
  		.DL(8000)  , //�����������ڳ��ȣ�1~4096
  		.DW(64)     //��������λ��,1~64
  	)
  	u_test_aurora_rtx
  	(
  		.rx_rst_i (),  //�������ݸ�λ
  		.rx_clk_i (),  //��������ʱ��
  		.rx_data_i(),  //��������
  		.rx_en_i  (),  //��������ʹ��
  		          
  		.tx_rst_i (rst_n	),  //�������ݸ�λ,�ߵ�ƽ��λ
  		.tx_clk_i (clk_200M	),  //��������ʱ��
  		.enable_i (enable_i ),  //��������ʹ�ܣ��ߵ�ƽ��Ч
  		.tx_dl_i  (12'd2000  ),  //����������Ч���ȿ�ĳ���,���ڳ���DLΪ3276
  		.tx_data_o(tx_data  ),  //��������
  		.tx_en_o  (tx_en    ),  //��������ʹ��
  		.err_o    ()
  	);
    
    */

   
  	genvar r,i;
	generate
	for (r = 0; r < 1; r = r + 1) begin: mem_rnk
		for (i = 0; i < 4; i = i + 1) begin: gen_mem
			ddr3_model u_ddr3_model(
    			.rst_n		(ddr3_reset_n	),
    			.ck			(ddr3_ck_p		),
    			.ck_n		(ddr3_ck_n		),
    			.cke		(ddr3_cke		),
    			.cs_n		(ddr3_cs_n		),
    			.ras_n		(ddr3_ras_n		),
    			.cas_n		(ddr3_cas_n		),
    			.we_n		(ddr3_we_n		),
    			.dm_tdqs	(ddr3_dm[(2*(i+1)-1):(2*i)]	),
    			.ba			(ddr3_ba		),
    			.addr		(ddr3_addr		),
    			.dq			(ddr3_dq[16*(i+1)-1:16*(i)]		),
    			.dqs		(ddr3_dqs_p[(2*(i+1)-1):(2*i)]			),
    			.dqs_n		(ddr3_dqs_n[(2*(i+1)-1):(2*i)]		),
    			.tdqs_n		(),
    			.odt		(ddr3_odt		)
			);
		end
	end
	endgenerate  
    
    
endmodule
