package PARAMS_pkg;
    parameter INSTR_SIZE = 32;
    parameter ADDR_SIZE = 32;
    parameter WD_SIZE = 32;

    parameter INSTR_REG_SIZE = 5;
    parameter OPCODE_SIZE = 7;
    parameter FUNCT3_SIZE = 3;
    parameter FUNCT7_SIZE = 7;
    parameter IMM_I_SIZE = 12;

    parameter OPCODE_OP = 7'b0110011; // arith instr
    parameter OPCODE_IM = 7'b0010011;
    parameter OPCODE_LD = 7'b0000011;
    parameter OPCODE_ST = 7'b0100011;
    parameter OPCODE_BR = 7'b1100011;
    parameter OPCODE_JM = 7'b1101111;
    
    // funct7 values
    parameter F7_ADD = 7'b0;
    parameter F7_SUB = 7'b0100000;
    parameter F7_MULDIV = 7'b0000001;

    // funct3 values
    parameter F3_ADD = 3'b0;
    parameter F3_SUB = 3'b0;

    parameter F3_MUL = 3'b0;
    parameter F3_MULH = 3'b001;
    parameter F3_MULHSU = 3'b010;
    parameter F3_MULHU = 3'b011;
    parameter F3_DIV = 3'b100;
    parameter F3_DIVU = 3'b101;
    parameter F3_REM = 3'b110;
    parameter F3_REMU = 3'b111;

    parameter F3_LDB = 3'b0;
    parameter F3_LDW = 3'b010;
    parameter F3_STB = 3'b0;
    parameter F3_STW = 3'b010;

    parameter F3_BEQ = 3'b0;
    parameter F3_BNE = 3'b001;
    parameter F3_BLT = 3'b100;
    parameter F3_BGE = 3'b101;
    parameter F3_BLTU = 3'b110;
    parameter F3_BGEU = 3'b111;

    parameter MEM_ACCESS_BYTE = 3'b000;
    parameter MEM_ACCESS_HALF = 3'b001;
    parameter MEM_ACCESS_WORD = 3'b010;
    
    parameter RD = 1'b0;
    parameter WR = 1'b1;

    parameter BOOT_ADDR = 32'h00001000;
    parameter EXCEP_ADDR = 32'h00002000;

    /* parameter NOP_INSTR = 32'h00000000; */
    parameter NOP_INSTR = { {{WD_SIZE-7}{1'b0}}, OPCODE_IM}; // addi x0, x0, 0

    // cache
    parameter CACHE_LINE_SIZE = 64; // bytes
    parameter CACHE_NUM_LINES = 4;
endpackage

