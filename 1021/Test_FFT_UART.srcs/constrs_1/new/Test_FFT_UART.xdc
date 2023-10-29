###外部输入的时钟 需要约束时钟频率 占空比
create_clock -period 10.000 -name board_clk_100mhz [get_ports board_clk_100mhz]

set_property PACKAGE_PIN AA3 [get_ports board_clk_100mhz]
set_property IOSTANDARD LVCMOS15 [get_ports board_clk_100mhz]

set_property PACKAGE_PIN A13 [get_ports board_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports board_rst_n]

set_property PACKAGE_PIN U22 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

set_property PACKAGE_PIN V24 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]