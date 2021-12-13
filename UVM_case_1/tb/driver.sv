
class driver extends uvm_driver # (counter_trans);
//{{{
    `uvm_component_utils(driver)
 
    virtual Bus_if Bus_if1;
 
    function new(string name,uvm_component parent=null);
        //super.new(name,null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // req = sequence_gen::type_id::create("req",this);
        void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
        if(!uvm_config_db#(virtual Bus_if)::get(this,"*     ","Bus_if1",Bus_if1))   
        begin
            `uvm_error("","uvm_config_db::get failed in driver");
        end
    endfunction
 
    task run_phase(uvm_phase phase);
 
        counter_trans req;
 
        fork
            forever begin
                seq_item_port.get_next_item(req);
                // gets the sequence item from the sequence_gen
                if(Bus_if1.clk<=req.clk)
                    Bus_if1.reset <=req.reset;
                    Bus_if1.data <= req.data;
                    seq_item_port.item_done();
                end
        join_none
    endtask
endclass
//}}}
