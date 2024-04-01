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

##ioPin  J10bank
set_property PACKAGE_PIN T16 [get_ports {ioPin[0]}]
set_property PACKAGE_PIN U17 [get_ports {ioPin[1]}]
set_property PACKAGE_PIN V17 [get_ports {ioPin[2]}]
set_property PACKAGE_PIN V18 [get_ports {ioPin[3]}]
set_property PACKAGE_PIN T14 [get_ports {ioPin[4]}]
set_property PACKAGE_PIN T15 [get_ports {ioPin[5]}]
set_property PACKAGE_PIN U13 [get_ports {ioPin[6]}]
set_property PACKAGE_PIN N16 [get_ports {ioPin[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ioPin[0]}]
