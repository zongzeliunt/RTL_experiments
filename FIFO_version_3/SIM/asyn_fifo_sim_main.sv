
`timescale 1 ns / 1 ps
longint unsigned ns_counter;
longint unsigned clock_counter;
module asyn_fifo_sim_main #(


    parameter integer DATA_BITS = 11, //same as C_AXI_Full_data_OPT_MEM_ADDR_BITS
    parameter integer FIFO_LENGTH 	= 16, 



    parameter TB_RESET_VALUE = 0

);

    //wire


    //reg

    reg reset;
    reg clk = 1'b0;
   
    
    //声明一个 rtl_interface 类型的interface对象。这个对象的member signal都分配内存了，可以直接用rtl_interface.signal来看各个signal的值
    asyn_fifo_interface rtl_interface (
        .clk            (clk),
        .reset          (reset)
    );


    asyn_fifo #(
        .DATA_BITS (DATA_BITS),
        .FIFO_LENGTH (FIFO_LENGTH)
    ) addr_fifo (
        .rtl_interface(rtl_interface.rtl)
    );
    
    asyn_fifo_driver_class #(
    ) asyn_fifo_driver = new(
        rtl_interface.tb
    );




initial begin
    int i, j;
    bit [DATA_BITS - 1 : 0] read_data;


    @(posedge clk);
    @(posedge clk);
    while (reset == TB_RESET_VALUE) begin
        @(posedge clk);
    end

    @(posedge clk);
    @(posedge clk);

    for (i = 0; i < 10; i ++) begin
        asyn_fifo_driver.write_data(i);
    end
   
    for (i = 0; i < 10; i ++) begin
        asyn_fifo_driver.read_data(read_data);
        $display ("read data: %x, expect: %x", read_data, i);
    end
 
    @(posedge clk);
    
    for (i = 0; i < 10; i ++) begin
        asyn_fifo_driver.write_data(i + 5);
    end
    
    for (i = 0; i < 10; i ++) begin
        asyn_fifo_driver.read_data(read_data);
        $display ("read data: %x, expect: %x", read_data, i + 5);
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

//waveform
//{{{
initial begin
    $vcdplusfile("waveforms.vpd");
    $vcdpluson();
    $vcdplusmemon();
end
//}}}

endmodule
