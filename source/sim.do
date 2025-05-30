if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work deserializer.sv
vlog -work work queue.sv
vlog -work work module_top.sv
vlog -work work tb_module_top.sv


vsim -voptargs=+acc work.tb_module_top

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run 1ms