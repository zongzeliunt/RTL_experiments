################################################################################
# VC707 Constraints File
# Sorted (except for FMC, fuck FMC) and human readable
# Author: Zongze Li
################################################################################
set_property PACKAGE_PIN E19 [get_ports clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_p]
set_property PACKAGE_PIN E18 [get_ports clk_n]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_n]

set_property -dict { PACKAGE_PIN AV40   IOSTANDARD LVCMOS18 }   [get_ports { rst }];
set_property -dict { PACKAGE_PIN AU36   IOSTANDARD LVCMOS18 }   [get_ports { tx }];
set_property -dict { PACKAGE_PIN AU33   IOSTANDARD LVCMOS18 }   [get_ports { rx }];

# LEDs
set_property PACKAGE_PIN AM39 [get_ports led_0]
set_property IOSTANDARD LVCMOS18 [get_ports led_0]
set_property PACKAGE_PIN AN39 [get_ports led_1]
set_property IOSTANDARD LVCMOS18 [get_ports led_1]
set_property PACKAGE_PIN AR37 [get_ports led_2]
set_property IOSTANDARD LVCMOS18 [get_ports led_2]
set_property PACKAGE_PIN AT37 [get_ports led_3]
set_property IOSTANDARD LVCMOS18 [get_ports led_3]

set_property PACKAGE_PIN AR35 [get_ports led_4]
set_property IOSTANDARD LVCMOS18 [get_ports led_4]
set_property PACKAGE_PIN AP41 [get_ports led_5]
set_property IOSTANDARD LVCMOS18 [get_ports led_5]
set_property PACKAGE_PIN AP42 [get_ports led_6]
set_property IOSTANDARD LVCMOS18 [get_ports led_6]
set_property PACKAGE_PIN AU39 [get_ports led_7]
set_property IOSTANDARD LVCMOS18 [get_ports led_7]



