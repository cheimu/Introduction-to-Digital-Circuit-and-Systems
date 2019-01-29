onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /userInput_testbench/dut/Reset
add wave -noupdate /userInput_testbench/dut/Clock
add wave -noupdate /userInput_testbench/dut/Input
add wave -noupdate /userInput_testbench/dut/Input1
add wave -noupdate /userInput_testbench/dut/Input2
add wave -noupdate /userInput_testbench/dut/ps
add wave -noupdate /userInput_testbench/dut/ns
add wave -noupdate /userInput_testbench/dut/ignoredValue
add wave -noupdate /userInput_testbench/dut/out
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
