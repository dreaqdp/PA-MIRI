vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/PARAMS_pkg.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/alu.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/alu/tb_module.sv
vsim -voptargs=+acc work.testbench
do wave.do
