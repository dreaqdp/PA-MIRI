`timescale 1ns/1ps
import PARAMS_pkg::*;

module alu #() (
    input clk,
    input reset_n,

    input /*logic*/ [OPCODE_SIZE-1:0] opcode_i,
    input /*logic*/ [FUNCT7_SIZE-1:0] funct7_i,
    input /*logic*/ [FUNCT3_SIZE-1:0] funct3_i,
    input /*logic*/ [WD_SIZE-1:0] op1_data_i,
    input /*logic*/ [WD_SIZE-1:0] op2_data_i, // rs2 
    input /*logic*/ [WD_SIZE-1:0] imm_se_i, // imm sign extended

    output cmp_o,
    output logic [WD_SIZE-1:0] result_o
);

/* assign zero_o = op1_data_i == op2_data_i; */
/* assign result_o = result_q; */

always_comb begin
    case (opcode_i)
        OPCODE_OP: begin
            case (funct7_i)
                F7_SUB: 
                    result_o = op1_data_i - op2_data_i;
                default:  // add
                    result_o = op1_data_i + op2_data_i;
            endcase
        end // OPCODE_OP

        OPCODE_IM: begin
            case (funct3_i)
                F3_ADD: 
                    result_o = op1_data_i + imm_se_i; // ADDI: rs1 + sign_extended immediate (12b)
                default:
                    result_o = 32'b0;
            endcase
        end // OPCODE_IM

        default: // OPCODE_LD, OPCODE_ST, OPCODE_JM, OPCODE_BR
            result_o = op1_data_i + imm_se_i;
    endcase
end

logic signed [WD_SIZE-1:0] op1_s, op2_s;
logic unsigned [WD_SIZE-1:0] op1_u, op2_u;
logic cmp_d;

assign op1_s = signed'(op1_data_i);
assign op2_s = signed'(op2_data_i);
assign op1_u = unsigned'(op1_data_i);
assign op2_u = unsigned'(op2_data_i);

assign cmp_o = cmp_d;

always_comb begin
    case (funct3_i)
        F3_BNE: cmp_d = op1_s != op2_s;
        F3_BLT: cmp_d = op1_s < op2_s;
        F3_BLTU: cmp_d = op1_u < op2_u;
        F3_BGE: cmp_d = op1_s >= op2_s;
        F3_BGEU: cmp_d = op1_u >= op2_u;
        default: cmp_d = op1_s == op2_s; // BEQ
    endcase

end

endmodule

