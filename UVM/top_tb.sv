

longint unsigned ns_counter;
longint unsigned clock_counter;

module top_tb;

    parameter TB_RESET_VALUE = 0;
reg             clk;
reg             rst_n;
reg     [7:0]   rxd;
reg             rx_dv;
wire    [7:0]   txd;
wire            tx_en;

dut my_dut(
    .clk(clk),
    .rst_n(rst_n),
    .rxd(rxd),
    .rx_dv(rx_dv),
    .txd(txd),
    .tx_en(tx_en)
);

initial begin
    my_driver drv;
    drv = new("drv",null);
    drv.main_phase(null);
    $finish();
end




//reset
//{{{
initial begin
    rst_n = TB_RESET_VALUE;
    #20;
    rst_n = ~TB_RESET_VALUE;
    //messager.dump_message("sim start");
    #50000;
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

initial begin
    $fsdbDumpfile("waveforms.fsdb");
    $fsdbDumpvars();
    $fsdbDumpon;
end
//}}}

endmodule
