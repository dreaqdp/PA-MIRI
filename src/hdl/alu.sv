`timescale 1ps/1ps
import PARAMS_pkg::*;

module alu #() (
    input clk,
    input reset_n,

    input /*logic*/ [OPCODE_BITS-1:0] opcode,
    input /*logic*/ [FUNCT7_BITS-1:0] funct7,
    input /*logic*/ [FUNCT3_BITS-1:0] funct3,
    input /*logic*/ [WD_SIZE-1:0] op1_data,
    input /*logic*/ [WD_SIZE-1:0] op2_data,

    output zero,
    output [WD_SIZE-1:0] result
);

/* assign zero = ; // TODO, revisar que coi avaluo a 0 */
// TODO falta BEQ
always_comb begin
    case (opcode)
        OPCODE_OP: begin
            case (funct7)
                SUBS: result = op2_data - op1_data;
                default:  // add
                    result = op1_data + op2_data;
            endcase
        end // OPCODE_OP

        default: // OPCODE_LD, OPCODE_ST, OPCODE_JM, OPCODE_BR
            result = op1_data + op2_data;
    endcase
end


endmodule

