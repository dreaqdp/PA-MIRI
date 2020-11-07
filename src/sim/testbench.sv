`timescale 1ns / 1ps

module loopback_TB #(
    parameter CORE_CLK_PERIOD = 4,
    parameter N_RESET = 10,
    parameter OP_INSTR = 4,
    parameter LD_INSTR = 4,
    parameter ST_INSTR = 4,
    parameter BR_INSTR = 0,
    parameter JM_INSTR = 0,
    parameter N_INSTR = OP_INSTR + LD_INSTR + ST_INSTR + BR_INSTR + JM_INSTR
) (
);

parameter IMEM_SIZE_BYTES = 32*4;
parameter DMEM_SIZE_BYTES = 32*4;

// clk
logic clk;

initial clk = 0;

always #(CORE_CLK_PERIOD/2) 
    clk = ~clk;

initial begin
    reset_n = 0;
end


integer i, j;

integer f_in_dmem, f_in_imem, i;
logic [IMEM_SIZE_BYTES-1:0][7:0] input_dmem;
logic [DMEM_SIZE_BYTES-1:0][7:0] input_imem;

initial begin
    /* f_in_imem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/imem.csv", "r"); */
    f_in_dmem = $fopen("/home/aquerol/Documents/miri/pa/PA-MIRI/src/sim/dmem.csv", "r");

    /* i = 0; */
    /* while (!$feof(f_in_imem)) begin */
    /*     $fscan(f_in_imem, "%b\n", input_imem[i]); */
    /*    i = i + 1; */
    /* end */

    i = 0;
    while (!$feof(f_in_dmem)) begin
        $fscan(f_in_dmem, "%b\n", input_dmem[i]);
       i = i + 1;
    end
    k = 0;
end

initial begin
    j = 0;
    for mem)
end

always@(posedge clk) begin
    if (j < N_RESET) begin
        /* $stop; */
       reset_n <= 0;
       k = k + 1;
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
