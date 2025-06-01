onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label reset /tb_module_top/reset
add wave -noupdate -color Red -label {clock 1mhz} /tb_module_top/clock
add wave -noupdate -color {Spring Green} -label {clk 100khz} -radix binary -radixshowbase 0 /tb_module_top/main/clock_100KHZ
add wave -noupdate -color Yellow -label {clock 10khz} -radix binary -radixshowbase 0 /tb_module_top/main/clock_10KHZ
add wave -noupdate label dequeue_in /tb_module_top/dequeue_in
add wave -noupdate -label data_out -radix binary /tb_module_top/data_out
add wave -noupdate -label len_out -radix decimal /tb_module_top/len_out
add wave -noupdate -label status /tb_module_top/status
add wave -noupdate -label write_in /tb_module_top/write_in
add wave -noupdate -label data_in /tb_module_top/data_in
add wave -noupdate -label entrada_queue /tb_module_top/main/entrada_queue
add wave -noupdate -label enable_queue /tb_module_top/main/enable_queue
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6347200 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
