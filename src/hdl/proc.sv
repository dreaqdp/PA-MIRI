`timescale 1ns/1ps
import PARAMS_pkg::*;

module proc #(
    parameter INPUT_DMEM = 32*4,
    parameter INPUT_IMEM = 32*4
) (
    input clk,
    input reset_n,
    input [INPUT_DMEM-1:0] input_data_dmem,
    input [INPUT_IMEM-1:0] input_data_imem
);


wire [INSTR_SIZE-1:0] pc_if_id, pc_mem_if, pc_id_ex, pc_ex_mem;
wire [INSTR_REG_BITS-1:0] rd_id_ex, rd_ex_mem, rd_mem_wb, rd_wb_id;
wire instr_op_ex_mem;
wire instr_ld_ex_mem, instr_ld_mem_wb;
wire instr_st_ex_mem;
wire instr_jm_ex_mem, instr_jm_mem_wb, instr_jm_wb_if;
wire instr_br_ex_mem, instr_br_mem_wb, instr_br_wb_if;
wire [OPCODE_BITS-1:0] opcode_id_ex;
wire [FUNCT7_BITS-1:0] funct7_id_ex;
wire [FUNCT3_BITS-1:0] funct3_id_ex;
wire [WD_SIZE-1:0] rs1_data_id_ex, rs2_data_id_ex, rs2_data_ex_mem;
wire [WD_SIZE-1:0] imm_se_id_ex;
wire [WD_SIZE-1:0] rd_data_wb_id, rd_data_mem_wb;
wire [WD_SIZE-1:0] alu_result_ex_mem, alu_result_mem_wb;
wire alu_zero_ex_mem;
wire [WD_SIZE-1:0] rd_instr,
wire [INSTR_SIZE-1:0] instr;
wire op_en_pc, op_en_dmem;
wire rd_pc, rd_wr_dmem;


stage_fetch #() fetch (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_mem_if),
    .pc_o (pc_if_id),
    .instr_jm (instr_jm_mem_wb),
    .instr (instr),
    .rd_pc (rd_pc),
    .rd_wr (op_rd_pc),
    .op_en (op_en_pc),
    .rd_instr (rd_instr)
);

memory #(
    .MEM_SIZE_BITS (32*8) // should be greater, at least 4096 
) imem (
    .clk (clk),
    .reset_n (reset_n),
    .addr (rd_pc),
    .rd_wr (op_rd_pc),
    .op_en (op_en_pc),
    .wr_data ({{WD_SIZE}{1'b0}}),
    .rd_data (rd_instr),
    .input_data (input_data_imem)
);


stage_decode #() decode (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_if_id),
    .pc_o (pc_id_ex),
    .instr (instr),
    .wr_rd (rd_wb),
    .wr_data (rd_data_wb),
    .opcode (opcode_id_ex),
    .funct7 (funct7_id_ex),
    .funct3 (funct3_id_ex),
    .rs1_data (rs1_data_id_ex),
    .rs2_data (rs2_data_id_ex),
    .imm_se (imm_se_id_ex),
    .rd (rd_id_ex)
);

stage_alu #() alu (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_id_ex),
    .pc_o (pc_ex_mem),
    .rd_i (rd_id_ex),
    .rd_o (rd_ex_mem),
    .instr_op_o (instr_op_ex_mem),
    .instr_ld_o (instr_ld_ex_mem),
    .instr_st_o (instr_st_ex_mem),
    .instr_jm_o (instr_jm_ex_mem),
    .instr_br_o (instr_br_ex_mem),
    .opcode_i (opcode_id_ex),
    .funct7 (funct7_id_ex),
    .funct3 (funct3_id_ex),
    .rs1_data (rs1_data_id_ex),
    .imm_se (imm_se_id_ex),
    .alu_result (alu_result_ex_mem),
    .alu_zero (alu_zero_ex_mem),
    .rs2_data_i (rs2_data_id_ex),
    .rs2_data_o (rs2_data_ex_mem)
);


stage_mem #() mem (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_ex_mem),
    .pc_o (pc_mem_if), // cap al fetch
    .rd_i (rd_ex_mem),
    .rd_o (rd_mem_wb),
    .instr_op_i (instr_op_ex_mem),
    .instr_ld_i (instr_ld_ex_mem),
    .instr_ld_o (instr_ld_mem_wb),
    .instr_st_i (instr_st_ex_mem),
    .instr_jm_i (instr_jm_ex_mem),
    .instr_jm_o (instr_jm_mem_wb),
    .instr_br_i (instr_br_ex_mem),
    .instr_br_o (instr_br_mem_wb),
    .alu_result_i (alu_result_ex_mem),
    .alu_result_o (alu_result_mem_wb),
    .alu_zero (alu_zero_ex_mem),
    .rs2_data_i (rs2_data_ex_mem),
    .addr (addr_dmem),
    .rd_wr (rd_wr_dmem),
    .op_en (op_en_dmem),
    .wr_data (wr_data_dmem),
    .rd_data_i (rd_data_mem),
    .rd_data_o (rd_data_mem_wb)
);

memory #(
    .MEM_SIZE_BITS (32*8) // should be greater, at least 4096 
) dmem (
    .clk (clk),
    .reset_n (reset_n),
    .addr (addr_dmem),
    .rd_wr (rd_wr_dmem),
    .op_en (op_en_dmem),
    .wr_data (wr_data_dmem),
    .rd_data (rd_data_mem),
    .input_data (input_data_dmem)
);

stage_write_back #() write_back (
    .clk (clk),
    .reset_n (reset_n),
    .rd_i (rd_mem_wb),
    .rd_o (rd_wb_id),
    .alu_result_i (alu_result_mem_wb),
    .mem_data (data_mem_wb),
    .instr_ld_i (instr_ld_ex_mem),
    .instr_jm_i (instr_jm_ex_mem),
    .instr_jm_o (instr_jm_wb_if),
    .instr_br_i (instr_br_ex_mem),
    .instr_br_o (instr_br_wb_if),
    .wr_data (rd_data_wb_id),
);



endmodule

