##clk PL 50MCLK
set_property PACKAGE_PIN U18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
##RSTn PL Key1
set_property PACKAGE_PIN N15 [get_ports RSTn]
set_property IOSTANDARD LVCMOS33 [get_ports RSTn]
##DEBUGGER
set_property PACKAGE_PIN K14 [get_ports SWDIO]
set_property IOSTANDARD LVCMOS33 [get_ports SWDIO]
set_property PACKAGE_PIN H15 [get_ports SWCLK]
set_property IOSTANDARD LVCMOS33 [get_ports SWCLK]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets SWCLK]