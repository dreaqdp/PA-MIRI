vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/testbench.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/PARAMS_pkg.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/alu.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/register_file.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/memory.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/stage_alu.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/stage_decode.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/stage_fetch.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/stage_mem.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/stage_write_back.sv
vlog -work work -vopt -sv /home/aquerol/Documents/miri/pa/PA-MIRI/src/hdl/proc.sv
vsim -voptargs=+acc work.testbench
do wave.do
