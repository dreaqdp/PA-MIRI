`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_ex #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_br_o,

    input logic [INSTR_REG_SIZE-1:0] rd_i,
    output logic [INSTR_REG_SIZE-1:0] rd_o,
    output [INSTR_REG_SIZE-1:0] rd_dc_o,

    input logic ctrl_op_i, // arith op
    /* output logic ctrl_op_o, // arith op */
    input logic ctrl_ld_i, // load
    output logic ctrl_ld_o,
    input logic ctrl_st_i, // store
    output logic ctrl_st_o, // store
    input logic ctrl_jm_i, // jump
    output logic ctrl_jm_o, // jump
    input logic ctrl_br_i,  // branch
    output logic ctrl_br_o,  // branch

    input logic ctrl_reg_write_i,
    output logic ctrl_reg_write_o,

    input logic [OPCODE_SIZE-1:0] ctrl_opcode_i,
    input logic [FUNCT7_SIZE-1:0] ctrl_funct7_i,
    input logic [FUNCT3_SIZE-1:0] ctrl_funct3_i,
    output logic [FUNCT3_SIZE-1:0] ctrl_mem_width_o,
    input logic stall_proc_i,
    output logic stall_proc_o,
    input logic [WD_SIZE-1:0] rs1_data_i,
    input logic [WD_SIZE-1:0] imm_se_i, //sign extended

    output logic [WD_SIZE-1:0] alu_result_o,
    output logic alu_zero_o,
    
    input logic [WD_SIZE-1:0] rs2_data_i,
    output logic [WD_SIZE-1:0] rs2_data_o

);

logic [FUNCT3_SIZE-1:0] ctrl_mem_width_q;
logic [WD_SIZE-1:0] alu_result_q, alu_result_d, mul_result_d, rs2_data_q, rd_q;
logic alu_zero_q, mult_valid_result_q, ctrl_ld_q, ctrl_st_q, ctrl_jm_q, ctrl_br_q, ctrl_reg_write_q;

assign ctrl_reg_write_o = ctrl_reg_write_q;
assign ctrl_ld_o = ctrl_ld_q;
assign ctrl_st_o = ctrl_st_q;
assign ctrl_jm_o = ctrl_jm_q;
assign ctrl_br_o = ctrl_br_q;
assign ctrl_mem_width_o = ctrl_mem_width_q;

assign rd_dc_o = rd_i;
assign rd_o = rd_q;
assign rs2_data_o = rs2_data_q;
assign alu_result_o = alu_result_q;

always_ff@(posedge clk) begin
    if (!reset_n) begin
        ctrl_reg_write_q <= 1'b0;
        ctrl_br_q <= 1'b0;
    end
    else begin
        pc_br_o <= pc_i + imm_se_i; // RISC-V B-type and J-type instr already contain a 2 shifted imm
        rd_q <= rd_i;
        /* opcode_o <= opcode_i; */
        rs2_data_q <= rs2_data_i;

        alu_result_q <= alu_result_d;
        /* if (ctrl_op_i && (ctrl_funct7_i == F7_MULDIV)) begin */
        /*     stage_result_q <= mul_result_d; */
        /* end */
        /* else begin */
        /*     stage_result_q <= alu_result_d; */
        /* end */
        alu_zero_o <= alu_zero_q;

        ctrl_reg_write_q <= ctrl_reg_write_i;
        /* ctrl_reg_write_q <= (ctrl_op_i && (ctrl_funct7_i != F7_MULDIV)) ? ctrl_reg_write_i : 1'b0; */
        ctrl_ld_q <= ctrl_ld_i;
        ctrl_st_q <= ctrl_st_i;
        ctrl_jm_q <= ctrl_jm_i;
        ctrl_br_q <= ctrl_br_i;
        ctrl_mem_width_q <= ctrl_funct3_i;

        stall_proc_o <= stall_proc_i;

    end
end

/* assign op2_data = (ctrl_op_i) ? rs2_data_i : imm_se_i;  // alu src */


alu #() alu_inst (
    .clk (clk),
    .reset_n (reset_n),
    .opcode_i (ctrl_opcode_i),
    .funct7_i (ctrl_funct7_i),
    .funct3_i (ctrl_funct3_i),
    .op1_data_i (rs1_data_i),
    .op2_data_i (rs2_data_i),
    .imm_se_i (imm_se_i),
    .zero_o (alu_zero_q),
    .result_o (alu_result_d)
);

/* multiplier #() multiplier_inst ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .opcode_i (ctrl_opcode_i), */
/*     .funct7_i (ctrl_funct7_i), */
/*     .funct3_i (ctrl_funct3_i), */
/*     .op1_data_i (rs1_data_i), */
/*     .op2_data_i (rs2_data_i), */
/*     .valid_result_o (mult_valid_result_q), */
/*     .result_o (mul_result_d) */
/* ); */

endmodule
