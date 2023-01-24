`timescale 1ns/1ps
import PARAMS_pkg::*;

module mult_div #(
    parameter bit FINAL_STAGE = 0
) (
    input clk,
    input reset_n,

    input logic op_i,
    input logic op_o,
    input logic [FUNCT7_SIZE-1:0] funct7_i,
    output logic [FUNCT7_SIZE-1:0] funct7_o,
    input logic [FUNCT3_SIZE-1:0] funct3_i,
    output logic [FUNCT3_SIZE-1:0] funct3_o,
    input logic [WD_SIZE-1:0] op1_data_i,
    output logic [WD_SIZE-1:0] op1_data_o,
    input logic [WD_SIZE-1:0] op2_data_i, 
    output logic [WD_SIZE-1:0] op2_data_o,
    
    input logic ctrl_reg_write_i,
    output logic ctrl_reg_write_o,
    
    input logic [INSTR_REG_SIZE-1:0] rd_i,
    output logic [INSTR_REG_SIZE-1:0] rd_o,

    output logic [WD_SIZE-1:0] bypass_ml_data_o,
    output logic bypass_ctrl_reg_write_ml_o,

    output logic valid_result_o,
    output logic [WD_SIZE-1:0] result_o
);

localparam integer DW_SIZE = 2*WD_SIZE;

logic ctrl_reg_write_q, op_q;
logic [FUNCT7_SIZE-1:0] funct7_q;
logic [FUNCT3_SIZE-1:0] funct3_q;
logic [WD_SIZE-1:0] op1_data_q, op2_data_q;
logic [INSTR_REG_SIZE-1:0] rd_q;

assign op_o = op_q;
assign ctrl_reg_write_o = ctrl_reg_write_q;
assign funct7_o = funct7_q;
assign funct3_o = funct3_q;
assign op1_data_o = op1_data_q;
assign op2_data_o = op2_data_q;
assign rd_o = rd_q;

always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* ctrl_reg_write_q <= 1'b0; */
        rd_q <= 5'b0;
    end
    else begin
        op_q <= op_i;
        funct7_q <= funct7_i;
        funct3_q <= funct3_i;
        op1_data_q <= op1_data_i;
        op2_data_q <= op2_data_i;
        rd_q <= ctrl_reg_write_i ? rd_i : 5'b0;
    end
        ctrl_reg_write_q <= ctrl_reg_write_i;
end

// for final stage
logic [DW_SIZE-1:0] mult_result_s, mult_result_su, mult_result_u;
logic signed [WD_SIZE-1:0] op1_s, op2_s;
logic unsigned [WD_SIZE-1:0] op1_u, op2_u;


generate 
logic valid_result_d;
logic [WD_SIZE-1:0] result_d;
    if (FINAL_STAGE == 1) begin

        assign op1_s = signed'(op1_data_i);
        assign op2_s = signed'(op2_data_i);
        assign op1_u = unsigned'(op1_data_i);
        assign op2_u = unsigned'(op2_data_i);

        assign mult_result_s = op1_s * op2_s;
        assign mult_result_u = op1_u * op2_u;
        assign mult_result_su = op1_s * op2_u;

        always_comb begin
            case (funct3_i) 
                F3_MUL: 
                    result_d = mult_result_s[WD_SIZE-1:0];
                F3_MULH: 
                    result_d = mult_result_s[DW_SIZE-1:WD_SIZE];
                F3_MULHSU:
                    result_d = mult_result_su[DW_SIZE-1:WD_SIZE];
                F3_MULHU:
                    result_d = mult_result_u[DW_SIZE-1:WD_SIZE];

                F3_DIV:
                    result_d = op1_s/op2_s;
                F3_DIVU:
                    result_d = op1_u/op2_u;
                F3_DIV:
                    result_d = op1_s%op2_s;
                F3_DIVU:
                    result_d = op1_u%op2_u;

            endcase
        end
        assign valid_result_d = (op_i) && (funct7_i == F7_MULDIV) && (ctrl_reg_write_i); // & (funct3_i == F3_MUL);

        assign bypass_ml_data_o = result_d;
        assign bypass_ctrl_reg_write_ml_o = ctrl_reg_write_i;

        always_ff@(posedge clk) begin
            if (!reset_n) begin
                valid_result_o <= 1'b0;
            end
            else begin
                valid_result_o <= valid_result_d;
                result_o <= result_d;
            end
        end
    end

endgenerate


endmodule
