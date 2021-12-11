class asyn_fifo_test extends uvm_test;

    `uvm_component_utils(asyn_fifo_test)

    asyn_fifo_tb m_asyn_fifo_tb;
    uvm_table_printer m_printer;

    function new(string name = "asyn_fifo_test", uvm_component parent);
        super.new(name,parent);
        m_printer = new();
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db #(uvm_object_wrapper)::set(this, "m_asyn_fifo_tb.virtual_sequencer.run_phase", "default_sequence", asyn_fifo_vseq::type_id::get());

        m_asyn_fifo_tb = asyn_fifo_tb::type_id::create("m_asyn_fifo_tb", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
    endfunction : connect_phase

    task run_phase(uvm_phase phase);
        //m_printer.knobs.depth = 5;
        this.print(m_printer);
        //phase.phase_done.set_drain_time(this, 1000);
    endtask : run_phase

endclass : asyn_fifo_test
