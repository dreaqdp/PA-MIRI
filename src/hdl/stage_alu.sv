`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_alu #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_o,

    input logic [INSTR_REG_BITS-1:0] rd_i,
    output logic [INSTR_REG_BITS-1:0] rd_o,

    /* input logic instr_op_i, // arith op */
    output logic instr_op_o, // arith op
    /* input logic instr_ld_i, // load */
    output logic instr_ld_o, // load
    /* input logic instr_st_i, // store */
    output logic instr_st_o, // store
    /* input logic instr_jm_i, // jump */
    output logic instr_jm_o, // jump
    /* input logic instr_br_i  // branch */
    output logic instr_br_o  // branch

    input logic [OPCODE_BITS-1:0] opcode_i,
    input logic [FUNCT7_BITS-1:0] funct7,
    input logic [FUNCT3_BITS-1:0] funct3,
    input logic [WD_SIZE-1:0] rs1_data,
    input logic [WD_SIZE-1:0] imm_se, //sign extended

    output logic [WD_SIZE-1:0] alu_result,
    output logic alu_zero,
    
    input logic [WD_SIZE-1:0] rs2_data_i,
    output logic [WD_SIZE-1:0] rs2_data_o

    
);

wire [WD_SIZE-1:0] op2_data;

always_ff@(posedge clk) begin
    if (reset_n) begin
        pc_o <= pc_i + imm_se; // RISC-V B-type and J-type instr already contain a 2 shifted imm
        rd_o <= rd_i;
        /* opcode_o <= opcode_i; */
        rs2_data_o <= rs2_data_i;
    end
end

assign op2_data = (instr_op_o) ? rs2_data_i: imm_se; 

always_comb begin
    case (instr[6:0]) 
        OPCODE_LD: begin
            instr_op_o = 1'b0;
            instr_ld_o = 1'b1;
            instr_st_o = 1'b0;
            instr_jm_o = 1'b0;
            instr_br_o = 1'b0;
        end // OPCODE_LD
        OPCODE_ST: begin
            instr_op_o = 1'b0;
            instr_ld_o = 1'b0;
            instr_st_o = 1'b1;
            instr_jm_o = 1'b0;
            instr_br_o = 1'b0;
        end // OPCODE_ST
        OPCODE_JM: begin
            instr_op_o = 1'b0;
            instr_ld_o = 1'b0;
            instr_st_o = 1'b0;
            instr_jm_o = 1'b1;
            instr_br_o = 1'b0;
        end // OPCODE_JM
        OPCODE_BR: begin
            instr_op_o = 1'b0;
            instr_ld_o = 1'b0;
            instr_st_o = 1'b0;
            instr_jm_o = 1'b0;
            instr_br_o = 1'b1;
        end // OPCODE_BR
        default: begin // OPCODE_OP
            instr_op_o = 1'b1;
            instr_ld_o = 1'b0;
            instr_st_o = 1'b0;
            instr_jm_o = 1'b0;
            instr_br_o = 1'b0;
        end
    endcase
end

alu #() alu (
    .clk (clk),
    .reset_n (reset_n),
    .opcode (opcode_i),
    .funct7 (funct7),
    .funct3 (funct3),
    .op1_data (rs1_data),
    .op2_data (op2_data),
    .zero(alu_zero),
    .result(alu_result)
);

endpackage
