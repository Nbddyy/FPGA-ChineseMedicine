

create_clock -period 4.00 -name ADC1_CLKOUTP[get_ports ADC1_CLKOUTP]
create_clock -period 4.00 -name ADC2_CLKOUTP[get_ports ADC2_CLKOUTP]






#######FIRST  ADC1

set_property PACKAGE_PIN F26 [get_ports {ADC1_DA_P[7]}]
set_property PACKAGE_PIN E26 [get_ports {ADC1_DA_M[7]}]
set_property PACKAGE_PIN G27 [get_ports {ADC1_DA_P[6]}]
set_property PACKAGE_PIN F27 [get_ports {ADC1_DA_M[6]}]
set_property PACKAGE_PIN C24 [get_ports {ADC1_DA_P[5]}]
set_property PACKAGE_PIN B24 [get_ports {ADC1_DA_M[5]}]
set_property PACKAGE_PIN F25 [get_ports {ADC1_DA_P[4]}]
set_property PACKAGE_PIN E25 [get_ports {ADC1_DA_M[4]}]
set_property PACKAGE_PIN E23 [get_ports {ADC1_DA_P[3]}]
set_property PACKAGE_PIN D23 [get_ports {ADC1_DA_M[3]}]
set_property PACKAGE_PIN E24 [get_ports {ADC1_DA_P[2]}]
set_property PACKAGE_PIN D24 [get_ports {ADC1_DA_M[2]}]
set_property PACKAGE_PIN H24 [get_ports {ADC1_DA_P[1]}]
set_property PACKAGE_PIN H25 [get_ports {ADC1_DA_M[1]}]
set_property PACKAGE_PIN G23 [get_ports {ADC1_DA_P[0]}]
set_property PACKAGE_PIN G24 [get_ports {ADC1_DA_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_P[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DA_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_M[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC1_DB_P[0]}]

set_property PACKAGE_PIN G29 [get_ports {ADC1_DB_P[7]}]
set_property PACKAGE_PIN F30 [get_ports {ADC1_DB_M[7]}]
set_property PACKAGE_PIN D29 [get_ports {ADC1_DB_P[6]}]
set_property PACKAGE_PIN C30 [get_ports {ADC1_DB_M[6]}]
set_property PACKAGE_PIN E28 [get_ports {ADC1_DB_P[5]}]
set_property PACKAGE_PIN D28 [get_ports {ADC1_DB_M[5]}]
set_property PACKAGE_PIN B30 [get_ports {ADC1_DB_P[4]}]
set_property PACKAGE_PIN A30 [get_ports {ADC1_DB_M[4]}]
set_property PACKAGE_PIN C29 [get_ports {ADC1_DB_P[3]}]
set_property PACKAGE_PIN B29 [get_ports {ADC1_DB_M[3]}]
set_property PACKAGE_PIN B27 [get_ports {ADC1_DB_P[2]}]
set_property PACKAGE_PIN A27 [get_ports {ADC1_DB_M[2]}]
set_property PACKAGE_PIN B28 [get_ports {ADC1_DB_P[1]}]
set_property PACKAGE_PIN A28 [get_ports {ADC1_DB_M[1]}]
set_property PACKAGE_PIN A25 [get_ports {ADC1_DB_P[0]}]
set_property PACKAGE_PIN A26 [get_ports {ADC1_DB_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports ADC1_CLKOUTM]
set_property IOSTANDARD LVDS_25 [get_ports ADC1_CLKOUTP]
set_property PACKAGE_PIN C25 [get_ports ADC1_CLKOUTP]
set_property PACKAGE_PIN B25 [get_ports ADC1_CLKOUTM]

set_property PACKAGE_PIN G13 [get_ports ADC1_RESET]
set_property PACKAGE_PIN A12 [get_ports ADC1_SCLK]
set_property PACKAGE_PIN A11 [get_ports ADC1_SDATA]
set_property PACKAGE_PIN L13 [get_ports ADC1_SDOUT]
set_property PACKAGE_PIN L12 [get_ports ADC1_SEN]

set_property IOSTANDARD LVCMOS25 [get_ports ADC1_RESET]
set_property IOSTANDARD LVCMOS25 [get_ports ADC1_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports ADC1_SDATA]
set_property IOSTANDARD LVCMOS25 [get_ports ADC1_SDOUT]
set_property IOSTANDARD LVCMOS25 [get_ports ADC1_SEN]




#######  ADC2

set_property PACKAGE_PIN A20 [get_ports {ADC2_DA_P[7]}]
set_property PACKAGE_PIN A21 [get_ports {ADC2_DA_M[7]}]
set_property PACKAGE_PIN H21 [get_ports {ADC2_DA_P[6]}]
set_property PACKAGE_PIN H22 [get_ports {ADC2_DA_M[6]}]
set_property PACKAGE_PIN E19 [get_ports {ADC2_DA_P[5]}]
set_property PACKAGE_PIN D19 [get_ports {ADC2_DA_M[5]}]
set_property PACKAGE_PIN J19 [get_ports {ADC2_DA_P[4]}]
set_property PACKAGE_PIN H19 [get_ports {ADC2_DA_M[4]}]
set_property PACKAGE_PIN G18 [get_ports {ADC2_DA_P[3]}]
set_property PACKAGE_PIN F18 [get_ports {ADC2_DA_M[3]}]
set_property PACKAGE_PIN K18 [get_ports {ADC2_DA_P[2]}]
set_property PACKAGE_PIN J18 [get_ports {ADC2_DA_M[2]}]
set_property PACKAGE_PIN J17 [get_ports {ADC2_DA_P[1]}]
set_property PACKAGE_PIN H17 [get_ports {ADC2_DA_M[1]}]
set_property PACKAGE_PIN K19 [get_ports {ADC2_DA_P[0]}]
set_property PACKAGE_PIN K20 [get_ports {ADC2_DA_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_P[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DA_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_M[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ADC2_DB_P[0]}]

set_property PACKAGE_PIN D22 [get_ports {ADC2_DB_P[7]}]
set_property PACKAGE_PIN C22 [get_ports {ADC2_DB_M[7]}]
set_property PACKAGE_PIN C20 [get_ports {ADC2_DB_P[6]}]
set_property PACKAGE_PIN B20 [get_ports {ADC2_DB_M[6]}]
set_property PACKAGE_PIN D21 [get_ports {ADC2_DB_P[5]}]
set_property PACKAGE_PIN C21 [get_ports {ADC2_DB_M[5]}]
set_property PACKAGE_PIN B18 [get_ports {ADC2_DB_P[4]}]
set_property PACKAGE_PIN A18 [get_ports {ADC2_DB_M[4]}]
set_property PACKAGE_PIN C19 [get_ports {ADC2_DB_P[3]}]
set_property PACKAGE_PIN B19 [get_ports {ADC2_DB_M[3]}]
set_property PACKAGE_PIN D16 [get_ports {ADC2_DB_P[2]}]
set_property PACKAGE_PIN C16 [get_ports {ADC2_DB_M[2]}]
set_property PACKAGE_PIN C17 [get_ports {ADC2_DB_P[1]}]
set_property PACKAGE_PIN B17 [get_ports {ADC2_DB_M[1]}]
set_property PACKAGE_PIN A16 [get_ports {ADC2_DB_P[0]}]
set_property PACKAGE_PIN A17 [get_ports {ADC2_DB_M[0]}]

set_property IOSTANDARD LVDS_25 [get_ports ADC2_CLKOUTM]
set_property IOSTANDARD LVDS_25 [get_ports ADC2_CLKOUTP]
set_property PACKAGE_PIN F20 [get_ports ADC2_CLKOUTP]
set_property PACKAGE_PIN E20 [get_ports ADC2_CLKOUTM]



set_property PACKAGE_PIN F12 [get_ports ADC2_RESET]
set_property PACKAGE_PIN E11 [get_ports ADC2_SCLK]
set_property PACKAGE_PIN F11 [get_ports ADC2_SDATA]
set_property PACKAGE_PIN J12 [get_ports ADC2_SDOUT]
set_property PACKAGE_PIN J11 [get_ports ADC2_SEN]

set_property IOSTANDARD LVCMOS25 [get_ports ADC2_RESET]
set_property IOSTANDARD LVCMOS25 [get_ports ADC2_SCLK]
set_property IOSTANDARD LVCMOS25 [get_ports ADC2_SDATA]
set_property IOSTANDARD LVCMOS25 [get_ports ADC2_SDOUT]
set_property IOSTANDARD LVCMOS25 [get_ports ADC2_SEN]



#压缩VIVADO bit文件，并加速
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 66 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

#FPGA的晶振
set_property -dict {PACKAGE_PIN AG10 IOSTANDARD LVDS} [get_ports clk_in1_p]
create_clock -period 5 -name clk_in1_p [get_ports clk_in1_p]



#hmc830
set_property PACKAGE_PIN Y21 [get_ports hmc830_sck_spi]
set_property PACKAGE_PIN G15 [get_ports hmc830_sdi_spi]
set_property PACKAGE_PIN H15 [get_ports hmc830_sen_spi]
#set_property PACKAGE_PIN AA21 [get_ports sdo_spi]
set_property IOSTANDARD LVCMOS25 [get_ports hmc830_sck_spi]
set_property IOSTANDARD LVCMOS25 [get_ports hmc830_sdi_spi]
set_property IOSTANDARD LVCMOS25 [get_ports hmc830_sen_spi]

#时钟扇出缓存器
set_property PACKAGE_PIN D11 [get_ports clk_sel2]
set_property IOSTANDARD LVCMOS25 [get_ports clk_sel2]

#2AD同步信号,注意他是单端信号不是差分
###set_property PACKAGE_PIN E29 [get_ports SYNCIN_AD1_P]
###set_property IOSTANDARD LVCMOS25 [get_ports SYNCIN_AD1_P]
###set_property PACKAGE_PIN E30 [get_ports SYNCIN_AD1_N]
###set_property IOSTANDARD LVCMOS25 [get_ports SYNCIN_AD1_N]
###
###set_property PACKAGE_PIN F21 [get_ports SYNCIN_AD2_P]
###set_property IOSTANDARD LVCMOS25 [get_ports SYNCIN_AD2_P]
###set_property PACKAGE_PIN E21 [get_ports SYNCIN_AD2_N]
###set_property IOSTANDARD LVCMOS25 [get_ports SYNCIN_AD2_N]














