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
    output logic instr_valid_o,

    //memory ports
    output [INSTR_SIZE-1:0] imem_addr_o,
    output imem_rd_wr_o,
    output imem_op_en_o,
    input [INSTR_SIZE-1:0] imem_rd_instr_i,

    input logic stall_proc_i

);

logic [INSTR_SIZE-1:0] pc, next_pc;
logic op_rd;

/* wire pc_next4; */

/* assign op_rd = RD; */
/* assign op_en = 1'b1; */
/* assign op_en = reset_n; */

assign imem_addr_o = pc;
/* assign next_pc = pc + 4; */

/* assign imem_rd_wr = op_rd; */
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

always_ff@(posedge clk) 
begin
    if (!reset_n) begin
        pc <= BOOT_ADDR;
        instr_o <= NOP_INSTR;
        instr_valid_o <= 1'b0;
    end
    else begin

        instr_o <= imem_rd_instr_i;
        instr_valid_o <= 1'b1;
    
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
