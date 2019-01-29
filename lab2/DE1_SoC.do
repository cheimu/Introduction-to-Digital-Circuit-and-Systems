onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX2
add wave -noupdate /DE1_SoC_testbench/dut/HEX3
add wave -noupdate /DE1_SoC_testbench/dut/HEX4
add wave -noupdate /DE1_SoC_testbench/dut/HEX5
add wave -noupdate -expand /DE1_SoC_testbench/dut/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/KEY
add wave -noupdate -expand /DE1_SoC_testbench/dut/SW
add wave -noupdate /DE1_SoC_testbench/dut/BottomDigit
add wave -noupdate /DE1_SoC_testbench/dut/NextDigit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
configure wave -valuecolwidth 69
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
WaveRestoreZoom {0 ps} {105 ps}
