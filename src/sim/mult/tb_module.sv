
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


    logic  op_i;
    logic  [FUNCT7_SIZE-1:0] funct7_i;
    logic  [FUNCT3_SIZE-1:0] funct3_i;
    logic  [WD_SIZE-1:0] op1_data_i;
    logic  [WD_SIZE-1:0] op2_data_i;
    logic  [IMM_I_SIZE-1:0] imm_i;

    logic valid_result_o;
    logic  [WD_SIZE-1:0] result_o;

    reg clk, reset_n;

reg[64*8:0] tb_test_name;

//-----------------------------
// Module
//-----------------------------
multiplier #() multiplier_inst (
    .clk (clk),
    .reset_n (reset_n),
    .op_i (op_i),
    .funct7_i (funct7_i),
    .funct3_i (funct3_i),
    .op1_data_i (op1_data_i),
    .op2_data_i (op2_data_i),
    .valid_result_o (valid_result_q),
    .result_o (result_o)
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
            op_i<='{default:0};
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
            $dumpvars(0,multiplier_inst);
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
            test_sim_1(tmp);
            check_out(1,tmp);
            test_sim_4(tmp);
            check_out(1,tmp);
            /* test_sim_3(tmp); */
            /* check_out(1,tmp); */
        end
    endtask

// Testing mult alone
    task automatic test_sim_1;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mult_wrong";
            tmp = 0;
            op_i <= 1'b1;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_MUL;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                op1_data_i <= src1;
                op2_data_i <= src2;
                tick();
                tick();
                tick();
                tick();
                tick();
                correct_result = src1*src2;
                if (result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h * %h = %h out: %h",src1,src2,correct_result,result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

// Testing div alone
    task automatic test_sim_4;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mult_wrong";
            tmp = 0;
            op_i <= 1'b1;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_DIV;
            for(int i = 0; i < 100; i++) begin
                src1 = $urandom();
                src2 = $urandom();
                op1_data_i <= src1;
                op2_data_i <= src2;
                tick();
                tick();
                tick();
                tick();
                tick();
                correct_result = src1/src2;
                if (result_o != correct_result) begin
                    tmp = 1;
                    `START_RED_PRINT
                    $error("Result incorrect %h / %h = %h out: %h",src1,src2,correct_result,result_o);
                    `END_COLOR_PRINT
                end
            end
        end
    endtask
// test incorrect opcode, functs
    task automatic test_sim_2;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mults";
            tmp = 0;
            src1 = $urandom();
            src2 = $urandom();
            op1_data_i <= src1;
            op2_data_i <= src2;
            // wrong opcode
            op_i <= 1'b0;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_MUL;
            tick(); tick();
            // wrong funct7
            op_i <= 1'b1;
            funct7_i <= F7_SUB;
            funct3_i <= F3_MUL;
            tick(); tick();
            // wrong funct3
            op_i <= 1'b1;
            funct7_i <= F7_MULDIV;
            funct3_i <= 3'b111;
            tick(); tick();
        end
    endtask

// Testing multiple mults
    
    task automatic test_sim_3;
        output int tmp;
        begin
            int src1,src2,correct_result;
            tb_test_name = "test_sim_mults";
            tmp = 0;
            op_i <= 1'b1;
            funct7_i <= F7_MULDIV;
            funct3_i <= F3_MUL;
            src1 = 32'd9;
            src2 = 32'd10;
            op1_data_i <= src1;
            op2_data_i <= src2;
            tick();
            src1 = 32'd8;
            src2 = 32'd11;
            op1_data_i <= src1;
            op2_data_i <= src2;
            tick();
            src1 = 32'd7;
            src2 = 32'd10;
            op1_data_i <= src1;
            op2_data_i <= src2;
            tick();
            src1 = 32'd7;
            src2 = 32'd10;
            op1_data_i <= src1;
            op2_data_i <= src2;
            funct3_i <= 3'b111;
            tick();
            src1 = 32'd6;
            src2 = 32'd11;
            op1_data_i <= src1;
            op2_data_i <= src2;
            tick();
            tick();
            tick();
            tick();
            tick();
        end
    endtask

    initial begin
        init_sim();
        init_dump();
        reset_dut();
        test_sim();
        $finish;
    end


endmodule

