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
wire [WD_SIZE-1:0] addr_imem, addr_dmem, wr_data_dmem, rd_data_mem;
wire [INSTR_REG_SIZE-1:0] rd_id_ex, rd_ex_mem, rd_mem_wb, rd_wb_id, rd_mem_dc, rd_ex_dc;
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
wire alu_zero_ex_mem;
wire [WD_SIZE-1:0] rd_instr;
wire [INSTR_SIZE-1:0] instr;
wire op_en_pc, op_en_dmem;
wire rd_wr_dmem, op_rd_pc;
wire take_br_mem_if;
wire stall_proc_dc_if;
wire instr_valid_if_ex;


stage_fetch #() stage_fetch_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_mem_if),
    .pc_o (pc_if_id),
    /* .ctrl_jm (ctrl_jm_mem_wb), */
    .take_br_i (take_br_mem_if),
    .instr_o (instr),
    .instr_valid_o (instr_valid_if_ex),
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


stage_decode #() stage_decode_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_if_id),
    .pc_o (pc_id_ex),
    .instr_i (instr),
    .instr_valid_i (instr_valid_if_ex),
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
    .ctrl_ld_o (ctrl_ld_dc_ex),
    .ctrl_st_o (ctrl_st_dc_ex),
    .ctrl_jm_o (ctrl_jm_dc_ex),
    .ctrl_br_o (ctrl_br_dc_ex),
    .ctrl_reg_write_o (ctrl_reg_write_dc_ex),
    .ctrl_reg_write_i (ctrl_reg_write_wb_dc),
    .rd_ex_i (rd_ex_dc),
    .rd_mem_i (rd_mem_dc),
    .stall_proc_o (stall_proc_dc_if)

);

stage_ex #() stage_ex_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_id_ex),
    .pc_br_o (pc_ex_mem),
    .rd_i (rd_id_ex),
    .rd_dc_o (rd_ex_dc),
    .rd_o (rd_ex_mem),
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
    .rs1_data_i (rs1_data_id_ex),
    .imm_se_i (imm_se_id_ex),
    .alu_result_o (alu_result_ex_mem),
    .alu_zero_o (alu_zero_ex_mem),
    .rs2_data_i (rs2_data_id_ex),
    .rs2_data_o (rs2_data_ex_mem)
);

/* stage_multiplier #() stage_multiplier_inst ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .opcode_i (ctrl_opcode_i), */
/*     .funct7_i (ctrl_funct7_i), */
/*     .funct3_i (ctrl_funct3_i), */
/*     .op1_data_i (rs1_data_i), */
/*     .op2_data_i (rs2_data_i), */
/*     .valid_result_o (mult_valid_result_q), */
/*     .mult_result_o (mul_result_d) */
/* ); */

stage_mem #() stage_mem_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_br_i (pc_ex_mem),
    .pc_br_o (pc_mem_if), // cap al fetch
    .rd_i (rd_ex_mem),
    .rd_o (rd_mem_wb),
    .rd_dc_o (rd_mem_dc),
    .alu_zero_i (alu_zero_ex_mem),
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
    .alu_result_i (alu_result_ex_mem),
    .alu_result_o (alu_result_mem_wb),
    .dmem_addr_o (addr_dmem),
    .dmem_rd_wr_o (rd_wr_dmem),
    .dmem_op_en_o (op_en_dmem),
    .dmem_wr_data_o (wr_data_dmem),
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
    .rd_data (rd_data_mem),
    .input_data (input_data_dmem)
);

stage_write_back #() stage_write_back_inst (
    .clk (clk),
    .reset_n (reset_n),
    .rd_i (rd_mem_wb),
    .rd_o (rd_wb_id),
    .alu_result_i (alu_result_mem_wb),
    .dmem_data_i (rd_data_mem_wb),
    .ctrl_ld_i (ctrl_ld_mem_wb),
    .ctrl_reg_write_i (ctrl_reg_write_mem_wb),
    .ctrl_reg_write_o (ctrl_reg_write_wb_dc),
    /* .ctrl_jm_i (ctrl_jm_ex_mem), */
    /* .ctrl_jm_o (ctrl_jm_wb_if), */
    /* .ctrl_br_i (ctrl_br_ex_mem), */
    /* .ctrl_br_o (ctrl_br_wb_if), */
    .wr_data_o (rd_data_wb_id)
);



endmodule

