	
	module SOBEL (
	
	input                       sys_rst_n,
	input                       vga_clk,
	
	input wire [7:0] sobel_yuzhi_out,
	
	
	input                       ycbcr_hs,
	input                       ycbcr_vs,
	input                       ycbcr_de,
	input[7:0]                  data_in,
	
	output reg[7:0]             data_out,
	output                      sobel_hs,
	output                      sobel_vs
//	output                      sobel_de
	
	);
	reg[7:0] p11,p12,p13;
	reg[7:0] p21,p22,p23;
	reg[7:0] p31,p32,p33;
	
	wire[7:0] p1,p2,p3;
	
	reg[9:0] x1,x3;
	reg[9:0] y1,y3;
	
	reg[9:0] abs_x,abs_y;
	reg[10:0] abs_g;

	reg [8:0] hs_buf ;
	reg [8:0] vs_buf ;
	reg [8:0] de_buf ;


		
		
	shift_ram shift_ram(
			.clock(vga_clk),
			.shiftin(data_in),
			.clken(ycbcr_de),
			.shiftout(),
			.taps0x(p1),
			.taps1x(p2),
			.taps2x(p3)
			);	
		
		
		
		
////生成3X3矩阵///////////////////////////////////////////////		
////生成3X3矩阵///////////////////////////////////////////////		
////生成3X3矩阵///////////////////////////////////////////////
		
	always@(posedge vga_clk or negedge sys_rst_n)
	begin
		if(~sys_rst_n)
			begin 
				p11 <= 8'd0;
				p21 <= 8'd0;
				p31 <= 8'd0;
				
				p12 <= 8'd0;
				p22 <= 8'd0;
				p32 <= 8'd0;
				
				p13 <= 8'd0;
				p23 <= 8'd0;
				p33 <= 8'd0;
				
			end 
		else 
			begin 
				p11 <= p1;
				p21 <= p2;
				p31 <= p3;
				
				p12 <= p11;
				p22 <= p21;
				p32 <= p31;
				
				p13 <= p12;
				p23 <= p22;
				p33 <= p32;
		end 
	end

	always@(posedge vga_clk or negedge sys_rst_n)
	begin
		if(~sys_rst_n)
			begin 
				x1 <= 10'd0;
				x3 <= 10'd0;
				y1 <= 10'd0;
				y3 <= 10'd0;
			end 
		else 
			begin 
				x1 <= {2'b00,p11} + {2'b00,p31} + {1'b0,p21,1'b0}; //// p11 + p31 + 2*p21
				x3 <= {2'b00,p13} + {2'b00,p33} + {1'b0,p23,1'b0}; //// p13 + p33 + 2*p23
				
				y1 <= {2'b00,p11} + {2'b00,p13} + {1'b0,p12,1'b0};//// p11 + p13 + 2*p12
				y3 <= {2'b00,p31} + {2'b00,p33} + {1'b0,p32,1'b0};//// p31 + p33 + 2*p32
			end 
	end

	always@(posedge vga_clk or negedge sys_rst_n)////取绝对值
	begin
		if(~sys_rst_n)
			begin 
				abs_x <= 10'd0;
				abs_y <= 10'd0;
				abs_g <= 11'd0;
			end 
		else 
			begin 
				abs_x <= (x1 > x3) ? x1 - x3 : x3 - x1;
				abs_y <= (y1 > y3) ? y1 - y3 : y3 - y1;
				abs_g <= abs_x + abs_y;
			end 
	end

	always@(posedge vga_clk or negedge sys_rst_n)
	begin
		if(~sys_rst_n)
			begin 
				data_out <= 8'd0;
			end 
		else 
			begin 
			//	data_out <= (abs_g > 40) ? 8'h00 : 8'hff;   //sobel_yuzhi_out
				data_out <= (abs_g > sobel_yuzhi_out) ? 8'h00 : 8'hff;   //sobel_yuzhi_out
			end 
	end
	//hs vs de delay 9 clock
	always@(posedge vga_clk or negedge sys_rst_n)
	begin
	  if(~sys_rst_n)
		  begin
			 hs_buf <= 9'd0 ;
			 vs_buf <= 9'd0 ;
			// de_buf <= 9'd0 ;
		  end
	  else
		  begin
			 hs_buf <= {hs_buf[7:0], ycbcr_hs} ;
			 vs_buf <= {vs_buf[7:0], ycbcr_vs} ;
		//	 de_buf <= {de_buf[7:0], ycbcr_de} ;
		  end
	end

	assign sobel_hs = hs_buf[8] ;
	assign sobel_vs = vs_buf[8] ;
//	assign sobel_de = de_buf[8] ;
	
	endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	