`timescale 1ps/1ps
import PARAMS_pkg::*;

module stage_mem #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_br_i,
    output logic [INSTR_SIZE-1:0] pc_br_o,

    input logic [INSTR_REG_SIZE-1:0] rd_i,
    output logic [INSTR_REG_SIZE-1:0] rd_o,
    output [INSTR_REG_SIZE-1:0] rd_dc_o,

    input logic [WD_SIZE-1:0] alu_result_i,
    output logic [WD_SIZE-1:0] alu_result_o,

    input logic alu_cmp_i,
    input logic [WD_SIZE-1:0] rs2_data_i,

    output logic take_br_o,
    input logic ctrl_ld_i, // load
    output logic ctrl_ld_o, // load
    input logic ctrl_st_i, // store
    input logic ctrl_jm_i, // jump
    /* output logic ctrl_jm_o, // jump */
    input logic ctrl_br_i,  // branch
    /* output logic ctrl_br_o,  // branch */
    input logic [FUNCT3_SIZE-1:0] ctrl_mem_width_i,
    input logic ctrl_reg_write_i,
    output logic ctrl_reg_write_o,
    input logic stall_proc_i,
    /* output logic stall_proc_o, */

    // dmem signals
    output [WD_SIZE-1:0] dmem_addr_o,
    output dmem_rd_wr_o,
    output dmem_op_en_o,
    output [WD_SIZE-1:0] dmem_wr_data_o,
    output [WD_SIZE-1:0] dmem_wr_keep_o,
    input [WD_SIZE-1:0] dmem_rd_data_i,

    output logic [WD_SIZE-1:0] mem_data_o

);

wire op_wr;
logic take_br_q;
logic [WD_SIZE-1:0] mem_data_q, dmem_wr_keep_d, dmem_wr_data_d;

assign dmem_addr_o = { alu_result_i[WD_SIZE-1:2], 2'b00 } ; //aligned addr
assign dmem_rd_wr_o = ctrl_st_i;
assign dmem_op_en_o = (ctrl_ld_i | ctrl_st_i) & !stall_proc_i;
assign dmem_wr_data_o = dmem_wr_data_d;
/* assign mem_data_q = dmem_rd_data_i; */

localparam integer BYTE = 8;
// load/store width
always_comb
begin
    case (ctrl_mem_width_i)
        MEM_ACCESS_BYTE: begin
            case (alu_result_i[1:0])
                2'b00: begin
                    mem_data_q = { { {WD_SIZE-7}{dmem_rd_data_i[7]} }, dmem_rd_data_i[6:0] }; // for loads
                    dmem_wr_keep_d = 32'h000000FF; // for stores
                end
                2'b01: begin
                    mem_data_q = { { {WD_SIZE-7}{dmem_rd_data_i[15]} }, dmem_rd_data_i[14:8] }; // load
                    dmem_wr_keep_d = 32'h0000FF00; // store
                end
                2'b10: begin
                    mem_data_q = { { {WD_SIZE-7}{dmem_rd_data_i[23]} }, dmem_rd_data_i[22:16] }; // load
                    dmem_wr_keep_d = 32'h00FF0000; // store
                end
                2'b11: begin
                    mem_data_q = { { {WD_SIZE-7}{dmem_rd_data_i[31]} }, dmem_rd_data_i[30:24] }; // load
                    dmem_wr_keep_d = 32'hFF000000; // store
                end
            endcase 

            // store
            dmem_wr_data_d = rs2_data_i << (alu_result_i[1:0] * BYTE);

        end // MEM_ACCESS_BYTE

        MEM_ACCESS_HALF: begin
            case(alu_result_i[1])
                1'b0: begin
                    mem_data_q = { { {WD_SIZE-15}{dmem_rd_data_i[15]} }, dmem_rd_data_i[14:0] }; // load
                    dmem_wr_keep_d = 32'h0000FFFF; // store
                end
                1'b1: begin
                    mem_data_q = { { {WD_SIZE-15}{dmem_rd_data_i[31]} }, dmem_rd_data_i[30:16] }; // load
                    dmem_wr_keep_d = 32'hFFFF0000; // store
                end
            endcase
            
            // store
            dmem_wr_data_d = rs2_data_i << (alu_result_i[1] * BYTE * 2);
        end // MEM_ACCESS_HALF
        
        default:  begin // MEM_ACCESS_WORD
            mem_data_q = dmem_rd_data_i; // load
            dmem_wr_keep_d = 32'hFFFFFFFF; // store
            dmem_wr_data_d = rs2_data_i;
        end 
    endcase
end

assign dmem_wr_keep_o = dmem_wr_keep_d;

assign take_br_q = ctrl_br_i && alu_cmp_i;

assign rd_dc_o = rd_i;


always_ff@(posedge clk) begin
    if (!reset_n) begin
        /* op_en <= 1'b0; */
        take_br_o <= 1'b0;
        ctrl_reg_write_o <= 1'b0;
        /* rd_dc_o <= 1'b0; */
    end
    if (reset_n) begin
        ctrl_ld_o <= ctrl_ld_i;
        /* ctrl_jm_o <= ctrl_jm_i; */
        /* ctrl_br_o <= ctrl_br_i; */
        pc_br_o <= pc_br_i;
        rd_o <= rd_i;
        /* opcode_o <= opcode_i; */
        alu_result_o <= alu_result_i;
        ctrl_reg_write_o <= ctrl_reg_write_i;

        mem_data_o <= mem_data_q;
        take_br_o <= take_br_q;


    end
end

/* memory #( */
/*     .MEM_SIZE_BITS (128*4); */
/* ) imem ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .addr(alu_result_i), */
/*     .rd_wr(op_wr), */
/*     .op_en(op_en), */
/*     .wr_data(alu_result_i), */
/*     .rd_data(rd_data); */
/* ); */

endmodule

