`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 14:30:00
// Design Name: 
// Module Name: ad9516_cfg_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adc_cfg_ctrl(
    input               i_clk,  ///////////////工作时钟�?100mhz
    input               i_rst,
    output              o_ad9516_ref_sel,
    output              o_ad9516_spi_cs_b,
    output              o_ad9516_spi_sclk,
    output              o_ad9516_spi_sdio,
    input               i_ad9516_spi_sdo,
	output              reg [31:0] reset_cnt,
	 output wire         adc_reset
    );
    
    
reg         ad9516_cfg_en;
reg [15:0]  cnt0;
reg         rst_reg;
reg         rst_reg0;
reg         rst_reg1;

always @(posedge i_clk)begin
    rst_reg0 <= i_rst;
    rst_reg1 <= rst_reg0;
    rst_reg  <= rst_reg1;
end

////////////////////////////////////////
////////////////////////////////////////
//配置寄存器之前，将ADC复位0.5us
reg adc_reset_r;
//reg [15:0] reset_cnt;

always @(posedge i_clk)
begin
	if(i_rst)
		begin
			reset_cnt <= 32'd0;
		end 
	else if(reset_cnt == 32'd80_000_000)
		begin
			reset_cnt <= reset_cnt;
		end 
	else 
		begin
			reset_cnt <= reset_cnt + 1'b1;
		end 
end

reg [31:0] reset_cnt2 ;

always @(posedge i_clk)
begin
	if(i_rst)
		begin
			reset_cnt2 <= 32'd0;
		end 
	else if(reset_cnt2 == 32'd300_000_000)
		begin
			reset_cnt2 <= reset_cnt2;
		end 
	else 
		begin
			reset_cnt2 <= reset_cnt2 + 1'b1;
		end 
end



//always @(posedge i_clk)
//begin
//	if(rst_reg)
//		begin
//			adc_reset_r <= 1'b0;
//		end 
//	else if(reset_cnt == 16'd60)
//		begin
//			adc_reset_r <= 1'b1;
//		end 
//	else if(reset_cnt == 16'd80)
//		begin
//			adc_reset_r <= 1'b0;
//		end 
//	
//end 





//reg     [31 : 0]                        timer                       ;
//	
//	
//	always @ (posedge i_clk)
//begin
//    if (rst_reg)
//        timer <= 'd0;
//    else if (timer > 12_500_000)
//        timer <= timer;
//    else
//        timer <= timer + 1'b1;
//end
//	
//	
	always @ (posedge i_clk)
	begin 
		if(i_rst)
			begin
				adc_reset_r <= 1'b0;
			end 
		else if(reset_cnt == 32'd60_000_000 - 32'd70)
			begin
				adc_reset_r <= 1'b1;
			end 
		else if(reset_cnt == 32'd60_000_000)
			begin
				adc_reset_r <= 1'b0;
			end 
		else if(reset_cnt == 32'd80_000_000)
			begin
				adc_reset_r <= 1'b0;
			end 
	end 

		assign adc_reset = adc_reset_r;
	
	

	
	
	
	
	


always @(posedge i_clk)begin
    if(rst_reg)begin
        cnt0 <= 0;    
    end else if(cnt0==16'hFFFF)begin
        cnt0 <= cnt0;
    end else begin
        cnt0 <= cnt0+1;
    end
end
always @(posedge i_clk)begin
    if(rst_reg)begin
        ad9516_cfg_en <= 0;
    end else if(cnt0==16'h8000)begin
        ad9516_cfg_en <= 1'b1;
    end else begin
        ad9516_cfg_en <= 1'b0;
    end
end

adc_cfg  adc_cfg(
    .i_clk              (i_clk),
    .i_rst              (i_rst),
    .i_ad9516_cfg_en    (reset_cnt == 32'd80_000_000 - 32'd10),
    .o_ad9516_ref_sel   (o_ad9516_ref_sel),
    .o_ad9516_spi_cs_b  (o_ad9516_spi_cs_b),
    .o_ad9516_spi_sclk  (o_ad9516_spi_sclk),
    .o_ad9516_spi_sdio  (o_ad9516_spi_sdio),
    .i_ad9516_spi_sdo   (i_ad9516_spi_sdo)
);















endmodule
