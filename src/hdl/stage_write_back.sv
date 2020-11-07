`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_write_back #() (
    input clk,
    input reset_n,

    input logic [WD_SIZE-1:0] alu_result_i,
    input logic [WD_SIZE-1:0] mem_data,

    input logic [INSTR_REG_BITS-1:0] rd_i,
    output logic [INSTR_REG_BITS-1:0] rd_o,

    /* input logic [OPCODE_BITS-1:0] opcode_i, */
    /* output logic [OPCODE_BITS-1:0] opcode_o, */
    input logic instr_ld_i, // load
    /* output logic instr_ld_o, // load */
    input logic instr_jm_i, // jump
    output logic instr_jm_o, // jump
    input logic instr_br_i  // branch
    output logic instr_br_o  // branch

    output [WD_SIZE-1:0] wr_data
);

assign wr_data = instr_ld_i ? mem_data : alu_result_i;

assign instr_jm_o = instr_jm_i;
assign instr_br_o = instr_br_i;

assign rd_o = rd_i;

endmodule
