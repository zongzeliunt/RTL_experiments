`ifndef ASYN_FIFO_BASED_SEQ_LIB_SV
`define ASYN_FIFO_BASED_SEQ_LIB_SV

//------------------------------------------------------------------------------
// SEQUENCE: base_seq
//------------------------------------------------------------------------------
class asyn_fifo_base_seq extends uvm_sequence #(asyn_fifo_transfer);
//{{{
    //axi_based_seq_lib.sv
    function new(string name="asyn_fifo_base_seq");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(asyn_fifo_base_seq)
    `uvm_object_utils_end

endclass : asyn_fifo_base_seq
//}}}

class asyn_fifo_master_base_seq extends asyn_fifo_base_seq;
//{{{
    //~/TM_work/pulpino_test/union_ctrl/uvc/sequence_libs/axi_master_based_seq_lib.sv
    //编译时说starting_phase是什么不知道
    function new(string name="asyn_fifo_master_base_seq");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(asyn_fifo_master_base_seq)
    `uvm_object_utils_end

    //`uvm_declare_p_sequencer(asyn_fifo_master_sequencer)

// Use a base sequence to raise/drop objections if this is a default sequence
    /*
    virtual task pre_body();
        if (starting_phase != null)
            starting_phase.raise_objection(this, {"Running sequence '",
                                              get_full_name(), "'"});
    endtask

    virtual task post_body();
        if (starting_phase != null)
            starting_phase.drop_objection(this, {"Completed sequence '",
                                             get_full_name(), "'"});
    endtask
    */
endclass : asyn_fifo_master_base_seq
//}}}

class asyn_fifo_master_write_seq extends asyn_fifo_transfer;
//{{{
//~/TM_work/pulpino_test/union_ctrl/uvc/sequence_libs/axi_master_write_seq_lib.sv
    asyn_fifo_transfer m_trx;

    function new(
                //new 这里必须有default值
                string name            = "asyn_fifo_master_write_seq",
                int input_data          = 0 
                );

        super.new(name);
        $cast(m_trx, super);
        
        m_trx.rw            = WRITE;
        m_trx.input_data    = input_data;
    endfunction

    `uvm_object_utils(asyn_fifo_master_write_seq)

endclass : asyn_fifo_master_write_seq
//}}}

class asyn_fifo_master_read_seq extends asyn_fifo_transfer;
//{{{
//~/TM_work/pulpino_test/union_ctrl/uvc/sequence_libs/axi_master_write_seq_lib.sv
    asyn_fifo_transfer m_trx;

    function new(
                //new 这里必须有default值
                string name            = "asyn_fifo_master_read_seq"
                );

        super.new(name);
        $cast(m_trx, super);
        
        m_trx.rw            = READ;
    endfunction

    `uvm_object_utils(asyn_fifo_master_read_seq)

endclass : asyn_fifo_master_read_seq
//}}}

`endif // asyn_fifo_master_read_seq







