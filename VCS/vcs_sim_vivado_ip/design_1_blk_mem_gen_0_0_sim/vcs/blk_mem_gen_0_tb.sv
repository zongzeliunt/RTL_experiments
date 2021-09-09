
`timescale 1 ns / 1 ps
longint unsigned ns_counter;
longint unsigned clock_counter;
module blk_mem_genn_0_tb #(


    parameter integer C_AXI_Full_data_OPT_MEM_ADDR_BITS = 10,
    parameter integer C_AXI_Full_data_DATA_WIDTH	= 64,
    parameter integer C_AXI_Full_data_MEM_LENGTH	= 8192,



    parameter TB_RESET_VALUE = 0

);

    //wire
    wire [C_AXI_Full_data_DATA_WIDTH - 1 : 0] douta; 
    

    //reg
    reg [C_AXI_Full_data_OPT_MEM_ADDR_BITS - 1 : 0] addra; 
    reg [C_AXI_Full_data_DATA_WIDTH - 1 : 0] dina; 
    reg ena;
    reg wea;



    reg reset;
    reg clk = 1'b0;

    //assign




    blk_mem_gen_6_wrapper #(
    ) BLK_MEM (
        .ADDRA  (addra),
        .CLKA   (clk),
        .DINA   (dina),
        .DOUTA   (douta),
        .ENA    (ena),
        .WEA    (wea)
        

 
    );

task write_data (bit[C_AXI_Full_data_DATA_WIDTH - 1 : 0] data, bit[C_AXI_Full_data_OPT_MEM_ADDR_BITS - 1 : 0] waddr);
begin
    dina <= data;
    addra <= waddr; 
    wea <= 1;
    @(posedge clk);
    dina <= 0;
    addra <= 0; 
    wea <= 0;
end
endtask

task read_data (bit[C_AXI_Full_data_OPT_MEM_ADDR_BITS - 1 : 0] raddr);
begin
    addra <= raddr; 
    @(posedge clk);
    addra <= 0; 
end
endtask

initial begin
    int i, j;
    ena = 1;
    @(posedge clk);
    @(posedge clk);
    while (reset == TB_RESET_VALUE) begin
        @(posedge clk);
    end

    @(posedge clk);
    @(posedge clk);

    for (i = 0; i < 5; i ++) begin
        write_data(i + 5, i);
    end

    @(posedge clk);
    @(posedge clk);

    for (i = 0; i < 5; i ++) begin
        read_data(i);
    end











end



//reset
//{{{
initial begin
    reset = TB_RESET_VALUE;
    #20;
    reset = ~TB_RESET_VALUE;
    //messager.dump_message("sim start");
    //#500000;
    #1000;
    //messager.dump_message("sim end");
    $finish;
end
//}}}

//clk
//{{{
initial begin
    clk = 0;
    clock_counter = 0;
    ns_counter = 0;
    forever begin
        #5 clk ^= 1;
        ns_counter += 5;
        #5 clk ^= 1;
        ns_counter += 5;
        clock_counter += 1;
    end
end
//}}}

/*
//waveform
//{{{
initial begin
    $vcdplusfile("waveforms.vpd");
    $vcdpluson();
    $vcdplusmemon();
end
//}}}
*/

endmodule
