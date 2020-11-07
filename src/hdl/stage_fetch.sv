`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_fetch #()(
    input clk,
    input reset_n,

    input logic[INSTR_SIZE-1:0] pc_i,
    output logic[INSTR_SIZE-1:0] pc_o,

    input logic instr_jm,
    output logic[INSTR_SIZE-1:0] instr,

    //memory ports
    output [INSTR_SIZE-1:0] rd_pc,
    output rd_wr,
    output op_en,
    input rd_instr
);

logic [INSTR_SIZE-1:0] pc;
logic op_en, op_rd;

/* wire pc_next4; */

assign op_rd = RD;
assign op_en = 1'b1;

always_ff@(posedge clk) 
begin
    if (!reset_n) begin
        pc <= BOOT_ADDR;
        pc_actual <= BOOT_ADDR;
        instr <= NOP_INSTR;
    end
    else begin
        if (instr_jm)
            pc <= pc_jump;
        else
            pc <= pc + 4; //pc <= pc_next4;

        instr <= rd_instr;
    
        pc_o = pc;
    end
end


assign rd_pc = pc;
assign rd_wr = op_rd;
/* memory #( */
/*     .MEM_SIZE_BITS (128*4); */
/* ) imem ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .addr(pc), */
/*     .rd_wr(op_rd), */
/*     .op_en(op_en), */
/*     .wr_data({{WD_SIZE}{1'b0}}), */
/*     .rd_data(instr); */
/* ); */

endpackage
