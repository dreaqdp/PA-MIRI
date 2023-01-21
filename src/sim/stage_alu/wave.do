onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group tb /tb_module/clk
add wave -noupdate -group tb /tb_module/reset_n
add wave -noupdate -group tb /tb_module/pc_i
add wave -noupdate -group tb /tb_module/pc_o
add wave -noupdate -group tb /tb_module/rd_i
add wave -noupdate -group tb /tb_module/rd_dc_o
add wave -noupdate -group tb /tb_module/rd_o
add wave -noupdate -group tb /tb_module/ctrl_op_i
add wave -noupdate -group tb /tb_module/ctrl_ld_i
add wave -noupdate -group tb /tb_module/ctrl_st_i
add wave -noupdate -group tb /tb_module/ctrl_jm_i
add wave -noupdate -group tb /tb_module/ctrl_br_i
add wave -noupdate -group tb /tb_module/ctrl_reg_write_i
add wave -noupdate -group tb /tb_module/ctrl_ld_o
add wave -noupdate -group tb /tb_module/ctrl_st_o
add wave -noupdate -group tb /tb_module/ctrl_jm_o
add wave -noupdate -group tb /tb_module/ctrl_br_o
add wave -noupdate -group tb /tb_module/ctrl_reg_write_o
add wave -noupdate -group tb /tb_module/opcode_i
add wave -noupdate -group tb /tb_module/funct7_i
add wave -noupdate -group tb /tb_module/funct3_i
add wave -noupdate -group tb /tb_module/rs1_data_i
add wave -noupdate -group tb /tb_module/rs2_data_i
add wave -noupdate -group tb /tb_module/rs2_data_o
add wave -noupdate -group tb /tb_module/imm_se_i
add wave -noupdate -group tb /tb_module/alu_zero_o
add wave -noupdate -group tb /tb_module/alu_result_o
add wave -noupdate -group tb /tb_module/tb_test_name
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/clk
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/reset_n
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/pc_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/pc_br_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rd_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rd_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rd_dc_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_op_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_ld_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_ld_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_st_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_st_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_jm_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_jm_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_br_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_br_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_reg_write_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_reg_write_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_opcode_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_funct7_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_funct3_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rs1_data_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/imm_se_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/alu_result_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/alu_zero_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rs2_data_i
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rs2_data_o
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/op2_data
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/alu_result_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/alu_result_d
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/mul_result_d
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rs2_data_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/rd_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/alu_zero_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/mult_valid_result_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_ld_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_st_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_jm_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_br_q
add wave -noupdate -expand -group stage_alu /tb_module/stage_alu_inst/ctrl_reg_write_q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {203621 ps} 0}
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
WaveRestoreZoom {201685 ps} {205325 ps}
