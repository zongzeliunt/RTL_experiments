`include "uvm_macros.svh"

longint unsigned ns_counter;
longint unsigned clock_counter;

module top();
//generate the clock
    reg    clk = 0;
//interface instance
    Bus_if Bus_if1(clk);
 
// Dut instance
    Counter Counter1(
            .clk(clk),
            .reset(Bus_if1.reset),
            .data(Bus_if1.data)
    );
 

//reset
//{{{
/*
initial begin
    reset = TB_RESET_VALUE;
    #20;
    reset = ~TB_RESET_VALUE;

    //messager.dump_message("sim start");
    $display ("sim start");
    #1000;
    //messager.dump_message("sim end");
    $display ("sim end");
    $finish;
end
*/
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

initial begin
    $fsdbDumpfile("waveforms.fsdb");
    $fsdbDumpMDA;
    $fsdbDumpvars(0);
end
//}}}

//set virtual interface
initial begin
    uvm_config_db#(virtual Bus_if)::set(null,"*","Bus_if1",Bus_if1);
    run_test("test_count");
end


endmodule
