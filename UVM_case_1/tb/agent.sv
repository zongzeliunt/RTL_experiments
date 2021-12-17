
class agent extends uvm_agent;
//{{{ 
    `uvm_component_utils(agent)
    uvm_analysis_port # (counter_trans) ap_objseq;
 
    // virtual Bus_if Bus_if1;
 
    counter_sequencer        sqr;
    driver       drv;
    monitor      mtr;
    //scoreboard   sb;
    //coverage     cov;
 
    function new(string name, uvm_component parent=null);
        //super.new(name,null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_objseq = new(.name("ap_objseq"),.parent(this));
        drv = driver::type_id::create("drv",this);
        mtr = monitor::type_id::create("mtr",this);
        //sb = scoreboard::type_id::create("sb",this);
        //cov = coverage::type_id::create("cov",this);
        sqr = counter_sequencer::type_id::create("sqr",this);
 
        /*if(!uvm_config_db#(virtual Bus_if)::get(this,"","Bus_if1",Bus_if1))
        begin
          `uvm_fatal("In agent","virtual interface not got successful");
        end
        */
        /*    
        uvm_config_db # (virtual Bus_if)::set(this,"monitor","Bus_if1",Bus_if1);
        uvm_config_db # (virtual Bus_if)::set(this,"driver","Bus_if1",Bus_if1);
        uvm_config_db # (virtual Bus_if)::set(this,"monitor","Bus_if1",Bus_if1);
        uvm_config_db # (virtual Bus_if)::set(this,"coverage","Bus_if1",Bus_if1);
        */  
    endfunction
 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        mtr.ap_objseq.connect(ap_objseq);
    endfunction
endclass
//}}}
