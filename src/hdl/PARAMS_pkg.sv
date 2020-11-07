package PARAMS_pkg;
    parameter INSTR_SIZE = 32;
    parameter ADDR_SIZE = 32;
    parameter WD_SIZE = 32;

    parameter INSTR_REG_BITS = 5;
    parameter OPCODE_BITS = 7;
    parameter FUNCT3_BITS = 3;
    parameter FUNCT7_BITS = 7;

    parameter OPCODE_OP = 7'b0; // arith instr
    parameter OPCODE_LD = 7'd1;
    parameter OPCODE_ST = 7'd2;
    parameter OPCODE_BR = 7'd3;
    parameter OPCODE_JM = 7'd4;
    
    // funct7 values
    parameter ADDS = 7'b0;
    parameter SUBS = 7'b0100000;
    parameter MULDIV = 7'b1000000;

    // funct3 values
    parameter ADD = 3'b0;
    parameter SUB = 3'b0;
    parameter MUL = 3'b0;
    parameter LDB = 3'b0;
    parameter LDW = 3'b1;
    parameter STB = 3'b0;
    parameter STW = 3'b1;
    parameter BEQ = 3'b0;
    
    parameter RD = 1'b0;
    parameter WR = 1'b1;

    parameter BOOT_ADDR = 32'h00001000;
    parameter EXCEP_ADDR = 32'h00002000;

    parameter NOP_INSTR = 32'h00000000;
endpackage

