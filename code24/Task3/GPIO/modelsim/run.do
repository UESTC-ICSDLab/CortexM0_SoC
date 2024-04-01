vlib work
vsim -voptargs=+acc -c work.CortexM0_SoC_vlg_tst
add wave "CortexM0_SoC_vlg_tst/i1/HADDR"
add wave "CortexM0_SoC_vlg_tst/i1/ioPin"
add wave "CortexM0_SoC_vlg_tst/i1/iData"
add wave "CortexM0_SoC_vlg_tst/i1/oData"
add wave "CortexM0_SoC_vlg_tst/i1/outEn"
run 100ns

