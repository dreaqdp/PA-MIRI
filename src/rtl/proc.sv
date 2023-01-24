`timescale 1ns/1ps
import PARAMS_pkg::*;

module proc #(
    parameter INPUT_DMEM = 32*4,
    parameter INPUT_IMEM = 32*4
) (
    input clk,
    input reset_n,
    input [INPUT_DMEM-1:0][7:0] input_data_dmem,
    input [INPUT_IMEM-1:0][7:0] input_data_imem
);


wire [INSTR_SIZE-1:0] pc_if_id, pc_mem_if, pc_id_ex, pc_ex_mem;
wire [WD_SIZE-1:0] addr_imem, addr_dmem, wr_data_dmem, wr_keep_dmem, rd_data_mem;
wire [INSTR_REG_SIZE-1:0] rd_id_ex, rd_ex_mem, rd_mem_wb, rd_wb_id, rd_mem_dc, rd_ex_dc, rd_ml_dc_ml, rd_ml_ml_wb;
wire ctrl_op_dc_ex, ctrl_op_ex_mem;
wire ctrl_ld_dc_ex, ctrl_ld_ex_mem, ctrl_ld_mem_wb;
wire ctrl_st_dc_ex, ctrl_st_ex_mem;
wire ctrl_jm_dc_ex, ctrl_jm_ex_mem, ctrl_jm_mem_wb, ctrl_jm_wb_if;
wire ctrl_br_dc_ex, ctrl_br_ex_mem, ctrl_br_mem_wb, ctrl_br_wb_if;
wire ctrl_reg_write_dc_ex, ctrl_reg_write_ex_mem, ctrl_reg_write_mem_wb, ctrl_reg_write_wb_dc;

wire [OPCODE_SIZE-1:0] ctrl_opcode_id_ex;
wire [FUNCT7_SIZE-1:0] ctrl_funct7_id_ex;
wire [FUNCT3_SIZE-1:0] ctrl_funct3_id_ex, ctrl_mem_width_ex_mem;
wire [WD_SIZE-1:0] rs1_data_id_ex, rs2_data_id_ex, rs2_data_ex_mem;
wire [WD_SIZE-1:0] imm_se_id_ex;
wire [WD_SIZE-1:0] rd_data_wb_id, rd_data_mem_wb;
wire [WD_SIZE-1:0] alu_result_ex_mem, alu_result_mem_wb;
wire alu_cmp_ex_mem;
wire [WD_SIZE-1:0] rd_instr;
wire [INSTR_SIZE-1:0] instr;
wire op_en_pc, op_en_dmem;
wire rd_wr_dmem, op_rd_pc;
wire take_br_mem_if;
wire stall_proc_dc_if, stall_proc_dc_ex, stall_proc_ex_mem;
wire instr_valid_if_ex, instr_valid_if_dc;

wire [WD_SIZE-1:0] mult_result_m_wb;
wire mult_valid_result_m_wb, ctrl_reg_write_ml_wb, ctrl_reg_write_dc_ml, mult_in_flight_ml_dc;
wire op_m0_m1, op_m1_m2, op_m2_m3, op_m3_m4;
wire [FUNCT7_SIZE-1:0] funct7_m0_m1, funct7_m1_m2, funct7_m2_m3, funct7_m3_m4;
wire [FUNCT3_SIZE-1:0] funct3_m0_m1, funct3_m1_m2, funct3_m2_m3, funct3_m3_m4;
wire [WD_SIZE-1:0] op1_data_m0_m1, op1_data_m1_m2, op1_data_m2_m3, op1_data_m3_m4;
wire [WD_SIZE-1:0] op2_data_m0_m1, op2_data_m1_m2, op2_data_m2_m3, op2_data_m3_m4;
wire ctrl_reg_write_m0_m1, ctrl_reg_write_m1_m2, ctrl_reg_write_m2_m3, ctrl_reg_write_m3_m4;
wire [INSTR_REG_SIZE-1:0] rd_m0_m1, rd_m1_m2, rd_m2_m3, rd_m3_m4;


stage_fetch #() stage_fetch_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_mem_if),
    .pc_o (pc_if_id),
    /* .ctrl_jm (ctrl_jm_mem_wb), */
    .take_br_i (take_br_mem_if),
    .instr_o (instr),
    .instr_valid_dc_o (instr_valid_if_dc),
    .instr_valid_ex_o (instr_valid_if_ex),
    .imem_addr_o (addr_imem),
    .imem_rd_wr_o (op_rd_pc),
    .imem_op_en_o (op_en_pc),
    .imem_rd_instr_i (rd_instr),
    .stall_proc_i (stall_proc_dc_if)
);

memory #(
    .MEM_SIZE_BITS (INPUT_IMEM*8), // should be greater, at least 4096 
    .INPUT_SIZE (INPUT_IMEM)
) imem (
    .clk (clk),
    .reset_n (reset_n),
    .addr (addr_imem),
    .op_rd_wr (op_rd_pc),
    .op_en (op_en_pc),
    .wr_data ({{WD_SIZE}{1'b0}}),
    .rd_data (rd_instr),
    .input_data (input_data_imem)
);


wire [WD_SIZE-1:0] bypass_mem_data_mem_dc, bypass_result_alu_dc, bypass_ml_data_ml_dc;
wire bypass_ctrl_reg_write_mem_dc, bypass_ctrl_reg_write_alu_dc, bypass_ctrl_reg_write_ml_dc;
stage_decode #() stage_decode_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_if_id),
    .pc_o (pc_id_ex),
    .instr_i (instr),
    .instr_valid_i (instr_valid_if_dc),
    .wr_rd_i (rd_wb_id),
    .wr_data_i (rd_data_wb_id),
    .ctrl_opcode_o (ctrl_opcode_id_ex),
    .ctrl_funct7_o (ctrl_funct7_id_ex),
    .ctrl_funct3_o (ctrl_funct3_id_ex),
    .rs1_data_o (rs1_data_id_ex),
    .rs2_data_o (rs2_data_id_ex),
    .imm_se_o (imm_se_id_ex),
    .rd_o (rd_id_ex),
    .ctrl_op_o (ctrl_op_dc_ex),
    .ctrl_ml_o (ctrl_ml_dc_ml),
    .ctrl_ld_o (ctrl_ld_dc_ex),
    .ctrl_st_o (ctrl_st_dc_ex),
    .ctrl_jm_o (ctrl_jm_dc_ex),
    .ctrl_br_o (ctrl_br_dc_ex),
    .ctrl_reg_write_o (ctrl_reg_write_dc_ex),
    .ctrl_reg_write_ml_o (ctrl_reg_write_dc_ml),
    .ctrl_reg_write_i (ctrl_reg_write_wb_dc),
    .rd_ex_i (rd_ex_dc),
    .rd_mem_i (rd_mem_dc),
    .rd_m0_i (rd_m0_m1),
    .rd_m1_i (rd_m1_m2),
    .rd_m2_i (rd_m2_m3),
    .rd_m3_i (rd_m3_m4),
    .rd_m4_i (rd_ml_ml_wb),
    .bypass_mem_data_mem_i (bypass_mem_data_mem_dc),
    .bypass_ctrl_reg_write_mem_i (bypass_ctrl_reg_write_mem_dc),
    .bypass_ctrl_reg_write_alu_i (bypass_ctrl_reg_write_alu_dc),
    .bypass_result_alu_i (bypass_result_alu_dc),
    .bypass_result_ml_i (bypass_ml_data_ml_dc),
    .bypass_ctrl_reg_write_ml_i (bypass_ctrl_reg_write_ml_dc),
    .stall_proc_if_o (stall_proc_dc_if),
    .stall_proc_ex_o (stall_proc_dc_ex)
);

stage_ex #() stage_ex_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_id_ex),
    .pc_br_o (pc_ex_mem),
    .rd_i (rd_id_ex),
    .rd_dc_o (rd_ex_dc),
    .rd_o (rd_ex_mem),
    .ctrl_valid_i (instr_valid_if_ex),
    .ctrl_op_i (ctrl_op_dc_ex),
    .ctrl_ld_i (ctrl_ld_dc_ex),
    .ctrl_st_i (ctrl_st_dc_ex),
    .ctrl_jm_i (ctrl_jm_dc_ex),
    .ctrl_br_i (ctrl_br_dc_ex),
    .ctrl_reg_write_i (ctrl_reg_write_dc_ex),
    /* .ctrl_op_o (ctrl_op_ex_mem), */
    .ctrl_ld_o (ctrl_ld_ex_mem),
    .ctrl_st_o (ctrl_st_ex_mem),
    .ctrl_jm_o (ctrl_jm_ex_mem),
    .ctrl_br_o (ctrl_br_ex_mem),
    .ctrl_reg_write_o (ctrl_reg_write_ex_mem),
    .ctrl_opcode_i (ctrl_opcode_id_ex),
    .ctrl_funct7_i (ctrl_funct7_id_ex),
    .ctrl_funct3_i (ctrl_funct3_id_ex),
    .ctrl_mem_width_o (ctrl_mem_width_ex_mem),
    .stall_proc_i (stall_proc_dc_ex),
    .stall_proc_o (stall_proc_ex_mem),
    .rs1_data_i (rs1_data_id_ex),
    .imm_se_i (imm_se_id_ex),
    .alu_result_o (alu_result_ex_mem),
    .alu_cmp_o (alu_cmp_ex_mem),
    .bypass_ctrl_reg_write_alu_o (bypass_ctrl_reg_write_alu_dc),
    /* .bypass_rd_alu_o (bypass_rd_alu_dc), */
    .bypass_result_alu_o (bypass_result_alu_dc),
    .rs2_data_i (rs2_data_id_ex),
    .rs2_data_o (rs2_data_ex_mem)
);

/* multiplier #() stages_multiplier_inst ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .op_i (ctrl_op_dc_ml), */
/*     .funct7_i (ctrl_funct7_id_ex), */
/*     .funct3_i (ctrl_funct3_id_ex), */
/*     .op1_data_i (rs1_data_id_ex), */
/*     .op2_data_i (rs2_data_id_ex), */
/*     .rd_i (rd_id_ex), */
/*     .rd_o (rd_ml_ml_wb), */
/*     .ctrl_reg_write_i (ctrl_reg_write_dc_ml), */
/*     .ctrl_reg_write_o (ctrl_reg_write_ml_wb), */
/*     .op_ending_o (mult_in_flight_ml_dc), */
/*     .valid_result_o (mult_valid_result_m_wb), */
/*     .result_o (mult_result_m_wb) */
/* ); */

stage_mem #() stage_mem_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_br_i (pc_ex_mem),
    .pc_br_o (pc_mem_if), // cap al fetch
    .rd_i (rd_ex_mem),
    .rd_o (rd_mem_wb),
    .rd_dc_o (rd_mem_dc),
    .alu_cmp_i (alu_cmp_ex_mem),
    .rs2_data_i (rs2_data_ex_mem),
    /* .ctrl_op_i (ctrl_op_ex_mem), */
    .ctrl_ld_i (ctrl_ld_ex_mem),
    .ctrl_ld_o (ctrl_ld_mem_wb),
    .ctrl_st_i (ctrl_st_ex_mem),
    .ctrl_jm_i (ctrl_jm_ex_mem),
    /* .ctrl_jm_o (ctrl_jm_mem_wb), */
    .ctrl_br_i (ctrl_br_ex_mem),
    /* .ctrl_br_o (ctrl_br_mem_wb), */
    .ctrl_mem_width_i (ctrl_mem_width_ex_mem),
    .ctrl_reg_write_i (ctrl_reg_write_ex_mem),
    .ctrl_reg_write_o (ctrl_reg_write_mem_wb),
    .stall_proc_i (stall_proc_ex_mem),
    .alu_result_i (alu_result_ex_mem),
    .alu_result_o (alu_result_mem_wb),
    .bypass_ctrl_reg_write_mem_o (bypass_ctrl_reg_write_mem_dc),
    .bypass_mem_data_o (bypass_mem_data_mem_dc),
    /* .bypass_rd_mem_o (bypass_rd_mem_dc), */
    .dmem_addr_o (addr_dmem),
    .dmem_rd_wr_o (rd_wr_dmem),
    .dmem_op_en_o (op_en_dmem),
    .dmem_wr_data_o (wr_data_dmem),
    .dmem_wr_keep_o (wr_keep_dmem),
    .dmem_rd_data_i (rd_data_mem),
    .mem_data_o (rd_data_mem_wb),
    .take_br_o (take_br_mem_if)
);

memory #(
    .MEM_SIZE_BITS (32*8) // should be greater, at least 4096 
) dmem (
    .clk (clk),
    .reset_n (reset_n),
    .addr (addr_dmem),
    .op_rd_wr (rd_wr_dmem),
    .op_en (op_en_dmem),
    .wr_data (wr_data_dmem),
    .wr_keep (wr_keep_dmem),
    .rd_data (rd_data_mem),
    .input_data (input_data_dmem)
);

stage_write_back #() stage_write_back_inst (
    .clk (clk),
    .reset_n (reset_n),
    .alu_result_i (alu_result_mem_wb),
    .dmem_data_i (rd_data_mem_wb),
    .mult_result_i (mult_result_m_wb),
    .mult_valid_result_i (mult_valid_result_m_wb),
    .rd_mem_i (rd_mem_wb),
    .rd_mult_i (rd_ml_ml_wb),
    .rd_o (rd_wb_id),
    .ctrl_ld_i (ctrl_ld_mem_wb),
    .ctrl_reg_write_i (ctrl_reg_write_mem_wb),
    .ctrl_reg_write_ml_i (ctrl_reg_write_ml_wb),
    .ctrl_reg_write_o (ctrl_reg_write_wb_dc),
    .wr_data_o (rd_data_wb_id)
);


// multiplier



mult_div #() m0_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (ctrl_ml_dc_ml),
    .op_o (op_m0_m1),
    .funct7_i (ctrl_funct7_id_ex),
    .funct7_o (funct7_m0_m1),
    .funct3_i (ctrl_funct3_id_ex),
    .funct3_o (funct3_m0_m1),
    .op1_data_i (rs1_data_id_ex),
    .op1_data_o (op1_data_m0_m1),
    .op2_data_i (rs2_data_id_ex),
    .op2_data_o (op2_data_m0_m1),
    .rd_i (rd_id_ex),
    .rd_o (rd_m0_m1),
    .ctrl_reg_write_i (ctrl_reg_write_dc_ml),
    .ctrl_reg_write_o (ctrl_reg_write_m0_m1)
    /* .valid_result_o (mult_valid_result_m_wb), */
    /* .result_o (mult_result_m_wb) */
);

mult_div #() m1_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_m0_m1),
    .op_o (op_m1_m2),
    .funct7_i (funct7_m0_m1),
    .funct7_o (funct7_m1_m2),
    .funct3_i (funct3_m0_m1),
    .funct3_o (funct3_m1_m2),
    .op1_data_i (op1_data_m0_m1),
    .op1_data_o (op1_data_m1_m2),
    .op2_data_i (op2_data_m0_m1),
    .op2_data_o (op2_data_m1_m2),
    .rd_i (rd_m0_m1),
    .rd_o (rd_m1_m2),
    .ctrl_reg_write_i (ctrl_reg_write_m0_m1),
    .ctrl_reg_write_o (ctrl_reg_write_m1_m2)
    /* .valid_result_o (mult_valid_result_m_wb), */
    /* .result_o (mult_result_m_wb) */
);

mult_div #() m2_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_m1_m2),
    .op_o (op_m2_m3),
    .funct7_i (funct7_m1_m2),
    .funct7_o (funct7_m2_m3),
    .funct3_i (funct3_m1_m2),
    .funct3_o (funct3_m2_m3),
    .op1_data_i (op1_data_m1_m2),
    .op1_data_o (op1_data_m2_m3),
    .op2_data_i (op2_data_m1_m2),
    .op2_data_o (op2_data_m2_m3),
    .rd_i (rd_m1_m2),
    .rd_o (rd_m2_m3),
    .ctrl_reg_write_i (ctrl_reg_write_m1_m2),
    .ctrl_reg_write_o (ctrl_reg_write_m2_m3)
    /* .valid_result_o (mult_valid_result_m_wb), */
    /* .result_o (mult_result_m_wb) */
);

mult_div #() m3_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_m2_m3),
    .op_o (op_m3_m4),
    .funct7_i (funct7_m2_m3),
    .funct7_o (funct7_m3_m4),
    .funct3_i (funct3_m2_m3),
    .funct3_o (funct3_m3_m4),
    .op1_data_i (op1_data_m2_m3),
    .op1_data_o (op1_data_m3_m4),
    .op2_data_i (op2_data_m2_m3),
    .op2_data_o (op2_data_m3_m4),
    .rd_i (rd_m2_m3),
    .rd_o (rd_m3_m4),
    .ctrl_reg_write_i (ctrl_reg_write_m2_m3),
    .ctrl_reg_write_o (ctrl_reg_write_m3_m4)
    /* .valid_result_o (mult_valid_result_m_wb), */
    /* .result_o (mult_result_m_wb) */
);

mult_div #(
    .FINAL_STAGE (1)
    ) m4_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_m3_m4),
    .funct7_i (funct7_m3_m4),
    .funct3_i (funct3_m3_m4),
    .op1_data_i (op1_data_m3_m4),
    .op2_data_i (op2_data_m3_m4),
    .rd_i (rd_m3_m4),
    .rd_o (rd_ml_ml_wb),
    .ctrl_reg_write_i (ctrl_reg_write_m3_m4),
    .ctrl_reg_write_o (ctrl_reg_write_ml_wb),
    .bypass_ml_data_o (bypass_ml_data_ml_dc),
    .bypass_ctrl_reg_write_ml_o (bypass_ctrl_reg_write_ml_dc),
    .valid_result_o (mult_valid_result_m_wb),
    .result_o (mult_result_m_wb)
);

endmodule
