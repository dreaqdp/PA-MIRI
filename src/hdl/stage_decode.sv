`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_decode #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_o,

    input logic[INSTR_SIZE-1:0] instr,

    input logic [INSTR_REG_BITS-1:0] wr_rd,
    input logic [WD_SIZE-1:0] wr_data,

    output logic [OPCODE_BITS-1:0] opcode,
    output logic [FUNCT7_BITS-1:0] funct7,
    output logic [FUNCT3_BITS-1:0] funct3,
    output logic [WD_SIZE-1:0] rs1_data,
    output logic [WD_SIZE-1:0] rs2_data,
    output logic [WD_SIZE-1:0] imm_se, //sign extended
    output logic [INSTR_REG_BITS-1:0] rd //,

    /* output logic instr_op_o, // arith op */
    /* output logic instr_ld_o, // load */
    /* output logic instr_st_o, // store */
    /* output logic instr_jm_o, // jump */
    /* output logic instr_br_o  // branch */


);

wire [INSTR_REG_BITS-1:0] rs1, rs2;

assign opcode = instr[6:0];
assign rd = instr[11:7];
assign funct3 = instr[14:12];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign funct7 = instr[31:25];


always_ff@(posedge clk) begin
    if (reset_n) begin
        pc_o <= pc_i;
    end
end

always_comb begin
    case (opcode) // generate immediate
        OPCODE_ST: imm_se <= { { {WD_SIZE-10}{instr[31]} }, instr[30:25], instr[11:8] };
        OPCODE_BR: imm_se <= { { {WD_SIZE-11}{instr[31]} }, instr[7], instr[30:25], instr[11:8], 1'b0 };
        OPCODE_JM: imm_se <= { { {WD_SIZE-22}{instr[31]} }, instr[19:12], instr[20],  instr[30:25], instr[24:21], 1'b0 }; 
        default:  // OPCODE_OP, OPCODE_LD --> I-type instr
            imm_se <= { { {WD_SIZE-12}{instr[31]} }, instr[31:20] };
    endcase
end

register_file #() reg_file (
    .clk (clk),
    .reset_n (reset_n),
    .rs1 (rs1),
    .rs2 (rs2),
    .wr_rd (wr_rd),
    .wr_data (wr_data),
    .rs1_data (rs1_data),
    .rs2_data (rs2_data)
);

endmodule
