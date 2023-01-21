onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /tb_module/opcode_i
add wave -noupdate -expand -group tb /tb_module/funct7_i
add wave -noupdate -expand -group tb /tb_module/funct3_i
add wave -noupdate -expand -group tb /tb_module/op1_data_i
add wave -noupdate -expand -group tb /tb_module/op2_data_i
add wave -noupdate -expand -group tb /tb_module/imm_i
add wave -noupdate -expand -group tb /tb_module/valid_result_o
add wave -noupdate -expand -group tb /tb_module/result_o
add wave -noupdate -expand -group tb /tb_module/clk
add wave -noupdate -expand -group tb /tb_module/reset_n
add wave -noupdate -expand -group tb /tb_module/valid_result_q
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/clk
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/reset_n
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/opcode_i
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/funct7_i
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/funct3_i
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/op1_data_i
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/op2_data_i
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/valid_result_o
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/result_o
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/state
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/op1_data_q
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/op2_data_q
add wave -noupdate -expand -group mult /tb_module/multiplier_inst/valid_instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {999050 ps} {999942 ps}
