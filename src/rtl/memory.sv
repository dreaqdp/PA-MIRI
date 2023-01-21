`timescale 1ps/1ps
import PARAMS_pkg::*;

module memory #(
    parameter MEM_SIZE_BITS = 128*4,
    parameter MEM_SIZE_BYTES = MEM_SIZE_BITS/8,
    parameter INPUT_SIZE = 32*4
) (
    input clk,
    input reset_n,

    input [ADDR_SIZE-1:0] addr,
    input op_rd_wr, // 0 rd, 1 wr
    input op_en,
    input [WD_SIZE-1:0] wr_data,
    input [WD_SIZE-1:0] wr_keep, // which bytes from wr_data have to be
    // written in mem
    output logic [WD_SIZE-1:0] rd_data,

    // sim
    input [INPUT_SIZE-1:0][7:0] input_data
);

logic [MEM_SIZE_BYTES-1:0][7:0] memory;

logic [WD_SIZE-1:0] wr_data_keep, mem_data;

assign mem_data = memory[addr[11:0]+:WD_SIZE];
localparam integer BYTE = 8;

genvar i;
generate
    for (i = 0; i < WD_SIZE; i += BYTE) begin // iterate byte per byte
        assign wr_data_keep[i+:BYTE] = &wr_keep[i+:BYTE] ? wr_data[i+:BYTE] : mem_data[i+:BYTE];
    end
endgenerate

always_comb begin
    if (!reset_n) begin
        /* memory <= {{MEM_SIZE_BITS}{1'b0}}; */
        memory <= input_data;
        rd_data <= {{WD_SIZE}{1'b0}};
    end
    else begin
        if (op_en) begin
            case (op_rd_wr) 
                1'b1: memory[addr[11:0]+:WD_SIZE] <= wr_data_keep; // write
                default: rd_data <= memory[addr[11:0]+:WD_SIZE]; // read 
            endcase
        end
    end
end

endmodule
