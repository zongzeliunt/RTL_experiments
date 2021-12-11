
`ifndef ASYN_FIFO_MASTER_SEQ_LIB_SV
`define ASYN_FIFO_MASTER_SEQ_LIB_SV

class asyn_fifo_master_seq extends asyn_fifo_master_base_seq;
    asyn_fifo_master_write_seq  m_wr_seq;
    asyn_fifo_master_read_seq   m_rd_seq;
    int unsigned  m_inc_id    = 0;


    `uvm_object_utils(asyn_fifo_master_seq)

    function new(string name="asyn_fifo_master_seq");
        super.new(name);
    endfunction


    virtual task sent_write_trx();
        m_inc_id    = 0;
        
        m_wr_seq = new (
            .name       ("asyn_fifo_write_data"),
            .input_data (10'hcd)

        );


        m_inc_id   += 1;
        start_item(m_wr_seq);
        finish_item(m_wr_seq);
        
        #100;

        m_rd_seq = new (
            .name       ("asyn_fifo_read_data")

        );

        m_inc_id   += 1;
        start_item(m_rd_seq);
        finish_item(m_rd_seq);

    endtask: sent_write_trx


    virtual task body();
        `uvm_info(get_type_name(), "ARES Starting...", UVM_MEDIUM)
        sent_write_trx();
        #1000;
        //sent_read_trx();
    endtask

endclass : asyn_fifo_master_seq

`endif // UNION_CTRL_ASYN_FIFO_MASTER_SEQ_LIB_SV

