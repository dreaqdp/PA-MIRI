`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_mem #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_o,

    input logic [INSTR_REG_BITS-1:0] rd_i,
    output logic [INSTR_REG_BITS-1:0] rd_o,

    input logic [WD_SIZE-1:0] alu_result_i,
    output logic [WD_SIZE-1:0] alu_result_o,

    input logic alu_zero,
    input logic [WD_SIZE-1:0] rs2_data_i,
    /* input logic [OPCODE_BITS-1:0] opcode_i, */
    /* output logic [OPCODE_BITS-1:0] opcode_o, */
    input logic instr_op_i, // arith op
    input logic instr_ld_i, // load
    output logic instr_ld_o, // load
    input logic instr_st_i, // store
    input logic instr_jm_i, // jump
    output logic instr_jm_o, // jump
    input logic instr_br_i  // branch
    output logic instr_br_o  // branch

    output [WD_SIZE-1:0] addr,
    output rd_wr,
    output op_en,
    output [WD_SIZE-1:0] wr_data,
    input [WD_SIZE-1:0] rd_data_i,
    output logic [WD_SIZE-1:0] rd_data_o

);

wire op_en, op_wr;

assign addr = alu_result_i;
assign op_wr = instr_st_i;
assign op_en = instr_ld_i | instr_st_i;
assign wr_data = rs2_data_i;
assign rd_data_o = rd_data_i;


always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* op_en <= 1'b0; */
    end
    if (reset_n) begin
        instr_ld_o <= instr_ld_i;
        instr_jm_o <= instr_jm_i;
        instr_br_o <= instr_br_i;
        pc_o <= pc_i;
        rd_o <= rd_i;
        /* opcode_o <= opcode_i; */
        alu_result_i <= alu_result_o;


    end
end

/* memory #( */
/*     .MEM_SIZE_BITS (128*4); */
/* ) imem ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .addr(alu_result_i), */
/*     .rd_wr(op_wr), */
/*     .op_en(op_en), */
/*     .wr_data(alu_result_i), */
/*     .rd_data(rd_data); */
/* ); */

endmodule

