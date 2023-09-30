
	module  SOBEL_YUZHI
	(
		 input   wire            vga_clk     ,   //输入工作时钟,频率25MHz
		 input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
		
		 input wire key4_flag,
		
		 output reg sobel_yuzhi_out
		
		
	);
	
	
	reg [7:0] yuzhi = 8'd10;
	
	always @ (posedge vga_clk or negedge sys_rst_n)
	begin 
		if(~sys_rst_n)
			begin 
				yuzhi <= 8'd10;
			end 
		else if(yuzhi >= 8'd200)
			begin 
				yuzhi <= 8'd10;
			end 
		else if(key4_flag)
			begin 
				yuzhi <= yuzhi + 20;
			end 
	end 
	
	
	always @ (posedge vga_clk or negedge sys_rst_n)
	begin 
		if(~sys_rst_n)
			begin 
				sobel_yuzhi_out <= 8'd15;
			end 
		else 
			begin 
				sobel_yuzhi_out <= yuzhi;
			end 
	end 
	
	
	
	
	
	
	
	
	
	
	
	endmodule
	
	