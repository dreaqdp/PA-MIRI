`timescale 1ns/1ps
import PARAMS_pkg::*;

module stages_mult_div #(
parameter MUL_STAGES = 5
) (
    input clk,
    input reset_n,

    input logic op_i,
    input logic [FUNCT7_SIZE-1:0] funct7_i,
    input logic [FUNCT3_SIZE-1:0] funct3_i,
    input logic [WD_SIZE-1:0] op1_data_i,
    input logic [WD_SIZE-1:0] op2_data_i, // rs2 or imm sign extended
    
    input logic ctrl_reg_write_i,
    input logic ctrl_reg_write_o,
    
    input logic [INSTR_REG_SIZE-1:0] rd_i,
    output logic [INSTR_REG_SIZE-1:0] rd_o,

    /* output logic op_in_flight_o, */
    output logic op_ending_o,

    output logic valid_result_o,
    output logic [WD_SIZE-1:0] result_o
);

localparam integer DW_SIZE = 2*WD_SIZE;

multiplier #() m0_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_dc_m0),
    .op_o (op_m0_m1),
    .funct7_i (funct7_dc_m0),
    .funct3_i (funct3_ml_m0),
    .op1_data_i (op1_data_dc_m0),
    .op2_data_i (op2_data_ml_m0),
    .rd_i (rd_dc_m0),
    .rd_o (rd_m0_m1),
    .ctrl_reg_write_i (ctrl_reg_write_dc_m0),
    .ctrl_reg_write_o (ctrl_reg_write_m0_m1),
    /* .op_ending_o (mult_in_flight_ml_dc), */
    /* .valid_result_o (mult_valid_result_m_wb), */
    /* .result_o (mult_result_m_wb) */
);


typedef enum {M0, M1, M2, M3, M4} state_mult;

state_mult state;

logic [MUL_STAGES-2:0][WD_SIZE-1:0] op1_data_q, op2_data_q;
logic [MUL_STAGES-2:0] valid_instr;
logic [WD_SIZE-1:0] result_d, result_q;
logic valid_result_q, ctrl_reg_write_q, op_ending_d;

assign ctrl_reg_write_o = ctrl_reg_write_q;
assign op_ending_o = op_ending_d;


always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* valid_result_o <= 1'b0; */
        state <= M0;
        ctrl_reg_write_q <= 1'b0;
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
       valid_result_o <= valid_result_q;
       ctrl_reg_write_q <= valid_result_q & ctrl_reg_write_i;
       rd_o <= rd_i;
       result_o <= result_q;
   end
end

/* always_comb begin */
/*     if (!reset_n) begin */
/*         valid_result_q <= 1'b0; */
/*         valid_instr <= { {MUL_STAGES-2}{1'b0} }; */
/*         /1* op_in_flight_d = 1'b0; *1/ */
/*     end */
/*     else begin */
/*         unique case (state) */
/*             M0: begin */
/*                 valid_result_q <= 1'b0; */
/*                 valid_instr[M0] <= (op_i) && (funct7_i == F7_MULDIV) && (ctrl_reg_write_i); // & (funct3_i == F3_MUL); */
/*                 op1_data_q[M0] <= op1_data_i; */
/*                 op2_data_q[M0] <= op2_data_i; */
/*                 /1* op_in_flight_d = 1'b0; *1/ */
/*                 op_ending_d = 1'b0; */
/*             end // M0 */
/*             M1: begin */
/*                 valid_result_q <= 1'b0; */
/*                 valid_instr[M1] <= valid_instr[M0]; */
/*                 op1_data_q[M1] <= op1_data_q[M0]; */
/*                 op2_data_q[M1] <= op2_data_q[M0]; */
/*                 /1* op_in_flight_d = 1'b1; *1/ */
/*                 op_ending_d = 1'b0; */
/*             end // M1 */
/*             M2: begin */
/*                 valid_result_q <= 1'b0; */
/*                 valid_instr[M2] <= valid_instr[M1]; */
/*                 op1_data_q[M2] <= op1_data_q[M1]; */
/*                 op2_data_q[M2] <= op2_data_q[M1]; */
/*                 /1* op_in_flight_d = 1'b1; *1/ */
/*                 op_ending_d = 1'b0; */
/*             end // M2 */
/*             M3: begin */
/*                 valid_result_q <= 1'b0; */
/*                 valid_instr[M3] <= valid_instr[M2]; */
/*                 op1_data_q[M3] <= op1_data_q[M2]; */
/*                 op2_data_q[M3] <= op2_data_q[M2]; */
/*                 /1* op_in_flight_d = 1'b1; *1/ */
/*                 op_ending_d = 1'b0; */
/*             end // M3 */
/*             M4: begin */
/*                 valid_result_q <= 1'b1; */
/*                 result_q <= result_d; */
/*                 /1* op_in_flight_d = 1'b1; *1/ */
/*                 op_ending_d = 1'b1; */
/*             end // M4 */
/*         endcase */
/*     end */
/* end */

/* logic [DW_SIZE-1:0] mult_result_s, mult_result_su, mult_result_u; */
/* logic signed [WD_SIZE-1:0] op1_s, op2_s; */
/* logic unsigned [WD_SIZE-1:0] op1_u, op2_u; */

/* assign op1_s = signed'(op1_data_q[M3]); */
/* assign op2_s = signed'(op2_data_q[M3]); */
/* assign op1_u = unsigned'(op1_data_q[M3]); */
/* assign op2_u = unsigned'(op2_data_q[M3]); */

/* assign mult_result_s = op1_s * op2_s; */
/* assign mult_result_u = op1_u * op2_u; */
/* assign mult_result_su = op1_s * op2_u; */

/* always_comb begin */
/*     case (funct3_i) */ 
/*         F3_MUL: */ 
/*             result_d = mult_result_s[WD_SIZE-1:0]; */
/*         F3_MULH: */ 
/*             result_d = mult_result_s[DW_SIZE-1:WD_SIZE]; */
/*         F3_MULHSU: */
/*             result_d = mult_result_su[DW_SIZE-1:WD_SIZE]; */
/*         F3_MULHU: */
/*             result_d = mult_result_u[DW_SIZE-1:WD_SIZE]; */

/*         F3_DIV: */
/*             result_d = op1_s/op2_s; */
/*         F3_DIVU: */
/*             result_d = op1_u/op2_u; */
/*         F3_DIV: */
/*             result_d = op1_s%op2_s; */
/*         F3_DIVU: */
/*             result_d = op1_u%op2_u; */

/*     endcase */
/* end */

endmodule
