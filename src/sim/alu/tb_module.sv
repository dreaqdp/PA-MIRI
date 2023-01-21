
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


    logic  [OPCODE_SIZE-1:0] opcode_i;
    logic  [FUNCT7_SIZE-1:0] funct7_i;
    logic  [FUNCT3_SIZE-1:0] funct3_i;
    logic  [WD_SIZE-1:0] op1_data_i;
    logic  [WD_SIZE-1:0] op2_data_i;
    logic  [IMM_I_SIZE-1:0] imm_i;

    logic zero_o;
    logic  [WD_SIZE-1:0] result_o;

reg[64*8:0] tb_test_name;

//-----------------------------
// Module
//-----------------------------
alu #() alu_inst (
    .clk (clk),
    .reset_n (1'b0),
    .opcode_i (opcode_i),
    .funct7_i (funct7_i),
    .funct3_i (funct3_i),
    .op1_data_i (op1_data_i),
    .op2_data_i (op2_data_i),
    .imm_i (imm_i),
    .zero_o (zero_i),
    .result_o (result_q)
);


//-----------------------------
// DUT
//-----------------------------

//***task automatic init_sim***
    task automatic init_sim;
        begin
            $display("*** init_sim");
            /* tb_data_rs1_i<='{default:0}; */
            /* tb_data_rs2_i<='{default:0}; */
            opcode_i<='{default:0};
            imm_i <= '{default:0};
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
            $dumpvars(0,alu_inst);
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
            test_sim_1(tmp);
            check_out(1,tmp);
            test_sim_2(tmp);
            check_out(2,tmp);
            test_sim_3(tmp);
            check_out(3,tmp);
        end
    endtask

// Testing add
    task automatic test_sim_1;
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
                op1_data_i <= src1;
                op2_data_i <= src2;
                #CLK_PERIOD;
                correct_result = src1+src2;
                if (result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h + %h = %h out: %h",src1,src2,correct_result,result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

// Testing sub
    task automatic test_sim_2;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_sub";
            tmp = 0;
            opcode_i <= OPCODE_OP;
            funct7_i <= F7_SUB;
            funct3_i <= F3_SUB;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                op1_data_i <= src1;
                op2_data_i <= src2;
                #CLK_PERIOD;
                correct_result = src1-src2;
                if (result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h - %h = %h out: %h",src1,src2,correct_result,result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

// Testing addi
    task automatic test_sim_3;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_sub";
            tmp = 0;
            opcode_i <= OPCODE_IM;
            funct7_i <= F7_ADD;
            funct3_i <= F3_ADD;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                op1_data_i <= src1;
                imm_i <= src2[IMM_I_SIZE-1:0];
                #CLK_PERIOD;
                correct_result = src1+ {{20{imm_i[11]}}, imm_i};
                if (result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h - %h = %h out: %h",src1,{{20{imm_i[11]}}, imm_i},correct_result,result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask
    
    initial begin
        init_dump();
        test_sim();
        $finish;
    end


endmodule

