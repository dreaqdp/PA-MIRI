`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_fetch #()(
    input clk,
    input reset_n,

    input logic[INSTR_SIZE-1:0] pc_i,
    output logic[INSTR_SIZE-1:0] pc_o,

    /* input logic instr_jm, */
    input logic take_br_i,

    output logic[INSTR_SIZE-1:0] instr_o,
    output logic instr_valid_dc_o,
    output logic instr_valid_ex_o,

    //memory ports
    output [INSTR_SIZE-1:0] imem_addr_o,
    output imem_rd_wr_o,
    output imem_op_en_o,
    input [INSTR_SIZE-1:0] imem_rd_instr_i,

    input logic stall_proc_i

);

logic [INSTR_SIZE-1:0] pc, next_pc;
logic op_rd;
logic kill;
logic instr_valid_q, instr_valid_d;

assign imem_addr_o = pc;

assign imem_rd_wr_o = RD;
assign imem_op_en_o = reset_n & !stall_proc_i;

always_comb 
begin
        if (take_br_i)
            next_pc <= pc_i;
        else if (!stall_proc_i)
            next_pc <= pc + 4; //pc <= pc_next4;
        else 
            next_pc <= pc;
end

assign pc_o = pc;

assign kill = take_br_i;
assign instr_valid_d = ~(stall_proc_i | kill);
assign instr_valid_ex_o = instr_valid_d;
assign instr_valid_dc_o = instr_valid_q | instr_valid_d;

always_ff@(posedge clk) 
begin
    if (!reset_n) begin
        pc <= BOOT_ADDR;
        instr_o <= NOP_INSTR;
        instr_valid_q <= 1'b0;
    end
    else begin

        instr_o <= imem_rd_instr_i;
        instr_valid_q <= instr_valid_d;
    
        pc <= next_pc;
    end
end


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

endmodule
