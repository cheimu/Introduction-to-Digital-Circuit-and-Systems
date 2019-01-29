onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /centerLight_testbench/dut/Clock
add wave -noupdate /centerLight_testbench/dut/Reset
add wave -noupdate /centerLight_testbench/dut/L
add wave -noupdate /centerLight_testbench/dut/R
add wave -noupdate /centerLight_testbench/dut/NL
add wave -noupdate /centerLight_testbench/dut/NR
add wave -noupdate /centerLight_testbench/dut/ns
add wave -noupdate /centerLight_testbench/dut/lightOn
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
