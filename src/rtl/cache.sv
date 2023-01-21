`timescale 1ps/1ns
import PARAMS_pkg::*;

module cache #(
    parameter CACHE_LINE_SIZE_BYTES = 64,
    parameter CACHE_LINE_SIZE_BITS = CACHE_LINE_SIZE_BYTES * 8,
    parameter CACHE_NUM_LINES = 4
    parameter CACHE_OFFSET_BITS = $clog2(CACHE_LINE_SIZE_BYTES):
    parameter CACHE_NUM_LINE_BITS = $clog2(CACHE_NUM_LINE);
    parameter CACHE_TAG_BITS = ADDR_SIZE - CACHE_OFFSET_BITS - CACHE_NUM_LINE_BITS;
) (
    input clk,
    input reset_n,

    // request from instr
    input [ADDR_SIZE-1:0] addr_i,
    input op_en_i,
    input op_rd_wr_i,
    input data_i,

    // answer to req from instr
    output [WD_SIZE-1:0] data_o,
    output valid_data_o,

    output stall_cache_o,

    // req to mem/tlb in miss 
    output [ADDR_SIZE-1:0] mem_addr_o,
    output mem_op_rd_wr_o,
    output mem_op_en_o,
    output [CACHE_LINE_BYTES-1:0]mem_data_o, // write back
    input mem_data_i // line1

);

/* logic [CACHE_NUM_LINES-1:0][CACHE_LINE_BYTES-1:0][7:0] cache_data; */
logic [CACHE_NUM_LINES-1:0][CACHE_LINE_SIZE_BITS-1:0] cache_data;
logic [CACHE_NUM_LINES-1:0][CACHE_TAG_BITS-1:0] cache_tag;
logic [CACHE_NUM_LINES-1:0] cache_valid_bit;
logic [CACHE_NUM_LINES-1:0] cache_dirty_bit;

logic hit_cache;

wire [CACHE_TAG_BITS-1:0] tag;
wire [CACHE_NUM_LINE_BITS-1:0] line;
wire [CACHE_OFFSET_BITS-1:0] offset;

assign tag = addr_i[WD_SIZE-1:WD_SIZE-CACHE_TAG_BITS];
assign line = addr_i[CACHE_LINE_BITS+CACHE_OFFSET_BITS-1: CACHE_OFFSET_BITS];
assign offset = addr_i[CACHE_OFFSET_BITS-1:0];

assign stall_cache_o = (!valid_data_q);

assign hit_cache = (tag == cache_tag[line]) & cache_valid_bit[line];
assign valid_data_o = hit_cache;

always_comb begin
    if (!reset_n) begin
        hit_cache <= 1'b0;
        cache_valid_bit <= { {CACHE_NUM_LINES}{1'b0} };
        cache_dirty_bit <= { {CACHE_NUM_LINES}{1'b0} };
        cache_data <= { {CACHE_NUM_LINES*CACHE_LINE_SIZE_BYTES}{1'b0} };
        mem_op_en_o <= 1'b0;
    end
    else begin
        if (op_en) begin
            if (op_rd_wr) begin // write
                cache_data[line][offset+:WD_SIZE] <= data_i;
                cache_dirty_bit[line] <= 1'b1;
            end
            else begin //read
                valid_data_q <= tag == cache_tag[line];
                data_o <= cache_data[line][offset+:WD_SIZE];

            end

            mem_op_en_o <= !valid_data_q;
            if (!valid_data_q) begin // miss
                mem_addr_o <= addr_i;
                mem_op_rd_wr_o <= op_rd_wr_i;

                +gT

                // dirty a 0, valid a 1



            end
        end
    end
end


endmodule

