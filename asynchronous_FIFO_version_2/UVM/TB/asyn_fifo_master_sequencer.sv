`ifndef ASYN_FIFO_MASTER_SEQUENCER_SV
`define ASYN_FIFO_MASTER_SEQUENCER_SV

class asyn_fifo_master_sequencer extends uvm_sequencer #(asyn_fifo_transfer);

    `uvm_component_utils_begin(asyn_fifo_master_sequencer)
    `uvm_component_utils_end

    // Constructor - required syntax for UVM automation and utilities
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

endclass : asyn_fifo_master_sequencer

`endif // asyn_fifo_master_sequencer
