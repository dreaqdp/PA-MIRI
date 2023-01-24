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
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_valid_dc_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_valid_ex_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_addr_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_rd_wr_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_op_en_o
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/imem_rd_instr_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/stall_proc_i
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/pc_fetch
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/next_pc
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/pc
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/kill
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_valid_q
add wave -noupdate -expand -group fetch /testbench/proc/stage_fetch_inst/instr_valid_d
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
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_ml_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_ld_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_st_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_jm_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_br_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_ml_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_ex_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_mem_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_m0_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_m1_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_m2_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_m3_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rd_m4_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/bypass_mem_data_mem_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/bypass_ctrl_reg_write_mem_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/bypass_result_alu_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/bypass_ctrl_reg_write_alu_i
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/stall_proc_if_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/stall_proc_ex_o
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_op_q
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_ml_q
add wave -noupdate -expand -group decode -radix binary /testbench/proc/stage_decode_inst/funct7_q
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_d
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/ctrl_reg_write_ml_d
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/dependency
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs1
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/rs2
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/diff_instr_types
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs1_mult
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs2_mult
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs1
add wave -noupdate -expand -group decode /testbench/proc/stage_decode_inst/match_rs2
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/clk
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/reset_n
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs1
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs2
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/reg_write
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/wr_rd
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/wr_data
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs1_data
add wave -noupdate -expand -group reg_file /testbench/proc/stage_decode_inst/reg_file/rs2_data
add wave -noupdate -expand -group reg_file -childformat {{{/testbench/proc/stage_decode_inst/reg_file/registers[8]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[7]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[6]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[5]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[4]} -radix decimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[3]} -radix hexadecimal} {{/testbench/proc/stage_decode_inst/reg_file/registers[2]} -radix decimal}} -expand -subitemconfig {{/testbench/proc/stage_decode_inst/reg_file/registers[8]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[7]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[6]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[5]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[4]} {-height 17 -radix decimal} {/testbench/proc/stage_decode_inst/reg_file/registers[3]} {-height 17 -radix hexadecimal} {/testbench/proc/stage_decode_inst/reg_file/registers[2]} {-height 17 -radix decimal}} /testbench/proc/stage_decode_inst/reg_file/registers
add wave -noupdate -divider ALU
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/clk
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/reset_n
add wave -noupdate -expand -group alu_stage -group alu -radix binary /testbench/proc/stage_ex_inst/alu_inst/opcode_i
add wave -noupdate -expand -group alu_stage -group alu -radix binary /testbench/proc/stage_ex_inst/alu_inst/funct7_i
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/funct3_i
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/op1_data_i
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/op2_data_i
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/imm_se_i
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/cmp_o
add wave -noupdate -expand -group alu_stage -group alu /testbench/proc/stage_ex_inst/alu_inst/result_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/clk
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/reset_n
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/pc_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/pc_br_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rd_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rd_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rd_dc_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_op_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_ld_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_ld_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_st_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_st_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_jm_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_jm_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_br_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_br_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_o
add wave -noupdate -expand -group alu_stage -radix binary /testbench/proc/stage_ex_inst/ctrl_opcode_i
add wave -noupdate -expand -group alu_stage -radix binary /testbench/proc/stage_ex_inst/ctrl_funct7_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_funct3_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_mem_width_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_valid_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/stall_proc_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/stall_proc_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rs1_data_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/imm_se_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/bypass_result_alu_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/bypass_ctrl_reg_write_alu_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/alu_result_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/alu_cmp_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rs2_data_i
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/rs2_data_o
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_q
add wave -noupdate -expand -group alu_stage /testbench/proc/stage_ex_inst/ctrl_reg_write_d
add wave -noupdate -divider MULT
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/clk
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/reset_n
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/funct7_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/funct7_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/funct3_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/funct3_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op1_data_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op1_data_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op2_data_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/op2_data_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/rd_i
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/rd_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/valid_result_o
add wave -noupdate -expand -group mult_stage -group m0 /testbench/proc/m0_inst/result_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/clk
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/reset_n
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/funct7_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/funct7_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/funct3_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/funct3_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op1_data_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op1_data_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op2_data_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/op2_data_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/rd_i
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/rd_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/valid_result_o
add wave -noupdate -expand -group mult_stage -group m1 /testbench/proc/m1_inst/result_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/clk
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/reset_n
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/funct7_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/funct7_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/funct3_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/funct3_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op1_data_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op1_data_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op2_data_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/op2_data_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/rd_i
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/rd_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/valid_result_o
add wave -noupdate -expand -group mult_stage -group m2 /testbench/proc/m2_inst/result_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/clk
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/reset_n
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/funct7_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/funct7_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/funct3_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/funct3_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op1_data_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op1_data_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op2_data_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/op2_data_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/rd_i
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/rd_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/valid_result_o
add wave -noupdate -expand -group mult_stage -group m3 /testbench/proc/m3_inst/result_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/clk
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/reset_n
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/funct7_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/funct7_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/funct3_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/funct3_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op1_data_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op1_data_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op2_data_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op2_data_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/rd_i
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/rd_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/valid_result_o
add wave -noupdate -expand -group mult_stage -expand -group m4 -radix decimal /testbench/proc/m4_inst/result_o
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/mult_result_s
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/mult_result_su
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/mult_result_u
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op1_s
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op2_s
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op1_u
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/op2_u
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/valid_result_d
add wave -noupdate -expand -group mult_stage -expand -group m4 /testbench/proc/m4_inst/result_d
add wave -noupdate -divider MEM
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/clk
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/reset_n
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/pc_br_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/pc_br_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/rd_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/rd_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/rd_dc_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/alu_result_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/alu_result_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/alu_cmp_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/rs2_data_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/take_br_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_ld_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_ld_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_st_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_jm_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_br_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_mem_width_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_reg_write_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/ctrl_reg_write_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/stall_proc_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/bypass_mem_data_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/bypass_ctrl_reg_write_mem_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_addr_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_rd_wr_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_op_en_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_wr_data_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_wr_keep_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_rd_data_i
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/mem_data_o
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/mem_data_q
add wave -noupdate -expand -group mem_stage /testbench/proc/stage_mem_inst/dmem_wr_keep_d
add wave -noupdate -group dmem /testbench/proc/dmem/clk
add wave -noupdate -group dmem /testbench/proc/dmem/reset_n
add wave -noupdate -group dmem /testbench/proc/dmem/addr
add wave -noupdate -group dmem /testbench/proc/dmem/op_rd_wr
add wave -noupdate -group dmem /testbench/proc/dmem/op_en
add wave -noupdate -group dmem /testbench/proc/dmem/wr_data
add wave -noupdate -group dmem /testbench/proc/dmem/wr_keep
add wave -noupdate -group dmem /testbench/proc/dmem/rd_data
add wave -noupdate -group dmem /testbench/proc/dmem/wr_data_keep
add wave -noupdate -group dmem /testbench/proc/dmem/mem_data
add wave -noupdate -group dmem /testbench/proc/dmem/memory
add wave -noupdate -divider WB
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/clk
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/reset_n
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/alu_result_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/dmem_data_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/mult_result_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/mult_valid_result_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/rd_mem_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/rd_mult_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/rd_o
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_ld_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_reg_write_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_reg_write_ml_i
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/ctrl_reg_write_o
add wave -noupdate -group write_back_stage /testbench/proc/stage_write_back_inst/wr_data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{output fetch} {42000 ps} 1} {{Cursor 2} {51979 ps} 0}
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
WaveRestoreZoom {35374 ps} {96212 ps}
