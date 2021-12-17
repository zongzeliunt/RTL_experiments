// The driver is responsible for driving transactions to the DUT 
// All it does is to get a transaction from the mailbox if it is 
// available and drive it out into the DUT interface.
class driver extends uvm_driver #(Item);              
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction
 

    virtual des_if vif;
    Item w_item_queue[$];
    int unsigned item_sent; 
    int unsigned w_m_item_indx = 0;
  
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task get_w_req();
    extern virtual task w_item_transfer(Item m_item);
    extern virtual task run_w_req();
    extern virtual task drive_item(Item m_item);
    


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction
endclass


task driver::run_phase(uvm_phase phase);
//{{{
    super.run_phase(phase);
    fork 
        get_w_req();
        run_w_req();
    join
endtask
//}}}
    

task driver::get_w_req();
//{{{
    Item m_item;
    forever begin
        @(posedge vif.clk);
        `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
        seq_item_port.get_next_item(m_item);
        w_item_transfer(m_item);
        //drive_item(m_item);
        seq_item_port.item_done();
    end
endtask
//}}}

task driver::w_item_transfer(Item m_item);
//{{{
    w_item_queue.push_back(m_item);
    item_sent++;
endtask
//}}}

task driver::run_w_req();
//{{{
    Item m_item;
    forever begin
        repeat(w_item_queue.size()==0) @(posedge vif.clk);
        if (w_m_item_indx < w_item_queue.size()) begin
            m_item = w_item_queue[w_m_item_indx];
            drive_item(m_item);
            w_m_item_indx += 1;
        end
        else begin
            @(posedge vif.clk);
        end
    end
endtask
//}}}

task driver::drive_item(Item m_item);
//{{{
    @(vif.cb);
    //@(posedge vif.clk);
    vif.cb.in <= m_item.in;
endtask
//}}}



