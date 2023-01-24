`timescale 1ns/1ps
import PARAMS_pkg::*;

module stage_decode #() (
    input clk,
    input reset_n,

    input logic [INSTR_SIZE-1:0] pc_i,
    output logic [INSTR_SIZE-1:0] pc_o,

    input logic[INSTR_SIZE-1:0] instr_i,
    input logic instr_valid_i,

    // from wb
    input logic ctrl_reg_write_i,
    input logic [INSTR_REG_SIZE-1:0] wr_rd_i,
    input logic [WD_SIZE-1:0] wr_data_i,

    output logic [OPCODE_SIZE-1:0] ctrl_opcode_o,
    output logic [FUNCT7_SIZE-1:0] ctrl_funct7_o,
    output logic [FUNCT3_SIZE-1:0] ctrl_funct3_o,
    output logic [WD_SIZE-1:0] rs1_data_o,
    output logic [WD_SIZE-1:0] rs2_data_o,
    output logic [WD_SIZE-1:0] imm_se_o, //sign extended
    output logic [INSTR_REG_SIZE-1:0] rd_o, //,

    output logic ctrl_op_o, // arith op
    output logic ctrl_ml_o, // mult div
    output logic ctrl_ld_o, // load
    output logic ctrl_st_o, // store
    output logic ctrl_jm_o, // jump
    output logic ctrl_br_o,  // branch
    output logic ctrl_reg_write_o,
    output logic ctrl_reg_write_ml_o,

    input logic [WD_SIZE-1:0] bypass_mem_data_mem_i,
    input logic bypass_ctrl_reg_write_mem_i,
    input logic [WD_SIZE-1:0] bypass_result_alu_i,
    input logic bypass_ctrl_reg_write_alu_i,
    input logic [WD_SIZE-1:0] bypass_result_ml_i,
    input logic bypass_ctrl_reg_write_ml_i,

    input logic [INSTR_REG_SIZE-1:0] rd_ex_i, // to check dependencies
    input logic [INSTR_REG_SIZE-1:0] rd_mem_i, // to check dependencies
    input logic [INSTR_REG_SIZE-1:0] rd_m0_i, // to check dependencies from mul div
    input logic [INSTR_REG_SIZE-1:0] rd_m1_i, // to check dependencies from mul div
    input logic [INSTR_REG_SIZE-1:0] rd_m2_i, // to check dependencies from mul div
    input logic [INSTR_REG_SIZE-1:0] rd_m3_i, // to check dependencies from mul div
    input logic [INSTR_REG_SIZE-1:0] rd_m4_i, // to check dependencies from mul div

    /* input logic mult_in_flight_i, */

    output logic stall_proc_if_o,
    output logic stall_proc_ex_o
    // input logic rd wb comes in rd_i


);

logic [INSTR_REG_SIZE-1:0] rs1, rs2;
logic match_rs1, match_rs2;

logic [OPCODE_SIZE-1:0] opcode_q;
logic [FUNCT7_SIZE-1:0] funct7_q;
logic [FUNCT3_SIZE-1:0] funct3_q;
logic [WD_SIZE-1:0] rs1_data_q, rs2_data_q, rs1_data_d, rs2_data_d, imm_se_q;
logic [INSTR_REG_SIZE-1:0] rd_q;
logic ctrl_op_q, ctrl_ml_q, ctrl_ld_q, ctrl_st_q, ctrl_jm_q, ctrl_br_q;
logic ctrl_op_d, ctrl_ml_d, ctrl_ld_d, ctrl_st_d, ctrl_jm_d, ctrl_br_d;
logic [INSTR_SIZE-1:0] instr_q;

logic dependency, mult_in_flight;

assign rd_o = rd_q;
assign ctrl_funct3_o = funct3_q;
assign ctrl_funct7_o = funct7_q;

assign rs1 = instr_i[19:15];
assign rs2 = instr_i[24:20];
assign opcode_q = instr_i[6:0];

// dependencies check
logic match_rs1_mult, match_rs2_mult;

assign match_rs1_mult = (rd_m0_i == rs1) | (rd_m1_i == rs1) | (rd_m2_i == rs1) | (rd_m3_i == rs1) | (rd_m4_i == rs1);
assign match_rs2_mult = (rd_m0_i == rs2) | (rd_m1_i == rs2) | (rd_m2_i == rs2) | (rd_m3_i == rs2) | (rd_m4_i == rs2);

// prebypasses
/* assign match_rs1 = ((rd_ex_i == rs1) || (rd_mem_i == rs1) || (match_rs1_mult)) && (rs1 != { {INSTR_REG_SIZE}{1'b0} }); // do not detect dependency if reg x0 is being used in the instruction */
/* assign match_rs1 = ((rd_ex_i == rs1) || (rd_mem_i == rs1) || (match_rs1_mult)) && (rs1 != { {INSTR_REG_SIZE}{1'b0} }); // do not detect dependency if reg x0 is being used in the instruction */
/* assign match_rs2 = ((rd_ex_i == rs2) || (rd_mem_i == rs2) || (match_rs2_mult)) && (rs2 != { {INSTR_REG_SIZE}{1'b0} }); */
// postbypasses
assign dp_load_rs1 = ( ctrl_ld_d && (rd_ex_i == rs1) );
assign dp_load_rs2 = ( ctrl_ld_d && (rd_ex_i == rs2) );
assign match_rs1 = (match_rs1_mult) && (rs1 != { {INSTR_REG_SIZE}{1'b0} }); // do not detect dependency if reg x0 is being used in the instruction
assign match_rs2 = (match_rs2_mult) && (rs2 != { {INSTR_REG_SIZE}{1'b0} });


assign dependency = (match_rs1 | match_rs2) & instr_valid_i & (dp_load_rs1 | dp_load_rs2) ; // if rd of a previous instr matches de current instr

assign diff_instr_types = ( ( rd_m0_i || rd_m1_i || rd_m2_i || rd_m3_i || rd_m4_i ) != 5'b0 ) && (!ctrl_ml_d);
logic stall_proc_if_d;
assign stall_proc_if_d = dependency | diff_instr_types; //| mult_in_flight;
assign stall_proc_if_o = stall_proc_if_d | 1'b0;
// end dependencies check

logic ctrl_reg_write_d;
assign ctrl_reg_write_d = (ctrl_op_d || ctrl_ld_d) && (instr_i[11:7] != 5'b0) && !stall_proc_if_d; // & instr_valid_i ; // write only if op or load instr and not a NOP instr and not stalling proc

assign ctrl_reg_write_ml_d = (ctrl_ml_d) && (instr_i[11:7] != 5'b0) && !dependency ; // write only if mul div instr and not a NOP instr and not stalling proc

assign ctrl_op_o = ctrl_op_q; // reg write
assign ctrl_ml_o = ctrl_ml_q; // reg write
assign ctrl_ld_o = ctrl_ld_q; // mem read & reg write
assign ctrl_st_o = ctrl_st_q; // mem write
assign ctrl_jm_o = ctrl_jm_q; // jump
assign ctrl_br_o = ctrl_br_q; // branch

always_ff@(posedge clk) begin
    if (!reset_n) begin
        ctrl_reg_write_o <= 1'b0;
        ctrl_reg_write_ml_o <= 1'b0;
        ctrl_br_q <= 1'b0;
        rd_q <= { {INSTR_REG_SIZE}{1'b0} };
        ctrl_ml_q <= 1'b0;
        
    end 
    else begin
        pc_o <= pc_i;

        if (dependency) begin
            rd_q <= 5'b0;
        end
        else begin
            rd_q <= instr_i[11:7];
        end
            funct3_q <= instr_i[14:12];
            funct7_q <= instr_i[31:25];
        imm_se_o <= imm_se_q;
        ctrl_opcode_o <= opcode_q;
        ctrl_op_q <= ctrl_op_d; // reg write
        ctrl_ml_q <= ctrl_ml_d; // reg write
        ctrl_ld_q <= ctrl_ld_d; // mem read & reg write
        ctrl_st_q <= ctrl_st_d; // mem write
        ctrl_jm_q <= ctrl_jm_d; // jump
        ctrl_br_q <= ctrl_br_d; // branch

        ctrl_reg_write_o <= ctrl_reg_write_d;
        ctrl_reg_write_ml_o <= ctrl_reg_write_ml_d;
        stall_proc_ex_o <= dependency;

        if ( (wr_rd_i == rs1) & ctrl_reg_write_i )
            rs1_data_o <= wr_data_i;
        else
            rs1_data_o <= rs1_data_d;
        if ( (wr_rd_i == rs2) & ctrl_reg_write_i )
            rs2_data_o <= wr_data_i;
        else
            rs2_data_o <= rs2_data_d;

    end
end

always_comb begin
    if ( (rs1 == rd_mem_i) && bypass_ctrl_reg_write_mem_i ) begin
        rs1_data_d = bypass_mem_data_mem_i;
    end
    else if ( (rs1 == rd_ex_i) && bypass_ctrl_reg_write_alu_i ) begin
        rs1_data_d = bypass_result_alu_i;
    end
    else if ( (rs1 == rd_m4_i) && bypass_ctrl_reg_write_ml_i ) begin
        rs1_data_d = bypass_result_ml_i;
    end
    else begin
        rs1_data_d = rs1_data_q;
    end
    
    if ( (rs2 == rd_mem_i) && bypass_ctrl_reg_write_mem_i ) begin
        rs2_data_d = bypass_mem_data_mem_i;
    end
    else if ( (rs2 == rd_ex_i) && bypass_ctrl_reg_write_alu_i ) begin
        rs2_data_d = bypass_result_alu_i;
    end
    else if ( (rs2 == rd_m4_i) && bypass_ctrl_reg_write_ml_i ) begin
        rs2_data_d = bypass_result_ml_i;
    end
    else begin
        rs2_data_d = rs2_data_q;
    end
end

always_comb begin
    case (opcode_q) // generate immediate
        OPCODE_ST: imm_se_q <= { { {WD_SIZE-11}{instr_i[31]} }, instr_i[30:25], instr_i[11:8], instr_i[7] };
        OPCODE_BR: imm_se_q <= { { {WD_SIZE-12}{instr_i[31]} }, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0 };
        OPCODE_JM: imm_se_q <= { { {WD_SIZE-20}{instr_i[31]} }, instr_i[19:12], instr_i[20],  instr_i[30:25], instr_i[24:21], 1'b0 }; 
        default:  // OPCODE_OP, OPCODE_LD --> I-type instr_i
            imm_se_q <= { { {WD_SIZE-11}{instr_i[31]} }, instr_i[30:20] };
    endcase
end

always_comb begin
    case (opcode_q) 
        OPCODE_LD: begin
            ctrl_op_d = 1'b0;
            ctrl_ml_d = 1'b0; 
            ctrl_ld_d = 1'b1;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b0;
        end // OPCODE_LD
        OPCODE_ST: begin
            ctrl_op_d = 1'b0;
            ctrl_ml_d = 1'b0; 
            ctrl_ld_d = 1'b1;
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b1;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b0;
        end // OPCODE_ST
        OPCODE_JM: begin
            ctrl_op_d = 1'b0;
            ctrl_ml_d = 1'b0;
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b1;
            ctrl_br_d = 1'b0;
        end // OPCODE_JM
        OPCODE_BR: begin
            ctrl_op_d = 1'b0;
            ctrl_ml_d = 1'b0;
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b1;
        end // OPCODE_BR
        OPCODE_OP: begin // OPCODE_OP
            if (funct7_q == F7_MULDIV) begin
                ctrl_op_d = 1'b0;
                ctrl_ml_d = 1'b1;
            end
            else begin
                ctrl_op_d = 1'b1;
                ctrl_ml_d = 1'b0;
            end
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b0;
        end // OPCODE_OP
        OPCODE_IM: begin // OPCODE_IM
            ctrl_op_d = 1'b1;
            ctrl_ml_d = 1'b0;
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b0;
        end // OPCODE_IM
        default: begin 
            ctrl_op_d = 1'b0;
            ctrl_ml_d = 1'b0;
            ctrl_ld_d = 1'b0;
            ctrl_st_d = 1'b0;
            ctrl_jm_d = 1'b0;
            ctrl_br_d = 1'b0;
        end
    endcase
end

register_file #() reg_file (
    .clk (clk),
    .reset_n (reset_n),
    .rs1 (rs1),
    .rs2 (rs2),
    .reg_write (ctrl_reg_write_i),
    .wr_rd (wr_rd_i),
    .wr_data (wr_data_i),
    .rs1_data (rs1_data_q),
    .rs2_data (rs2_data_q)
);

/* control #() control_logic ( */
/*     .clk (clk), */
/*     .reset_n (reset_n), */
/*     .instr_i (instr_i), */
/*     .opcode_o (ctrl_opcode), */
/* ); */

endmodule
