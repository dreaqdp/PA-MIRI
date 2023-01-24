`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_write_back #() (
    input clk,
    input reset_n,

    input logic [WD_SIZE-1:0] alu_result_i,
    input logic [WD_SIZE-1:0] dmem_data_i,
    input logic [WD_SIZE-1:0] mult_result_i,
    input mult_valid_result_i,
    
    input logic [INSTR_REG_SIZE-1:0] rd_mem_i,
    input logic [INSTR_REG_SIZE-1:0] rd_mult_i,
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
    input logic ctrl_reg_write_ml_i,
    output /*logic*/ ctrl_reg_write_o,
    output [WD_SIZE-1:0] wr_data_o
);

logic ctrl_reg_write_d;

assign wr_data_o = mult_valid_result_i ? mult_result_i : 
                   ctrl_ld_i ? dmem_data_i : alu_result_i;
/* assign ctrl_reg_write_o = ctrl_reg_write_i; */


assign rd_o = mult_valid_result_i ? rd_mult_i : rd_mem_i;

always_comb begin
    if (reset_n) begin
        if (mult_valid_result_i)
            ctrl_reg_write_d = ctrl_reg_write_ml_i;
        else
            ctrl_reg_write_d = ctrl_reg_write_i;
    end
    else 
        ctrl_reg_write_d = 1'b0;
end

assign ctrl_reg_write_o = ctrl_reg_write_d;

/* assign ctrl_reg_write_o = reset_n ? ctrl_reg_write_i : 1'b0; // not logic to be able to write in dec */

endmodule
