onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /testbench/clk
add wave -noupdate -expand -group TB /testbench/reset_n
add wave -noupdate -expand -group TB /testbench/input_dmem
add wave -noupdate -expand -group TB /testbench/input_imem
add wave -noupdate -group proc /testbench/proc/clk
add wave -noupdate -group proc /testbench/proc/reset_n
add wave -noupdate -group proc /testbench/proc/input_data_imem
add wave -noupdate -group proc /testbench/proc/input_data_dmem
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/clk
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/reset_n
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/pc_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/pc_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/take_br_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_valid_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_addr_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_rd_wr_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_op_en_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_rd_instr_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/stall_proc_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/pc
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/next_pc
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/op_rd
add wave -noupdate -group imem /testbench/proc/imem/clk
add wave -noupdate -group imem /testbench/proc/imem/reset_n
add wave -noupdate -group imem /testbench/proc/imem/addr
add wave -noupdate -group imem /testbench/proc/imem/op_en
add wave -noupdate -group imem /testbench/proc/imem/wr_data
add wave -noupdate -group imem /testbench/proc/imem/rd_data
add wave -noupdate -group imem /testbench/proc/imem/input_data
add wave -noupdate -group imem /testbench/proc/imem/memory
add wave -noupdate -divider DECODE
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/clk
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/reset_n
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/pc_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/pc_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/instr_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/instr_valid_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/wr_rd_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/wr_data_i
add wave -noupdate -expand -group decode -radix binary /testbench/proc/stage_decode_inst/ctrl_opcode_o
add wave -noupdate -expand -group decode -radix binary /testbench/proc/stage_decode_inst/ctrl_funct7_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_funct3_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs1_data_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs2_data_o
add wave -noupdate -expand -group decode -radix decimal /testbench/proc/stage_decode_inst/imm_se_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_op_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_ld_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_st_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_jm_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_br_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_ex_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_mem_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/stall_proc_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_op_q
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_d
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/dependency
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs1
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs2
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs1
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs2
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/clk
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/reset_n
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs1
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs2
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/reg_write
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/wr_rd
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/wr_data
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs1_data
add wave -noupdate -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs2_data
add wave -noupdate -group reg_file -childformat {{{/testbench/proc/stage_decode_inst/reg_file/registers[8]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[7]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[6]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[5]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[4]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[3]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[2]} -radix decimal}} -expand -subitemconfig {{/testbench/proc/stage_decode_inst/reg_file/registers[8]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[7]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[6]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[5]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[4]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[3]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[2]} {-height 17 -radix decimal}} /testbench/proc/stage_decode_inst/reg_file/registers
add wave -noupdate -divider ALU
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/clk
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/reset_n
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/pc_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/pc_br_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rd_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rd_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rd_dc_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_op_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_ld_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_ld_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_st_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_st_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_jm_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_jm_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_br_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_br_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_o
add wave -noupdate -group alu_stage -radix binary /testbench/proc/stage_ex_inst/ctrl_opcode_i
add wave -noupdate -group alu_stage -radix binary /testbench/proc/stage_ex_inst/ctrl_funct7_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_funct3_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/ctrl_mem_width_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rs1_data_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/imm_se_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/alu_result_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/alu_zero_o
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rs2_data_i
add wave -noupdate -group alu_stage /testbench/proc/stage_ex_inst/rs2_data_o
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/clk
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/reset_n
add wave -noupdate -group alu_stage -expand -group alu -radix binary /testbench/proc/stage_ex_inst/alu_inst/opcode_i
add wave -noupdate -group alu_stage -expand -group alu -radix binary /testbench/proc/stage_ex_inst/alu_inst/funct7_i
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/funct3_i
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/op1_data_i
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/op2_data_i
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/imm_se_i
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/zero_o
add wave -noupdate -group alu_stage -expand -group alu /testbench/proc/stage_ex_inst/alu_inst/result_o
add wave -noupdate -divider MEM
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/clk
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/reset_n
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/pc_br_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/pc_br_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/rd_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/rd_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/rd_dc_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/alu_result_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/alu_result_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/alu_zero_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/rs2_data_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/take_br_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_ld_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_ld_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_st_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_jm_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_br_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_mem_width_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_reg_write_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/ctrl_reg_write_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/dmem_addr_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/dmem_rd_wr_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/dmem_op_en_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/dmem_wr_data_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/dmem_rd_data_i
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/mem_data_o
add wave -noupdate -group mem_stage /testbench/proc/stage_mem_inst/mem_data_q
add wave -noupdate -group dmem /testbench/proc/dmem/clk
add wave -noupdate -group dmem /testbench/proc/dmem/reset_n
add wave -noupdate -group dmem /testbench/proc/dmem/addr
add wave -noupdate -group dmem /testbench/proc/dmem/op_rd_wr
add wave -noupdate -group dmem /testbench/proc/dmem/op_en
add wave -noupdate -group dmem /testbench/proc/dmem/wr_data
add wave -noupdate -group dmem /testbench/proc/dmem/rd_data
add wave -noupdate -group dmem /testbench/proc/dmem/input_data
add wave -noupdate -group dmem /testbench/proc/dmem/memory
add wave -noupdate -divider WB
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/clk
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/reset_n
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/alu_result_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/dmem_data_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/rd_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/rd_o
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_ld_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_reg_write_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_reg_write_o
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/wr_data_o
add wave -noupdate /testbench/IMEM_SIZE_BYTES
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{output fetch} {42000 ps} 1} {{Cursor 2} {55892 ps} 0}
quietly wave cursor active 2
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
configure wave -timelineunits ns
update
WaveRestoreZoom {29687 ps} {77841 ps}
