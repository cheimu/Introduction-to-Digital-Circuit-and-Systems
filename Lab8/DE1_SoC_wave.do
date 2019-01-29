onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX2
add wave -noupdate /DE1_SoC_testbench/dut/HEX3
add wave -noupdate /DE1_SoC_testbench/dut/HEX4
add wave -noupdate /DE1_SoC_testbench/dut/HEX5
add wave -noupdate /DE1_SoC_testbench/dut/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/KEY
add wave -noupdate /DE1_SoC_testbench/dut/SW
add wave -noupdate /DE1_SoC_testbench/dut/L
add wave -noupdate /DE1_SoC_testbench/dut/R
add wave -noupdate /DE1_SoC_testbench/dut/w
add wave -noupdate /DE1_SoC_testbench/dut/cyberResult
add wave -noupdate /DE1_SoC_testbench/dut/reset
add wave -noupdate /DE1_SoC_testbench/dut/resetPlayfield
add wave -noupdate /DE1_SoC_testbench/dut/resetLight
add wave -noupdate /DE1_SoC_testbench/dut/num
add wave -noupdate /DE1_SoC_testbench/dut/randomNum
add wave -noupdate /DE1_SoC_testbench/dut/clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {550 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 189
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
WaveRestoreZoom {4749 ps} {5698 ps}
