
class test_count extends uvm_test;
//{{{
    `uvm_component_utils(test_count)
 
    count_seq  req;
    environment env;
 
    function new(string name, uvm_component parent=null);
        //super.new(name,null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = environment::type_id::create("env",this);
        req = count_seq::type_id::create("req");
        //ARES
        //req.randomize();
        req.randomize() with { num inside {[300:500]}; };

    endfunction
 
    //  task run_test(uvm_phase phase);
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        req.start(env.agt.sqr);
        #10
        phase.drop_objection(this);
    endtask
endclass
//}}}
