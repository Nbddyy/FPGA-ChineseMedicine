






	module TWO_VALUE
		(
			 input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
			 input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
			 
			 input   wire    [7:0]   din    ,   //输入像素点色彩信息
			 input  wire             hsync       ,   //输出行同步信号
			 input  wire             vsync       ,   //输出场同步信号
			 
			 input wire de,
			 output reg TWO_VALUE_de,
			 
			 output reg  [7:0]       dout,
			 output reg 				 hsync_r,
			 output reg 			    vsync_r
			 
		);

	
//////////////将二值化的阈值设置为100///////////////////////////
//////////////将二值化的阈值设置为100///////////////////////////	
//////////////将二值化的阈值设置为100///////////////////////////	
	
	always @ (posedge vga_clk or negedge sys_rst_n)
	begin 
		if(~sys_rst_n)
			begin 
				dout <= 8'd0;
			end 
		else 
			begin 
				dout <= (din >= 8'd100) ? 8'hff : 8'h00;
			end 
	end 
	
	always @ (posedge vga_clk or negedge sys_rst_n)	
	begin 
		if(~sys_rst_n)
			begin 
				hsync_r <= 1'b0;
				vsync_r <= 1'b0;
				TWO_VALUE_de <= 1'b0;
			end 
		else 
			begin 
				hsync_r <= hsync;
				vsync_r <= vsync;
				TWO_VALUE_de <= de;
			end 
	end 
	
	





	endmodule
















