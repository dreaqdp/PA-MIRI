
`timescale 1 ns / 1 ns

import PARAMS_pkg::*;

//-----------------------------
// Print colors
//-----------------------------

`define START_GREEN_PRINT $write("%c[1;32m",27);
`define START_RED_PRINT $write("%c[1;31m",27);
`define END_COLOR_PRINT $write("%c[0m",27);

module tb_module();

//-----------------------------
// Local parameters
//-----------------------------

parameter VERBOSE         = 1;
parameter CLK_PERIOD      = 2;
parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;

logic clk, reset_n;
logic [INSTR_SIZE-1:0] pc_i, pc_o, instr_i;
logic [INSTR_REG_SIZE-1:0] rd_ex_i, rd_mem_i, rd_o;

logic ctrl_op_o, ctrl_ld_o, ctrl_st_o, ctrl_jm_o, ctrl_br_o, ctrl_reg_write_i, ctrl_reg_write_o;
logic .wr_rd_i, .wr_data_i, 

    logic  [OPCODE_SIZE-1:0] opcode_o;
    logic  [FUNCT7_SIZE-1:0] funct7_o;
    logic  [FUNCT3_SIZE-1:0] funct3_o;
    logic  [WD_SIZE-1:0] rs1_data_o, rs2_data_o, rs2_data_o;
    logic  [WD_SIZE-1:0] imm_se_o;

    logic alu_zero_o;
    logic  [WD_SIZE-1:0] alu_result_o;

reg[64*8:0] tb_test_name;

//-----------------------------
// Module
//-----------------------------

stage_decode #() stage_decode_inst (
    .clk (clk),
    .reset_n (reset_n),
    .pc_i (pc_if_id),
    .pc_o (pc_id_ex),
    .instr_i (instr),
    .wr_rd_i (rd_wb_id),
    .wr_data_i (rd_data_wb_id),
    .ctrl_opcode_o (ctrl_opcode_id_ex),
    .ctrl_funct7_o (ctrl_funct7_id_ex),
    .ctrl_funct3_o (ctrl_funct3_id_ex),
    .rs1_data_o (rs1_data_id_ex),
    .rs2_data_o (rs2_data_id_ex),
    .imm_se_o (imm_se_id_ex),
    .rd_o (rd_id_ex),
    .ctrl_op_o (ctrl_op_dc_ex),
    .ctrl_ld_o (ctrl_ld_dc_ex),
    .ctrl_st_o (ctrl_st_dc_ex),
    .ctrl_jm_o (ctrl_jm_dc_ex),
    .ctrl_br_o (ctrl_br_dc_ex),
    .ctrl_reg_write_o (ctrl_reg_write_dc_ex),
    .ctrl_reg_write_i (ctrl_reg_write_wb_dc),
    .rd_ex_i (rd_ex_dc),
    .rd_mem_i (rd_mem_dc),
    .stall_proc_o (stall_proc_dc_if)

);


//-----------------------------
// DUT
//-----------------------------

//***clk_gen***
// A single clock source is used in this design.
    initial clk = 1;
    always #CLK_HALF_PERIOD clk = !clk;

    //***task automatic reset_dut***
    task automatic reset_dut;
        begin
            $display("*** Toggle reset.");
            reset_n <= 1'b0;
            #CLK_PERIOD;
            reset_n <= 1'b1;
            #CLK_PERIOD;
            $display("Done");
        end
    endtask


//***task automatic init_sim***
    task automatic init_sim;
        begin
            $display("*** init_sim");
            /* tb_data_rs1_i<='{default:0}; */
            /* tb_data_rs2_i<='{default:0}; */
            pc_i <= '{default:0};
            rd_i <= '{default:0};
            ctrl_op_i <= '{default:1};
            ctrl_ld_i <= '{default:0};
            ctrl_st_i <= '{default:0};
            ctrl_jm_i<= '{default:0};
            ctrl_br_i <= '{default:0};
            ctrl_reg_write_i <= '{default:0};
            rs1_data_i <= '{default:0};
            imm_se_i <= '{default:0};
            rs2_data_i <= '{default:0};
            opcode_i<='{default:0};
            funct7_i <= '{default:0};
            funct3_i <= '{default:0};
            reset_n <= '{default:0};
            clk <= '{default:1};
            $display("Done");
        end
    endtask

//***task automatic init_dump***
//This task dumps the ALL signals of ALL levels of instance dut_example into the test.vcd file
//If you want a subset to modify the parameters of $dumpvars
    task automatic init_dump;
        begin
            $display("*** init_dump");
            $dumpfile("dump_file.vcd");
            $dumpvars(0, stage_alu_inst);
        end
    endtask

    task automatic tick();
        begin
            //$display("*** tick");
            #CLK_PERIOD;
        end
    endtask


    task automatic check_out;
        input int test;
        input int status;
        begin
            if (status) begin
                `START_RED_PRINT
                        $display("TEST %d FAILED.",test);
                `END_COLOR_PRINT
            end else begin
                `START_GREEN_PRINT
                        $display("TEST %d PASSED.",test);
                `END_COLOR_PRINT
            end
        end
    endtask

//***task automatic test_sim***
    task automatic test_sim;
        begin
            int tmp;
            $display("*** test_sim");
            test_sim_3(tmp);
            check_out(1,tmp);
            /* test_sim_2(tmp); */
            /* check_out(1,tmp); */
            /* test_sim_3(tmp); */
            /* check_out(1,tmp); */
        end
    endtask

// Testing mult
    task automatic test_sim_1;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mult_wrong";
            tmp = 0;
            opcode_i <= OPCODE_OP;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_MUL;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                rs1_data_i <= src1;
                rs2_data_i <= src2;
                tick();
                tick();
                tick();
                tick();
                tick();
                correct_result = src1*src2;
                if (alu_result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h * %h = %h out: %h",src1,src2,correct_result,alu_result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

// test incorrect opcode, functs for mult
    task automatic test_sim_2;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mults";
            tmp = 0;
            src1 = $urandom();
            src2 = $urandom();
            rs1_data_i <= src1;
            rs2_data_i <= src2;
            // wrong opcode
            opcode_i <= OPCODE_IM;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_MUL;
            tick(); tick(); tick(); tick(); tick();
            // wrong funct7
            opcode_i <= OPCODE_OP;
            funct7_i <= F7_SUB;
            funct3_i <= F3_MUL;
            tick(); tick(); tick(); tick(); tick();
            // wrong funct3
            opcode_i <= OPCODE_OP;
            funct7_i <= F7_MULDIV;
            funct3_i <= 3'b111;
            tick(); tick(); tick(); tick(); tick();
        end
    endtask

// Testing add
    task automatic test_sim_3;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_add";
            tmp = 0;
            opcode_i <= OPCODE_OP;
            funct7_i <= F7_ADD;
            funct3_i <= F3_ADD;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                rs1_data_i <= src1;
                rs2_data_i <= src2;
                #CLK_PERIOD;
                correct_result = src1+src2;
                if (alu_result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h + %h = %h out: %h",src1,src2,correct_result,alu_result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

    /* task automatic test_sim_4; */
    /*     output int tmp; */
    /*     begin */
    /*         int src1,src2,correct_result; */
    /*         tb_test_name = "test_sim_mults"; */
    /*         tmp = 0; */
    /*         opcode_i <= OPCODE_OP; */
    /*         funct7_i <= F7_MULDIV; */
    /*         funct3_i <= F3_MUL; */
    /*         src1 = 32'd9; */
    /*         src2 = 32'd10; */
    /*         op1_data_i <= src1; */
    /*         op2_data_i <= src2; */
    /*         tick(); */
    /*         src1 = 32'd8; */
    /*         src2 = 32'd11; */
    /*         op1_data_i <= src1; */
    /*         op2_data_i <= src2; */
    /*         tick(); */
    /*         src1 = 32'd7; */
    /*         src2 = 32'd10; */
    /*         op1_data_i <= src1; */
    /*         op2_data_i <= src2; */
    /*         tick(); */
    /*         src1 = 32'd7; */
    /*         src2 = 32'd10; */
    /*         op1_data_i <= src1; */
    /*         op2_data_i <= src2; */
    /*         funct3_i <= 3'b111; */
    /*         tick(); */
    /*         src1 = 32'd6; */
    /*         src2 = 32'd11; */
    /*         op1_data_i <= src1; */
    /*         op2_data_i <= src2; */
    /*         tick(); */
    /*         tick(); */
    /*         tick(); */
    /*         tick(); */
    /*         tick(); */
    /*     end */
    /* endtask */

    initial begin
        init_sim();
        init_dump();
        reset_dut();
        test_sim();
        $finish;
    end


endmodule

