vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/testbench.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/PARAMS_pkg.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/alu.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/register_file.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/memory.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/stage_ex.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/stage_decode.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/stage_fetch.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/stage_mem.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/stage_write_back.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/rtl/proc.sv
vsim -voptargs=+acc work.testbench
do wave.do
