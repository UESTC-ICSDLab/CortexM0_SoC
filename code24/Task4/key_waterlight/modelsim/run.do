vlib work
vsim -voptargs=+acc -c work.CortexM0_SoC_vlg_tst
add wave "CortexM0_SoC_vlg_tst/i1/u_logic/HADDR"
add wave "CortexM0_SoC_vlg_tst/i1/u_logic/HWDATA"
add wave "CortexM0_SoC_vlg_tst/i1/LED"
add wave "CortexM0_SoC_vlg_tst/i1/LEDclk"
add wave "CortexM0_SoC_vlg_tst/i1/WaterLight_mode"
add wave "CortexM0_SoC_vlg_tst/i1/WaterLight_speed"
add wave "CortexM0_SoC_vlg_tst/i1/u_logic/vis_ipsr_o"
add wave "CortexM0_SoC_vlg_tst/i1/col"
add wave "CortexM0_SoC_vlg_tst/i1/IRQ"
add wave "CortexM0_SoC_vlg_tst/i1/u_logic/vis_pc_o" 
run 100ns
