`timescale 1ns / 1ps

module testbench #(
    parameter CORE_CLK_PERIOD = 4,
    parameter N_RESET = 10,
    parameter OP_INSTR = 4,
    parameter LD_INSTR = 5,
    parameter ST_INSTR = 4,
    parameter BR_INSTR = 0,
    parameter JM_INSTR = 0,
    parameter N_INSTR = OP_INSTR + LD_INSTR + ST_INSTR + BR_INSTR + JM_INSTR
) (
);

parameter IMEM_SIZE_BYTES = N_INSTR*4;
parameter DMEM_SIZE_BYTES = 8*4;

// clk
logic clk;
logic reset_n;

initial clk = 0;

always #(CORE_CLK_PERIOD/2) 
    clk = ~clk;

initial begin
    reset_n = 0;
end


integer i, j;

integer f_in_dmem, f_in_imem;
logic [IMEM_SIZE_BYTES-1:0][7:0] input_imem;
logic [DMEM_SIZE_BYTES-1:0][7:0] input_dmem;


initial begin
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem_8bits_reversed.csv", "r"); */
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_addi.mem", "r"); */
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_add.mem", "r"); */
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_sub.mem", "r"); */
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_load.mem", "r"); */
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_store.mem", "r"); */
    f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem/imem_branch.mem", "r");
    f_in_dmem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/dmem.csv", "r");

    i = 0;
    while (!$feof(f_in_imem)) begin
        $fscanf(f_in_imem, "%x\n", input_imem[i]);
       i = i + 1;
    end

    i = 0;
    while (!$feof(f_in_dmem)) begin

        $fscanf(f_in_dmem, "%b\n", input_dmem[i]);
       i = i + 1;
    end
    j = 0;
end


always@(posedge clk) begin
    if (j < N_RESET) begin
        /* $stop; */
       reset_n <= 0;
       j = j + 1;
    end
    else
       reset_n <= 1;
end

proc #(
    .INPUT_DMEM (DMEM_SIZE_BYTES),
    .INPUT_IMEM (IMEM_SIZE_BYTES)
) proc (
    .clk (clk),
    .reset_n (reset_n),
    .input_data_dmem (input_dmem),
    .input_data_imem (input_imem)
);

endmodule
