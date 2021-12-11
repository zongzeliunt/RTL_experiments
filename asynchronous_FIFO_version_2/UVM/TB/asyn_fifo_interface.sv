`timescale 1 ns / 1 ps

interface asyn_fifo_interface #(
    parameter integer DATA_BITS	= 10

) (

	input w_clk,
	input w_reset,
	input r_clk,
	input r_reset
    /*
    这是一种声明方式，可以用，但是我现在不想这么用。当然在SV code里的任何地方都可以用include svh的方式替换当前位置的代码。

    `ifdef VCS_SIM
        `include "../TB/asyn_fifo_interface_IO_define.svh"
    `else 
        `include "asyn_fifo_interface_IO_define.svh"
    `endif
    */
);
    logic [DATA_BITS - 1 : 0] input_data;
    logic [DATA_BITS - 1 : 0] output_data;
    logic read;
    logic write;
    logic empty;
    logic full;

    modport rtl 
    (
        input w_clk,
        input w_reset,
        input r_clk,
        input r_reset,
        input input_data,
        output output_data,
        input read,
        input write,
        output empty,
        output full
    );


    modport tb
    (
        input w_clk,
        input w_reset,
        input r_clk,
        input r_reset,
        output input_data,
        input output_data,
        output read,
        output write,
        input empty,
        input full
    );


//asserts
/*
always @(negedge w_clk)
begin



end
*/





endinterface
