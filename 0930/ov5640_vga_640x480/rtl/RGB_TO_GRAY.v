
	module RGB_TO_GRAY
	(
		 input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
		 input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
		 
		 input   wire    [15:0]  din    ,   //输入像素点色彩信息
		 input  wire             hsync       ,   //输出行同步信号
		 input  wire             vsync       ,   //输出场同步信号
		 
		 output reg  [7:0]         dout,
		 output reg                GRAY_HSYNC_OUT,
		 output reg                GRAY_VSYNC_OUT
		 
	);

//////////delay 4 clocks///////////////////////////////////

	reg hsync_r1 = 1'b0;
	reg hsync_r2 = 1'b0;
	reg hsync_r3 = 1'b0;
	
	reg vsync_r1 = 1'b0;
	reg vsync_r2 = 1'b0;
	reg vsync_r3 = 1'b0;


	always @ (posedge vga_clk or negedge sys_rst_n)
	begin 
		if(~sys_rst_n)
			begin 
				hsync_r1 <= 1'b0;
				hsync_r2 <= 1'b0;
				hsync_r3 <= 1'b0;
				
				vsync_r1 <= 1'b0;
				vsync_r2 <= 1'b0;
				vsync_r3 <= 1'b0;
				
				GRAY_HSYNC_OUT <= 1'b0;
				GRAY_VSYNC_OUT <= 1'b0;
			end 
		else 
			begin 
				hsync_r1 <= hsync;
				hsync_r2 <= hsync_r1;
				hsync_r3 <= hsync_r2;
				GRAY_HSYNC_OUT <= hsync_r3;
				
				vsync_r1 <= vsync;
				vsync_r2 <= vsync_r1;
				vsync_r3 <= vsync_r2;
				GRAY_VSYNC_OUT <= vsync_r3;
			end 
	end 
	
	
	
	
	
	
	
	
	

	 reg     [7:0]       data_r  ;
    reg     [7:0]       data_g  ;
    reg     [7:0]       data_b  ;

    always  @(posedge vga_clk or negedge sys_rst_n)begin
        if(~sys_rst_n)begin
            data_r <= 0;
            data_g <= 0;
            data_b <= 0;
        end
        else //if(din_vld)
		  begin
            data_r <= {din[15:11],din[13:11]};      //带补偿的  r5,r4,r3,r2,r1, r3,r2,r1
            data_g <= {din[10:5],din[6:5]}   ;
            data_b <= {din[4:0],din[2:0]}    ;
        end
    end


    reg     [17:0]      pixel_r ;
    reg     [17:0]      pixel_g ;
    reg     [17:0]      pixel_b ;
	
    //第一拍
    always  @(posedge vga_clk or negedge sys_rst_n)begin
        if(~sys_rst_n)begin
            pixel_r <= 0;
            pixel_g <= 0;
            pixel_b <= 0;
        end
        else// if(vld[0])
		  begin
            pixel_r <= data_r * 306;
            pixel_g <= data_g * 601;
            pixel_b <= data_b * 117;
        end
    end
    //第二拍
	 
	 reg     [17:0]      pixel   ;
	 
    always  @(posedge vga_clk or negedge sys_rst_n)begin
        if(~sys_rst_n)begin
            pixel <= 0;
        end
        else// if(vld[1])
		  begin
            pixel <= (pixel_r + pixel_g + pixel_b)>>10;
        end
    end

	
	


	 always  @(posedge vga_clk or negedge sys_rst_n)begin
        if(~sys_rst_n)begin
            dout <= 0;
        end
        else// if(vld[1])
		  begin
            dout <= pixel[8:1];
        end
    end
	
	

	
	
	
	
	
	
	
	
	
	

endmodule





