`timescale 1ps/1ps
import PARAMS_pkg::*;

module register_file #(
    parameter REG_NUM = 32,
    parameter SPECIAL_REG_NUM = 2
) (
    input clk,
    input reset_n,

    input [INSTR_REG_SIZE-1:0] rs1,
    input [INSTR_REG_SIZE-1:0] rs2,
    input reg_write,
    input [INSTR_REG_SIZE-1:0] wr_rd,
    input [WD_SIZE-1:0] wr_data,

    output [WD_SIZE-1:0] rs1_data,
    output [WD_SIZE-1:0] rs2_data
);

logic [REG_NUM-1:0][WD_SIZE-1:0] registers;

assign rs1_data = registers[rs1];
assign rs2_data = registers[rs2];

always_ff@(posedge clk) begin
    if (!reset_n) begin
        registers <= { {REG_NUM*WD_SIZE}{1'b0} };
    end
end

always_ff@(negedge clk) begin
    if (reset_n) begin
        if (wr_rd != 0 && reg_write) // register x0 cannot be modified
            registers[wr_rd] <= wr_data;
    end
end

endmodule

