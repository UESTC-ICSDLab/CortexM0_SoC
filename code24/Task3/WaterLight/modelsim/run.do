vlib work
vsim -voptargs=+acc -c work.CortexM0_SoC_vlg_tst
add wave "CortexM0_SoC_vlg_tst/i1/HADDR"
add wave "CortexM0_SoC_vlg_tst/i1/WaterLight_mode "
add wave "CortexM0_SoC_vlg_tst/i1/WaterLight_speed "
add wave "CortexM0_SoC_vlg_tst/i1/LED "
add wave "CortexM0_SoC_vlg_tst/i1/HWDATA "
run 100ns

