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

    output zero_o,
    output logic [WD_SIZE-1:0] result_o
);

assign zero_o = op1_data_i == op2_data_i;
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

endmodule

