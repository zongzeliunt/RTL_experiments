`timescale 1 ns / 1 ps

interface asyn_fifo_interface #(
    parameter integer DATA_BITS	= 10

) (

	input clk,
	input reset
    /*
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
        input clk,
        input reset,
        input input_data,
        output output_data,
        input read,
        input write,
        output empty,
        output full
    );


    modport tb
    (
        input clk,
        input reset,
        output input_data,
        input output_data,
        output read,
        output write,
        input empty,
        input full
    );












endinterface
