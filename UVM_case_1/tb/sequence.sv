
//counter sequence definition is here
class count_seq extends uvm_sequence#(counter_trans);
//{{{ 
    `uvm_object_utils(count_seq)
 
    virtual Bus_if Bus_if1;
    
    rand int num; 	// Config total number of items to be sent
    
    function new(string name="");
        super.new(name)     ;
        //void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
        /*
        if(!uvm_config_db#(virtual Bus_if)::get(this,"*     ","Bus_if1",Bus_if1))   
        begin
            `uvm_error("","uvm_config_db::get failed in driver");
        end
        */
    endfunction
 
    task body     ();
        $display ("ARES num: %d", num);
        for (int i = 0; i < num; i ++) begin
            counter_trans  req = counter_trans::type_id::create("req");
            //start_item( req.randomize() );
            //ARES
            start_item(req);
            req.randomize();
            `uvm_info("SEQ", $sformatf("ARES. Generate new item"), UVM_HIGH)
            finish_item(req); // this function used to send transaction items to driver
        end
    endtask
endclass
//}}}
