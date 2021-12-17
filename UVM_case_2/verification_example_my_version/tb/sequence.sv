class gen_item_seq extends uvm_sequence;
    `uvm_object_utils(gen_item_seq)
    function new(string name="gen_item_seq");
        super.new(name);
    endfunction
  
    rand int num; 	// Config total number of items to be sent
  
    constraint c1 { soft num inside {[10:50]}; }

    test_case m_test_case;


    virtual task body();
        //fork 
        //join
        for (int i = 0; i < num; i ++) begin
            `uvm_do(m_test_case)
        end
        `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
    endtask
endclass
