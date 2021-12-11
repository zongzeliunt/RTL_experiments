
`ifndef UNION_CTRL_VIR_SEQ_LIB_SV
`define UNION_CTRL_VIR_SEQ_LIB_SV


class asyn_fifo_vseq extends uvm_sequence;

    function new (string name="asyn_fifo_vseq", uvm_sequencer_base sequencer = null,uvm_sequence parent_seq = null);
        super.new(name);//,sequencer,parent_seq);
    endfunction :new;

    `uvm_object_utils_begin(asyn_fifo_vseq)
    `uvm_object_utils_end
    `uvm_declare_p_sequencer(asyn_fifo_virtual_sequencer)
    
    asyn_fifo_master_seq master_seq;


   
    virtual task body();
        //uvm_test_done.raise_objection(this);
        `uvm_info("vesq",$psprintf("Doning asyn_fifo_vseq"),UVM_LOW)
        fork 
            //`uvm_do_on(master_seq, p_sequencer.asyn_fifo_sequencer)
            `uvm_do(master_seq, p_sequencer.asyn_fifo_sequencer)
        join
        #1000000;
        //uvm_test_done.drop_objection(this);
     endtask :body 
endclass :asyn_fifo_vseq
`endif    
