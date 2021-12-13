class monitor extends uvm_monitor;
//{{{ 
    `uvm_component_utils(monitor)
 
    uvm_analysis_port # (counter_trans) ap_objseq;
    virtual Bus_if Bus_if1;
 
    function new(string name, uvm_component parent=null);
        //super.new(name, null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
        ap_objseq = new(.name("ap_objseq"),.parent(this));
    endfunction
 
    task run_phase(       uvm_phase phase);
        forever begin
        //sequence_gen req;
        counter_trans req;
        req=counter_trans::type_id::create("req",this);
        @ Bus_if1.clk;
        req.reset = Bus_if1.reset;
        req.data = Bus_if1.data;
        ap_objseq.write(req);
    end
    endtask
endclass
//}}}
