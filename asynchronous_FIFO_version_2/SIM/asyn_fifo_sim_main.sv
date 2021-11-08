
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

    reg [DATA_BITS - 1 : 0]data_buffer;
    reg [DATA_BITS - 1 : 0]data_expect;

    reg reset;
    reg clk = 1'b0;
    
    asyn_fifo_interface rtl_interface (
        .clk            (clk),
        .reset          (reset)
    );

    //assign
    assign rtl_interface.read = (rtl_interface.output_data == data_expect && rtl_interface.empty != 1) ? 1 : 0;


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
    
    @(posedge clk);
    
    for (i = 0; i < 10; i ++) begin
        asyn_fifo_driver.write_data(i + 5);
    end


end


always@(posedge clk) begin
    if (rtl_interface.empty != 1) begin
        $display ("read_data: %d", rtl_interface.output_data);
    end
end

always@(posedge clk) begin
    data_buffer <= rtl_interface.input_data;
end

always@(posedge clk) begin
    data_expect <= data_buffer;
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
