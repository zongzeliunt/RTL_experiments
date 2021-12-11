
longint unsigned ns_counter;
longint unsigned clock_counter;
module asyn_fifo_sim_main #(


    parameter integer DATA_BITS = 10, //same as C_AXI_Full_data_OPT_MEM_ADDR_BITS
    parameter integer FIFO_LENGTH 	= 16, 



    parameter TB_RESET_VALUE = 0

);
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import asyn_fifo_pkg::*;
    import asyn_fifo_seq_lib_pkg::*;
    import asyn_fifo_test_case_pkg::*;
    `include "asyn_fifo_virtual_sequencer.sv"
    `include "asyn_fifo_vir_seq_lib.sv"
    `include "asyn_fifo_tb.sv"
    `include "asyn_fifo_test.sv" //test_lib.sv
    //wire


    //reg

    reg w_reset;
    reg r_reset;
    reg w_clk = 1'b0;
    reg r_clk = 1'b0;
   
    
    //声明一个 rtl_interface 类型的interface对象。这个对象的member signal都分配内存了，可以直接用rtl_interface.signal来看各个signal的值
    asyn_fifo_interface rtl_interface (
        .w_clk            (w_clk),
        .w_reset          (w_reset),
        .r_clk            (r_clk),
        .r_reset          (r_reset)
    );


    asyn_fifo #(
        .DATA_BITS (DATA_BITS),
        .FIFO_LENGTH (FIFO_LENGTH)
    ) asyn_fifo_design (
        .rtl_interface(rtl_interface.rtl)
    );
   










//reset
//{{{
initial begin
    w_reset = TB_RESET_VALUE;
    r_reset = TB_RESET_VALUE;
    #20;
    w_reset = ~TB_RESET_VALUE;
    #1;
    r_reset = ~TB_RESET_VALUE;
    

    //messager.dump_message("sim start");
    $display ("sim start");
    #500000;
    //#1000;
    //messager.dump_message("sim end");
    $display ("sim end");
    $finish;
end
//}}}

//w_clk
//{{{
initial begin
    w_clk = 0;
    clock_counter = 0;
    ns_counter = 0;
    forever begin
        #5 w_clk ^= 1;
        ns_counter += 5;
        #5 w_clk ^= 1;
        ns_counter += 5;
        clock_counter += 1;
    end
end
//}}}

//r_clk
//{{{
initial begin
    r_clk = 0;
    forever begin
        #7 r_clk ^= 1;
        #7 r_clk ^= 1;
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

initial begin
    $fsdbDumpfile("waveforms.fsdb");
    $fsdbDumpMDA;
    $fsdbDumpvars(0);
end
//}}}

initial begin
    uvm_config_db#(virtual interface asyn_fifo_interface)::set(uvm_root::get(), "*", "rtl_vif", rtl_interface);
    run_test("asyn_fifo_test");
end

endmodule
