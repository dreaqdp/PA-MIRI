`timescale 1ps/1ps
import PARAMS_pkg::*;

module memory #(
    parameter MEM_SIZE_BITS = 128*4;
    parameter MEM_SIZE_BYTES = MEM_SIZE_BITS/8;
) (
    input clk;
    input reset_n;

    input [ADDR_SIZE-1:0] addr;
    input rd_wr;
    input op_en;
    input [WD_SIZE-1:0] wr_data;
    output [WD_SIZE-1:0] rd_data;
);

logic [MEM_SIZE_BYTES-1:0][7:0] memory;

always_ff@(posedge clk) begin
    if (!reset_n) begin
        memory <= {{MEM_SIZE_BITS}{1'b0}};
        rd_data <= {{WD_SIZE}{1'b0}};
    end
end

always_comb begin
    if(reset_n) begin
        if (op_en) begin
            case (rd_wr) 
                1'b1: memory[addr+:WD_SIZE] <= wr_data; // write
                default: rd_data <= memory[addr+:WD_SIZE]; // read 
            endcase
        end
    end
end

endmodule
