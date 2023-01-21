`timescale 1ns/1ps
import PARAMS_pkg::*;

// not debugged
module multiplier_nonblocking #(
    parameter MUL_STAGES = 5
) (
    input clk,
    input reset_n,

    input /*logic*/ [OPCODE_SIZE-1:0] opcode_i,
    input /*logic*/ [FUNCT7_SIZE-1:0] funct7_i,
    input /*logic*/ [FUNCT3_SIZE-1:0] funct3_i,
    input /*logic*/ [WD_SIZE-1:0] op1_data_i,
    input /*logic*/ [WD_SIZE-1:0] op2_data_i, // rs2 or imm sign extended

    output logic valid_result_o,
    output logic [WD_SIZE-1:0] result_o
);

/* typedef enum {M0, M1, M2, M3, M4} state_mult; */

/* state_mult state; */

logic [MUL_STAGES-1:0][WD_SIZE-1:0] op1_data_q, op2_data_q;
/* logic [MUL_STAGES-2:0][WD_SIZE-1:0] op2_data, op2_data_q; */
/* logic [MUL_STAGES-2:0] valid_instr, valid_instr_q; */
logic [MUL_STAGES-1:0] valid_instr_q;

// -------------
// M0 stage
// -------------
always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        valid_instr_q[0] <= 1'b0;
    end
    else begin
        valid_instr_q[0] <= (opcode_i == OPCODE_OP) & (funct7_i == F7_MULDIV) & (funct3_i == F3_MUL);
        if (valid_instr_q[0]) begin
            op1_data_q[0] <= op1_data_i;
            op2_data_q[0] <= op2_data_i;
        end
    end
end

// -------------
// M1 stage
// -------------
always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        valid_instr_q[1] <= 1'b0;
    end
    else begin
        valid_instr_q[1] <= valid_instr_q[0];
        if (valid_instr_q[1]) begin
            op1_data_q[1] <= op1_data_q[0];
            op2_data_q[1] <= op2_data_q[0];
        end
    end
end

// -------------
// M2 stage
// -------------
always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        valid_instr_q[2] <= 1'b0;
    end
    else begin
        valid_instr_q[2] <= valid_instr_q[1];
        if (valid_instr_q[2]) begin
            op1_data_q[2] <= op1_data_q[1];
            op2_data_q[2] <= op2_data_q[1];
        end
    end
end

// -------------
// M3 stage
// -------------
always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        valid_instr_q[3] <= 1'b0;
    end
    else begin
        valid_instr_q[3] <= valid_instr_q[2];
        if (valid_instr_q[3]) begin
            op1_data_q[3] <= op1_data_q[2];
            op2_data_q[3] <= op2_data_q[2];
        end
    end
end

// -------------
// M4 stage
// -------------
always_ff@(posedge clk) begin
    if (!reset_n) begin
        valid_result_o <= 1'b0;
    end
    else begin
        valid_instr_q[4] <= valid_instr_q[3];
        valid_result_o <= valid_instr_q[4];
        if (valid_instr_q[4]) begin
            op1_data_q[4] <= op1_data_q[3];
            op2_data_q[4] <= op2_data_q[3];
            result_o <= op1_data_q[4] * op2_data_q[4];
        end
        
    end
end


/* always_comb begin */
/*     if (!reset_n) begin */
/*         valid_result_o <= 1'b0; */
/*         valid_instr <= { {MUL_STAGES-2}{1'b0} }; */
/*     end */
/*     else begin */
/*         unique case (state) */
/*             M0: begin */
/*                 valid_result_o <= 1'b0; */
/*                 valid_instr[M0] <= (opcode_i == OPCODE_OP) & (funct7_i == F7_MULDIV) & (funct3_i == F3_MUL); */
/*                 op1_data_q[M0] <= op1_data_i; */
/*                 op2_data_q[M0] <= op2_data_i; */
/*             end // M0 */
/*             M1: begin */
/*                 valid_result_o <= 1'b0; */
/*                 valid_instr[M1] <= valid_instr[M0]; */
/*                 op1_data_q[M1] <= op1_data_q[M0]; */
/*                 op2_data_q[M1] <= op2_data_q[M0]; */
/*             end // M1 */
/*             M2: begin */
/*                 valid_result_o <= 1'b0; */
/*                 valid_instr[M2] <= valid_instr[M1]; */
/*                 op1_data_q[M2] <= op1_data_q[M1]; */
/*                 op2_data_q[M2] <= op2_data_q[M1]; */
/*             end // M2 */
/*             M3: begin */
/*                 valid_result_o <= 1'b0; */
/*                 valid_instr[M3] <= valid_instr[M2]; */
/*                 op1_data_q[M3] <= op1_data_q[M2]; */
/*                 op2_data_q[M3] <= op2_data_q[M2]; */
/*             end // M3 */
/*             M4: begin */
/*                 valid_result_o <= 1'b1; */
/*                 result_o <= op1_data_q[M3] * op2_data_q[M3]; */
/*             end // M4 */
/*         endcase */
/*     end */
/* end */

endmodule
