onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /testbench/clk
add wave -noupdate -expand -group TB /testbench/reset_n
add wave -noupdate -expand -group TB /testbench/input_dmem
add wave -noupdate -expand -group TB /testbench/input_imem
add wave -noupdate /testbench/proc/clk
add wave -noupdate /testbench/proc/reset_n
add wave -noupdate -expand -group fetch /testbench/proc/fetch/clk
add wave -noupdate -expand -group fetch /testbench/proc/fetch/reset_n
add wave -noupdate -expand -group fetch /testbench/proc/fetch/pc_i
add wave -noupdate -expand -group fetch /testbench/proc/fetch/pc_o
add wave -noupdate -expand -group fetch /testbench/proc/fetch/instr_jm
add wave -noupdate -expand -group fetch /testbench/proc/fetch/instr
add wave -noupdate -expand -group fetch /testbench/proc/fetch/rd_pc
add wave -noupdate -expand -group fetch /testbench/proc/fetch/rd_wr
add wave -noupdate -expand -group fetch /testbench/proc/fetch/op_en
add wave -noupdate -expand -group fetch /testbench/proc/fetch/rd_instr
add wave -noupdate -expand -group fetch /testbench/proc/fetch/pc
add wave -noupdate -expand -group fetch /testbench/proc/fetch/op_rd
add wave -noupdate -expand -group imem /testbench/proc/imem/clk
add wave -noupdate -expand -group imem /testbench/proc/imem/reset_n
add wave -noupdate -expand -group imem /testbench/proc/imem/addr
add wave -noupdate -expand -group imem /testbench/proc/imem/rd_wr
add wave -noupdate -expand -group imem /testbench/proc/imem/op_en
add wave -noupdate -expand -group imem /testbench/proc/imem/wr_data
add wave -noupdate -expand -group imem /testbench/proc/imem/rd_data
add wave -noupdate -expand -group imem /testbench/proc/imem/input_data
add wave -noupdate -expand -group imem /testbench/proc/imem/memory
add wave -noupdate -group decode /testbench/proc/decode/clk
add wave -noupdate -group decode /testbench/proc/decode/reset_n
add wave -noupdate -group decode /testbench/proc/decode/pc_i
add wave -noupdate -group decode /testbench/proc/decode/pc_o
add wave -noupdate -group decode /testbench/proc/decode/instr
add wave -noupdate -group decode /testbench/proc/decode/wr_rd
add wave -noupdate -group decode /testbench/proc/decode/wr_data
add wave -noupdate -group decode /testbench/proc/decode/opcode
add wave -noupdate -group decode /testbench/proc/decode/funct7
add wave -noupdate -group decode /testbench/proc/decode/funct3
add wave -noupdate -group decode /testbench/proc/decode/rs1_data
add wave -noupdate -group decode /testbench/proc/decode/rs2_data
add wave -noupdate -group decode /testbench/proc/decode/imm_se
add wave -noupdate -group decode /testbench/proc/decode/rd
add wave -noupdate -group decode /testbench/proc/decode/rs1
add wave -noupdate -group decode /testbench/proc/decode/rs2
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/clk
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/reset_n
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/rs1
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/rs2
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/wr_rd
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/wr_data
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/rs1_data
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/rs2_data
add wave -noupdate -group reg_file /testbench/proc/decode/reg_file/registers
add wave -noupdate -group alu_stage /testbench/proc/alu/clk
add wave -noupdate -group alu_stage /testbench/proc/alu/reset_n
add wave -noupdate -group alu_stage /testbench/proc/alu/pc_i
add wave -noupdate -group alu_stage /testbench/proc/alu/pc_o
add wave -noupdate -group alu_stage /testbench/proc/alu/rd_i
add wave -noupdate -group alu_stage /testbench/proc/alu/rd_o
add wave -noupdate -group alu_stage /testbench/proc/alu/instr_op_o
add wave -noupdate -group alu_stage /testbench/proc/alu/instr_ld_o
add wave -noupdate -group alu_stage /testbench/proc/alu/instr_st_o
add wave -noupdate -group alu_stage /testbench/proc/alu/instr_jm_o
add wave -noupdate -group alu_stage /testbench/proc/alu/instr_br_o
add wave -noupdate -group alu_stage /testbench/proc/alu/opcode_i
add wave -noupdate -group alu_stage /testbench/proc/alu/funct7
add wave -noupdate -group alu_stage /testbench/proc/alu/funct3
add wave -noupdate -group alu_stage /testbench/proc/alu/rs1_data
add wave -noupdate -group alu_stage /testbench/proc/alu/imm_se
add wave -noupdate -group alu_stage /testbench/proc/alu/alu_result
add wave -noupdate -group alu_stage /testbench/proc/alu/alu_zero
add wave -noupdate -group alu_stage /testbench/proc/alu/rs2_data_i
add wave -noupdate -group alu_stage /testbench/proc/alu/rs2_data_o
add wave -noupdate -group alu_stage /testbench/proc/alu/op2_data
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/clk
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/reset_n
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/opcode
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/funct7
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/funct3
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/op1_data
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/op2_data
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/zero
add wave -noupdate -group alu_stage -group alu /testbench/proc/alu/alu/result
add wave -noupdate -group mem /testbench/proc/mem/clk
add wave -noupdate -group mem /testbench/proc/mem/reset_n
add wave -noupdate -group mem /testbench/proc/mem/pc_i
add wave -noupdate -group mem /testbench/proc/mem/pc_o
add wave -noupdate -group mem /testbench/proc/mem/rd_i
add wave -noupdate -group mem /testbench/proc/mem/rd_o
add wave -noupdate -group mem /testbench/proc/mem/alu_result_i
add wave -noupdate -group mem /testbench/proc/mem/alu_result_o
add wave -noupdate -group mem /testbench/proc/mem/alu_zero
add wave -noupdate -group mem /testbench/proc/mem/rs2_data_i
add wave -noupdate -group mem /testbench/proc/mem/instr_op_i
add wave -noupdate -group mem /testbench/proc/mem/instr_ld_i
add wave -noupdate -group mem /testbench/proc/mem/instr_ld_o
add wave -noupdate -group mem /testbench/proc/mem/instr_st_i
add wave -noupdate -group mem /testbench/proc/mem/instr_jm_i
add wave -noupdate -group mem /testbench/proc/mem/instr_jm_o
add wave -noupdate -group mem /testbench/proc/mem/instr_br_i
add wave -noupdate -group mem /testbench/proc/mem/instr_br_o
add wave -noupdate -group mem /testbench/proc/mem/addr
add wave -noupdate -group mem /testbench/proc/mem/rd_wr
add wave -noupdate -group mem /testbench/proc/mem/op_en
add wave -noupdate -group mem /testbench/proc/mem/wr_data
add wave -noupdate -group mem /testbench/proc/mem/rd_data_i
add wave -noupdate -group mem /testbench/proc/mem/rd_data_o
add wave -noupdate -group mem /testbench/proc/mem/op_wr
add wave -noupdate -group dmem /testbench/proc/dmem/MEM_SIZE_BITS
add wave -noupdate -group dmem /testbench/proc/dmem/MEM_SIZE_BYTES
add wave -noupdate -group dmem /testbench/proc/dmem/INPUT_SIZE
add wave -noupdate -group dmem /testbench/proc/dmem/clk
add wave -noupdate -group dmem /testbench/proc/dmem/reset_n
add wave -noupdate -group dmem /testbench/proc/dmem/addr
add wave -noupdate -group dmem /testbench/proc/dmem/rd_wr
add wave -noupdate -group dmem /testbench/proc/dmem/op_en
add wave -noupdate -group dmem /testbench/proc/dmem/wr_data
add wave -noupdate -group dmem /testbench/proc/dmem/rd_data
add wave -noupdate -group dmem /testbench/proc/dmem/input_data
add wave -noupdate -group dmem /testbench/proc/dmem/memory
add wave -noupdate -group write_back /testbench/proc/write_back/clk
add wave -noupdate -group write_back /testbench/proc/write_back/reset_n
add wave -noupdate -group write_back /testbench/proc/write_back/alu_result_i
add wave -noupdate -group write_back /testbench/proc/write_back/mem_data
add wave -noupdate -group write_back /testbench/proc/write_back/rd_i
add wave -noupdate -group write_back /testbench/proc/write_back/rd_o
add wave -noupdate -group write_back /testbench/proc/write_back/instr_ld_i
add wave -noupdate -group write_back /testbench/proc/write_back/instr_jm_i
add wave -noupdate -group write_back /testbench/proc/write_back/instr_jm_o
add wave -noupdate -group write_back /testbench/proc/write_back/instr_br_i
add wave -noupdate -group write_back /testbench/proc/write_back/instr_br_o
add wave -noupdate -group write_back /testbench/proc/write_back/wr_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {42000 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {32179 ps} {96325 ps}
