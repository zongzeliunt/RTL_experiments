
class asyn_fifo_uvm_driver_class
//{{{
extends uvm_driver #(
    asyn_fifo_transfer
)
;
    
    parameter DATA_BITS	= 10;
    parameter FIFO_LENGTH	= 16;
	parameter ADDR_BIT = 4;

    virtual asyn_fifo_interface.tb channel;
    
    asyn_fifo_transfer m_wr_queue[$];
    asyn_fifo_transfer m_rd_queue[$];
    int unsigned                m_num_sent;
    

    int unsigned                m_wr_indx = 0;
    int unsigned                m_wr_indx = 0;

    int unsigned                m_rd_indx = 0;

    // reserve fields
    `uvm_component_utils_begin(asyn_fifo_uvm_driver_class)
    `uvm_field_int          (m_num_sent,UVM_ALL_ON)
    `uvm_component_utils_end

    function new (string name, uvm_component parent = null);
    begin
        super.new(name,parent);
           
        `uvm_info("my_driver","new is called",UVM_LOW)
    end
    endfunction


    extern virtual function void assign_vi(virtual asyn_fifo_interface.tb tb_channel);
    extern virtual task run_phase(uvm_phase phase);

    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual protected task get_and_drive();
    extern virtual protected task reset_w_signals();
    extern virtual protected task reset_r_signals();
    extern virtual protected task w_drive_transfer(asyn_fifo_transfer w_trx);
    //extern virtual protected task r_drive_transfer(asyn_fifo_transfer r_trx);

    extern virtual task sent_write_trx();
    extern virtual task sent_read_trx();

    extern virtual protected task wait_for_reset();
    extern virtual protected task sent_w_trx_to_seq();
    //extern virtual protected task sent_r_trx_to_seq();

endclass : asyn_fifo_uvm_driver_class
//}}}


function void asyn_fifo_uvm_driver_class::assign_vi(virtual asyn_fifo_interface.tb tb_channel);
    this.channel = tb_channel;    //这句和assign_vi一样
endfunction

//UVM connect_phase
function void asyn_fifo_uvm_driver_class::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (!uvm_config_db#(virtual asyn_fifo_interface.tb)::get(this, "", "channel", this.channel)) 
    begin
        `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".channel"});
    end
    //assert(m_conf!=null);

endfunction : connect_phase

task asyn_fifo_uvm_driver_class::run_phase(uvm_phase phase);
//{{{
begin
    fork 
        get_and_drive();
        reset_w_signals();
        reset_r_signals();
        sent_write_trx();
        sent_read_trx();
    join
end
endtask : run_phase
//}}}

task asyn_fifo_uvm_driver_class::get_and_drive();
//{{{
    wait_for_reset();
    sent_w_trx_to_seq();
endtask : get_and_drive
//}}}

task asyn_fifo_uvm_driver_class::reset_w_signals();
//{{{
begin
    forever begin
        @(negedge channel.w_reset);
        `uvm_info(get_type_name(), "Reset w signals", UVM_MEDIUM)
        channel.input_data <= 0;
        channel.write       <= 0; 
    end
end
endtask : reset_w_signals
//}}}

task asyn_fifo_uvm_driver_class::reset_r_signals();
//{{{
begin
    forever begin
        @(negedge channel.r_reset);
        `uvm_info(get_type_name(), "Reset r signals", UVM_MEDIUM)
        channel.read        <= 0;
    end
end
endtask : reset_r_signals
//}}}

task asyn_fifo_uvm_driver_class::wait_for_reset();
//{{{
    @(posedge channel.w_reset)
    `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)

endtask : wait_for_reset
//}}}

task asyn_fifo_uvm_driver_class::sent_w_trx_to_seq();
//{{{
    forever begin
        @(posedge channel.w_clk);
        seq_item_port.get_next_item(req);//TODO req 不知道哪声明的
        w_drive_transfer(req);
        seq_item_port.item_done();
    end
endtask : sent_w_trx_to_seq
//}}}

//TODO 因为w 和r是用不同的clk，所以要分开，但是现在有两个问题：1。写w请求和写r请求的时机是不同的。2。 sent_w_trx_to_seq里的get_next_item是只看一眼还是pop出来不知道。假如是pop出来，发现是read，这个read请求现在不知道怎么再给推回去。
//所以在12/10这天还是用以前老方法，先不即一切代价先跑通。可以先让w clk和r clk先一致。
// Gets a transfer and drive it into the DUT
// push the trx to trx async queue
task asyn_fifo_uvm_driver_class::w_drive_transfer(asyn_fifo_transfer w_trx);
//{{{
    `uvm_info(get_type_name(), $psprintf("Driving \n%s", w_trx.sprint()), UVM_LOW)

    if (w_trx.rw == READ) begin
        m_rd_queue.push_back(w_trx);

    end else if (w_trx.rw == WRITE) begin
        m_wr_queue.push_back(w_trx);

    end else begin
      `uvm_error("NOTYPE",{"type not support"})
    end

    m_num_sent++;
    `uvm_info(get_type_name(), $psprintf("Item %0d Sent ...", m_num_sent), UVM_LOW)

endtask : w_drive_transfer
//}}}

task asyn_fifo_uvm_driver_class::sent_write_trx();
//{{{
    asyn_fifo_transfer m_trx;

    forever begin
        // if write trx has existed...
        repeat(m_wr_queue.size()==0) @(posedge channel.w_clk);

        if (m_wr_indx < m_wr_queue.size()) begin
            m_trx = m_wr_queue[m_wr_indx];

            repeat(1) @(posedge channel.w_clk);

            channel.write <= 1'b1;
            channel.input_data    <= m_trx.input_data;
            @(posedge channel.w_clk);

            // free trx
          
            repeat(1) @(posedge channel.w_clk); //`delay(m_conf.half_cycle);
            channel.write <= 1'b0;
            channel.input_data    <= 0;
            @(posedge channel.w_clk);

            m_wr_indx += 1;
        end 
        else begin
            @(posedge channel.w_clk);
        end
    end
endtask : sent_write_trx
//}}}

task asyn_fifo_uvm_driver_class::sent_read_trx();
//{{{
    asyn_fifo_transfer m_trx;

    forever begin
        // if rdite trx has existed...
        repeat(m_rd_queue.size()==0) @(posedge channel.r_clk);

        if (m_rd_indx < m_rd_queue.size()) begin
            m_trx = m_rd_queue[m_rd_indx];

            repeat(1) @(posedge channel.r_clk);

            channel.read <= 1'b1;
            @(posedge channel.r_clk);

            // free trx
          
            repeat(1) @(posedge channel.r_clk); //`delay(m_conf.half_cycle);
            channel.read <= 1'b0;
            @(posedge channel.r_clk);

            m_rd_indx += 1;
        end 
        else begin
            @(posedge channel.r_clk);
        end
    end
endtask : sent_read_trx
//}}}



