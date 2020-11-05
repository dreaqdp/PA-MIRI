`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_fetch #()(
    input clk;
    input reset_n;
    input logic[INSTR_SIZE-1:0] pc_jump;
    output logic[INSTR_SIZE-1:0] pc_actual;
    output logic[INSTR_SIZE-1:0] instr;
);

logic [INSTR_SIZE-1:0] pc;
logic rd_en;

wire pc_next4;
wire rd_instr;

assign rd_instr = 1'b1;
assign rd_en = 1'b1;


always_ff@(posedge clk) 
begin
    if (!reset_n) begin
        pc <= BOOT_ADDR;
        pc_jump <= BOOT_ADDR;
        pc_actual <= BOOT_ADDR;
        instr <= NOP_INSTR;
    end
    else begin
        case (instr_jump)
            1'b1:  pc <= pc_jump;
            default: pc <= pc + 4; //pc <= pc_next4;
        endcase
    end
end

memory #(
    .MEM_SIZE_BITS (128*4);
) imem (
    .clk (clk),
    .reset_n (reset_n),
    .addr(pc),
    .rd_wr(rd_instr),
    .op_en(rd_en),
    .wr_data({{WD_SIZE}{1'b0}},
    .rd_data(instr);
);

endpackage
