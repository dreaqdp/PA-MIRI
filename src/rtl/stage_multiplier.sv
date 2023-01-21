`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_multiplier #(
parameter MUL_STAGE_ID = 5
) (
    input clk,
    input reset_n,

    input /*logic*/ [OPCODE_SIZE-1:0] opcode_i,
    input /*logic*/ [FUNCT7_SIZE-1:0] funct7_i,
    input /*logic*/ [FUNCT3_SIZE-1:0] funct3_i,
    input /*logic*/ [WD_SIZE-1:0] op1_data_i,
    input /*logic*/ [WD_SIZE-1:0] op2_data_i, // rs2

    /* output logic valid_result_o, */
    output logic [WD_SIZE-1:0] mult_result_o
);

typedef enum {M0, M1, M2, M3, M4} state_mult;

state_mult state;

logic [MUL_STAGES-2:0][WD_SIZE-1:0] op1_data_q, op2_data_q;
logic [MUL_STAGES-2:0] valid_instr;

always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        state <= M0;
        /* valid_instr <= { {MUL_STAGES-2}{1'b0} }; */
    end
    else begin
       unique case (state) 
           M0: begin
               state <= valid_instr[M0] ? M1 : M0;
           end // M0
           M1: begin
               state <= M2;
           end // M1
           M2: begin
               state <= M3;
           end // M2
           M3: begin
               state <= M4;
           end // M3
           M4: begin
               state <= M0;
           end // M4
       endcase
   end
end

always_comb begin
    if (!reset_n) begin
        valid_result_o <= 1'b0;
        valid_instr <= { {MUL_STAGES-2}{1'b0} };
    end
    else begin
        unique case (state)
            M0: begin
                valid_result_o <= 1'b0;
                valid_instr[M0] <= (opcode_i == OPCODE_OP) & (funct7_i == F7_MULDIV) & (funct3_i == F3_MUL);
                op1_data_q[M0] <= op1_data_i;
                op2_data_q[M0] <= op2_data_i;
            end // M0
            M1: begin
                valid_result_o <= 1'b0;
                valid_instr[M1] <= valid_instr[M0];
                op1_data_q[M1] <= op1_data_q[M0];
                op2_data_q[M1] <= op2_data_q[M0];
            end // M1
            M2: begin
                valid_result_o <= 1'b0;
                valid_instr[M2] <= valid_instr[M1];
                op1_data_q[M2] <= op1_data_q[M1];
                op2_data_q[M2] <= op2_data_q[M1];
            end // M2
            M3: begin
                valid_result_o <= 1'b0;
                valid_instr[M3] <= valid_instr[M2];
                op1_data_q[M3] <= op1_data_q[M2];
                op2_data_q[M3] <= op2_data_q[M2];
            end // M3
            M4: begin
                valid_result_o <= 1'b1;
                mult_result_o <= op1_data_q[M3] * op2_data_q[M3];
            end // M4
        endcase
    end
end

endmodule
