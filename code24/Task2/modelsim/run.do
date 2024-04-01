vlib work 
vlog "C:/Users/13249/Desktop/Alinx/CortexM0_SoC-main/CortexM0_SoC-main/Task2/modelsim/CortexM0_SoC_vlg_tst.v" 
vlog "C:/Users/13249/Desktop/Alinx/CortexM0_SoC-main/CortexM0_SoC-main/Task2/rtl/*"
vsim -voptargs=+acc -c work.CortexM0_SoC_vlg_tst
add wave "CortexM0_SoC_vlg_tst/i1/u_logic/*"
run 100ns