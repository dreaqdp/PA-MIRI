`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_decode #() (
    input clk,
    input reset_n,

    input logic[INSTR_SIZE-1:0] instr,

    output ctrl_op_o,
    output ctrl_ld_o,
    output ctrl_st_o,
    output ctrl_jm_o,
    output ctrl_br_o,

    output opcode_o,
);

assign opcode_o = instr[6:0];
always_comb begin
    case (opcode_i) 
        OPCODE_LD: begin
            ctrl_op_o = 1'b0;
            ctrl_ld_o = 1'b1;
            ctrl_st_o = 1'b0;
            ctrl_jm_o = 1'b0;
            ctrl_br_o = 1'b0;
        end // OPCODE_LD
        OPCODE_ST: begin
            ctrl_op_o = 1'b0;
            ctrl_ld_o = 1'b0;
            ctrl_st_o = 1'b1;
            ctrl_jm_o = 1'b0;
            ctrl_br_o = 1'b0;
        end // OPCODE_ST
        OPCODE_JM: begin
            ctrl_op_o = 1'b0;
            ctrl_ld_o = 1'b0;
            ctrl_st_o = 1'b0;
            ctrl_jm_o = 1'b1;
            ctrl_br_o = 1'b0;
        end // OPCODE_JM
        OPCODE_BR: begin
            ctrl_op_o = 1'b0;
            ctrl_ld_o = 1'b0;
            ctrl_st_o = 1'b0;
            ctrl_jm_o = 1'b0;
            ctrl_br_o = 1'b1;
        end // OPCODE_BR
        default: begin // OPCODE_OP
            ctrl_op_o = 1'b1;
            ctrl_ld_o = 1'b0;
            ctrl_st_o = 1'b0;
            ctrl_jm_o = 1'b0;
            ctrl_br_o = 1'b0;
        end
    endcase
end
endmodule

