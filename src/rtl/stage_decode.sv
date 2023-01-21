`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_decode #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_o,

    input logic[INSTR_SIZE-1:0] instr_i,
    input logic instr_valid_i,

    input logic ctrl_reg_write_i,
    input logic [INSTR_REG_SIZE-1:0] wr_rd_i,
    input logic [WD_SIZE-1:0] wr_data_i,

    output logic [OPCODE_SIZE-1:0] ctrl_opcode_o,
    /* output logic [7-1:0] ctrl_opcode_o, */
    output logic [FUNCT7_SIZE-1:0] ctrl_funct7_o,
    output logic [FUNCT3_SIZE-1:0] ctrl_funct3_o,
    output logic [WD_SIZE-1:0] rs1_data_o,
    output logic [WD_SIZE-1:0] rs2_data_o,
    output logic [WD_SIZE-1:0] imm_se_o, //sign extended
    output logic [INSTR_REG_SIZE-1:0] rd_o, //,

    output logic ctrl_op_o, // arith op
    output logic ctrl_ld_o, // load
    output logic ctrl_st_o, // store
    output logic ctrl_jm_o, // jump
    output logic ctrl_br_o,  // branch
    output logic ctrl_reg_write_o,

    input logic [INSTR_REG_SIZE-1:0] rd_ex_i, // to check dependencies
    input logic [INSTR_REG_SIZE-1:0] rd_mem_i, // to check dependencies

    output logic stall_proc_o
    // input logic rd wb comes in rd_i


);

logic [INSTR_REG_SIZE-1:0] rs1, rs2;
logic match_rs1, match_rs2;

logic [OPCODE_SIZE-1:0] opcode_q;
logic [FUNCT7_SIZE-1:0] funct7_q;
logic [FUNCT3_SIZE-1:0] funct3_q;
logic [WD_SIZE-1:0] rs1_data_q, rs2_data_q, imm_se_q;
logic [INSTR_REG_SIZE-1:0] rd_q;
logic ctrl_op_q, ctrl_ld_q, ctrl_st_q, ctrl_jm_q, ctrl_br_q;
logic [INSTR_SIZE-1:0] instr_q;

logic dependency;

assign rd_o = rd_q;
assign ctrl_funct3_o = funct3_q;
assign ctrl_funct7_o = funct7_q;

assign rs1 = instr_i[19:15];
assign rs2 = instr_i[24:20];
assign opcode_q = instr_i[6:0];

// dependencies check
/* assign match_rs1 = (rd_ex_i == rs1) || (rd_mem_i == rs1) && (rs1 != { {INSTR_REG_SIZE}{1'b0} }); // do not detect dependency if reg x0 is being used in the instruction */
assign match_rs1 = ((rd_ex_i == rs1) || (rd_mem_i == rs1)) && (rs1 != { {INSTR_REG_SIZE}{1'b0} }); // do not detect dependency if reg x0 is being used in the instruction
assign match_rs2 = ((rd_ex_i == rs2) || (rd_mem_i == rs2)) && (rs2 != { {INSTR_REG_SIZE}{1'b0} });


/* assign imm_se = imm_se_q; */

assign dependency = (match_rs1 | match_rs2) & instr_valid_i; // if rd of a previous instr matches de current instr
assign stall_proc_o = dependency;
// end dependencies check

logic ctrl_reg_write_d;
        /* ctrl_reg_write_o <= (ctrl_op_q || ctrl_ld_q) && (instr_i != NOP_INSTR); */
assign        ctrl_reg_write_d = (ctrl_op_q || ctrl_ld_q) && ( |instr_i ) && !dependency; // write only if op or load instr and not a NOP instr and not stalling proc

always_ff@(posedge clk) begin
    if (!reset_n) begin
        ctrl_reg_write_o <= 1'b0;
        /* opcode_q <= { {OPCODE_SIZE}{1'b0} }; */
        ctrl_br_o <= 1'b0;
        /* stall_proc_q <= 1'b0; */
        rd_q <= { {INSTR_REG_SIZE}{1'b0} };
        
    end 
    else begin
        pc_o <= pc_i;

        /* opcode_q <= ctrl_opcode; */
        if (dependency) begin
            // nop instr
            rd_q <= 5'b0;
            funct3_q <= 5'b0;
            funct7_q <= 5'b0;
        end
        else begin
            rd_q <= instr_i[11:7];
            funct3_q <= instr_i[14:12];
            funct7_q <= instr_i[31:25];
        end
        imm_se_o <= imm_se_q;
        ctrl_opcode_o <= opcode_q;
        ctrl_op_o <= ctrl_op_q; // reg write
        ctrl_ld_o <= ctrl_ld_q; // mem read & reg write
        ctrl_st_o <= ctrl_st_q; // mem write
        ctrl_jm_o <= ctrl_jm_q; // jump
        ctrl_br_o <= ctrl_br_q; // branch

        ctrl_reg_write_o <= ctrl_reg_write_d;

        if (wr_rd_i == rs1)
            rs1_data_o <= wr_data_i;
        else
            rs1_data_o <= rs1_data_q;
        if (wr_rd_i == rs2)
            rs2_data_o <= wr_data_i;
        else
            rs2_data_o <= rs2_data_q;

        /* stall_proc_o <= stall_proc_q; */
    end
end

always_comb begin
    case (opcode_q) // generate immediate
        OPCODE_ST: imm_se_q <= { { {WD_SIZE-11}{instr_i[31]} }, instr_i[30:25], instr_i[11:8], instr_i[7] };
        OPCODE_BR: imm_se_q <= { { {WD_SIZE-12}{instr_i[31]} }, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0 };
        OPCODE_JM: imm_se_q <= { { {WD_SIZE-20}{instr_i[31]} }, instr_i[19:12], instr_i[20],  instr_i[30:25], instr_i[24:21], 1'b0 }; 
        default:  // OPCODE_OP, OPCODE_LD --> I-type instr_i
            imm_se_q <= { { {WD_SIZE-11}{instr_i[31]} }, instr_i[30:20] };
    endcase
end

always_comb begin
    case (opcode_q) 
        OPCODE_LD: begin
            ctrl_op_q = 1'b0;
            ctrl_ld_q = 1'b1;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b0;
        end // OPCODE_LD
        OPCODE_ST: begin
            ctrl_op_q = 1'b0;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b1;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b0;
        end // OPCODE_ST
        OPCODE_JM: begin
            ctrl_op_q = 1'b0;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b1;
            ctrl_br_q = 1'b0;
        end // OPCODE_JM
        OPCODE_BR: begin
            ctrl_op_q = 1'b0;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b1;
        end // OPCODE_BR
        OPCODE_OP: begin // OPCODE_OP
            ctrl_op_q = 1'b1;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b0;
        end // OPCODE_OP
        OPCODE_IM: begin // OPCODE_IM
            ctrl_op_q = 1'b1;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b0;
        end // OPCODE_IM
        default: begin 
            ctrl_op_q = 1'b0;
            ctrl_ld_q = 1'b0;
            ctrl_st_q = 1'b0;
            ctrl_jm_q = 1'b0;
            ctrl_br_q = 1'b0;
        end
    endcase
end

register_file #() reg_file (
    .clk (clk),
    .reset_n (reset_n),
    .rs1 (rs1),
    .rs2 (rs2),
    .reg_write (ctrl_reg_write_i),
    .wr_rd (wr_rd_i),
    .wr_data (wr_data_i),
    .rs1_data (rs1_data_q),
    .rs2_data (rs2_data_q)
);

/* control #() control_logic ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .instr_i (instr_i), */
/*     .opcode_o (ctrl_opcode), */
/* ); */

endmodule
