`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_write_back #() (
    input clk,
    input reset_n,

    input logic [WD_SIZE-1:0] alu_result_i,
    input logic [WD_SIZE-1:0] dmem_data_i,
    


    input logic [INSTR_REG_SIZE-1:0] rd_i,
    output logic [INSTR_REG_SIZE-1:0] rd_o,

    /* input logic [OPCODE_SIZE-1:0] opcode_i, */
    /* output logic [OPCODE_SIZE-1:0] opcode_o, */
    input logic ctrl_ld_i, // load
    /* output logic instr_ld_o, // load */
    /* input logic instr_jm_i, // jump */
    /* output logic instr_jm_o, // jump */
    /* input logic instr_br_i,  // branch */
    /* output logic instr_br_o,  // branch */

    input logic ctrl_reg_write_i,
    output /*logic*/ ctrl_reg_write_o,
    output [WD_SIZE-1:0] wr_data_o
);

/* logic [WD_SIZE-1:0] wr_data; */

assign wr_data_o = ctrl_ld_i ? dmem_data_i : alu_result_i;
/* assign ctrl_reg_write_o = ctrl_reg_write_i; */

/* assign instr_jm_o = instr_jm_i; */
/* assign instr_br_o = instr_br_i; */

assign rd_o = rd_i;

assign ctrl_reg_write_o = reset_n ? ctrl_reg_write_i : 1'b0; // not logic to be able to write in dec
/* always_ff @ (posedge clk) begin */
/*     if (!reset_n) */
/*         ctrl_reg_write_o <= 1'b0; */
/*     /1* else *1/ */
/*     /1*     ctrl_reg_write_o <= ctrl_reg_write_i; *1/ */
/* end */

endmodule
