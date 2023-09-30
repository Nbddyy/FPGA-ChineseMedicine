

	module DISPLAY_SELECT(
	
	 input wire vga_clk,
	 input wire sys_rst_n,
	
	 input  wire            RGB_hsync       ,   //输出行同步信号
    input  wire            RGB_vsync       ,   //输出场同步信号
    input  wire    [15:0]  RGB_rgb          ,   //输出像素点色彩信息
	
	 input  wire             GRAY_hsync       ,   //输出行同步信号
	 input  wire             GRAY_vsync       ,   //输出场同步信号
	 input wire  [7:0]         GRAY_dout     ,
	 
	 input wire  [7:0]       TWO_VALUE_dout,
	 input wire 				 TWO_VALUE_hsync_r,
	 input wire 			    TWO_VALUE_vsync_r,
	 
	 input wire[7:0]         SOBEL_data_out,
	 input                   SOBEL_hs,
	 input                   SOBEL_vs,
	 
	 input wire  KEY1_FLAG,
	 input wire  KEY2_FLAG,
	 input wire  KEY3_FLAG,
	 input wire  KEY4_FLAG,
	 
	 output wire final_out_hs,
	 output wire final_out_vs,
	 output wire [7:0] final_vga_r,
	 output wire [7:0] final_vga_g,
	 output wire [7:0] final_vga_b
	
	);

	reg [3:0] cnt = 4'd0;
	
	always @ (posedge vga_clk or negedge sys_rst_n)
	begin 
		if(~sys_rst_n)
			begin 
				cnt <= 4'd0;
			end 
		else if(cnt == 4'd3)
			begin 
				cnt <= 4'd0;
			end 
	//	else if(KEY1_FLAG || KEY2_FLAG || KEY3_FLAG || KEY4_FLAG)
		else if(KEY1_FLAG || KEY2_FLAG || KEY3_FLAG )
			begin 
				cnt <= cnt + 1'b1;
			end 
	end 
	
	

	
assign final_out_hs = (cnt==4'd0) ?  RGB_hsync : (
						// (cnt==4'd1) ?  GRAY_hsync : (
						 (cnt==4'd1) ?  TWO_VALUE_hsync_r : (
						 (cnt==4'd2) ?  SOBEL_hs :  RGB_hsync
						));	
	
assign final_out_vs = (cnt==4'd0) ?  RGB_vsync : (
					//	 (cnt==4'd1) ?  GRAY_vsync : (
						 (cnt==4'd1) ?  TWO_VALUE_vsync_r : (
						 (cnt==4'd2) ?  SOBEL_vs :  RGB_vsync
						));		
	
assign final_vga_r = (cnt==4'd0) ?  {RGB_rgb[15:11],3'b0} : (
					//	 (cnt==4'd1) ?  GRAY_dout : (
						 (cnt==4'd1) ?  TWO_VALUE_dout : (
						 (cnt==4'd2) ?  SOBEL_data_out :  {RGB_rgb[15:11],3'b0}
						));		
	
	
assign final_vga_g = (cnt==4'd0) ?  {RGB_rgb[10:5],2'b0} : (
						// (cnt==4'd1) ?  GRAY_dout : (
						 (cnt==4'd1) ?  TWO_VALUE_dout : (
						 (cnt==4'd2) ?  SOBEL_data_out :  {RGB_rgb[10:5],2'b0}
						));		
	
assign final_vga_b = (cnt==4'd0) ?  {RGB_rgb[4:0],3'b0} : (
						// (cnt==4'd1) ?  GRAY_dout : (
						 (cnt==4'd1) ?  TWO_VALUE_dout : (
						 (cnt==4'd2) ?  SOBEL_data_out :  {RGB_rgb[4:0],3'b0}
						));		
	
	
	
	
	
	
	
	
	
	
	
	
//	
//	
//	
//	always @ (posedge vga_clk or negedge sys_rst_n)
//	begin 
//		if(~sys_rst_n)
//			begin 
//				final_out_hs <= 1'b0;
//				final_out_vs <= 1'b0;
//				final_vga_r <= 8'd0;
//				final_vga_g <= 8'd0;
//				final_vga_b <= 8'd0;
//			end 
//		else 
//			begin 
//				case(cnt)
//					4'd0:
//						begin 
//							final_out_hs <= RGB_hsync;
//							final_out_vs <= RGB_vsync;
//							final_vga_r <= {RGB_rgb[15:11],3'b0};////RGB_rgb
//							final_vga_g <= {RGB_rgb[10:5],2'b0};
//							final_vga_b <= {RGB_rgb[4:0],3'b0};
//						end 
//						
//					4'd1:
//						begin 
//							final_out_hs <= GRAY_hsync;
//							final_out_vs <= GRAY_vsync;
//							final_vga_r <= GRAY_dout;////RGB_rgb
//							final_vga_g <= GRAY_dout;
//							final_vga_b <= GRAY_dout;
//						end 
//						
//					4'd2:
//						begin 
//							final_out_hs <= TWO_VALUE_hsync_r;
//							final_out_vs <= TWO_VALUE_vsync_r;
//							final_vga_r <= TWO_VALUE_dout;////RGB_rgb
//							final_vga_g <= TWO_VALUE_dout;
//							final_vga_b <= TWO_VALUE_dout;
//						end 
//						
//					4'd3:
//						begin 
//							final_out_hs <= SOBEL_hs;
//							final_out_vs <= SOBEL_vs;
//							final_vga_r <= SOBEL_data_out;////RGB_rgb
//							final_vga_g <= SOBEL_data_out;
//							final_vga_b <= SOBEL_data_out;
//						end 
//						
//					default :
//						begin 
//							final_out_hs <= RGB_hsync;
//							final_out_vs <= RGB_vsync;
//							final_vga_r <= {RGB_rgb[15:11],3'b0};////RGB_rgb
//							final_vga_g <= {RGB_rgb[10:5],2'b0};
//							final_vga_b <= {RGB_rgb[4:0],3'b0};
//						
//						end 
//				endcase 
//			end 
//	end 
//	
//	
//	
//	
//	
//	
//	
//	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

















	endmodule 

























