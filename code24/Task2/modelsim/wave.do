onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/HADDR
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/HSIZE
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/HTRANS
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/HRDATA
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/vis_r0_o
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/vis_r1_o
add wave -noupdate -radix hexadecimal /CortexM0_SoC_vlg_tst/i1/u_logic/vis_pc_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
