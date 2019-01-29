onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /victory_testbench/dut/Clock
add wave -noupdate /victory_testbench/dut/Reset
add wave -noupdate /victory_testbench/dut/L
add wave -noupdate /victory_testbench/dut/R
add wave -noupdate /victory_testbench/dut/MostLeft
add wave -noupdate /victory_testbench/dut/MostRight
add wave -noupdate /victory_testbench/dut/ps
add wave -noupdate /victory_testbench/dut/ns
add wave -noupdate /victory_testbench/dut/psCyber
add wave -noupdate /victory_testbench/dut/nsCyber
add wave -noupdate /victory_testbench/dut/displayHuman
add wave -noupdate /victory_testbench/dut/displayCyber
add wave -noupdate /victory_testbench/dut/ResetPlayfield
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {4 ns} {5 ns}
