// testsuite sets....

`ifndef ASYN_FIFO_VIRTUAL_SEQUENCER_SV
`define ASYN_FIFO_VIRTUAL_SEQUENCER_SV


class asyn_fifo_virtual_sequencer extends uvm_sequencer;

    asyn_fifo_pkg::asyn_fifo_master_sequencer asyn_fifo_sequencer;

    function new (string name ,uvm_component parent);
        super.new(name,parent);
    endfunction :new;

    `uvm_component_utils(asyn_fifo_virtual_sequencer)
endclass :asyn_fifo_virtual_sequencer
`endif    
