// The driver is responsible for driving transactions to the DUT 
// All it does is to get a transaction from the mailbox if it is 
// available and drive it out into the DUT interface.
class driver #(
    parameter TB_RESET_VALUE = 0
) extends uvm_driver #(Item);              
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction
 

    virtual des_if vif;
    Item w_item_queue[$];
    Item r_item_queue[$];
    int unsigned item_sent; 
    int unsigned w_m_item_indx = 0;
    int unsigned r_m_item_indx = 0;
  
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task signals_reset();
    extern virtual task get_req();
    extern virtual task item_transfer(Item m_item);
    extern virtual task run_w_req();
    extern virtual task run_r_req();
    //extern virtual task drive_item(Item m_item);
    


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction
endclass


task driver::run_phase(uvm_phase phase);
//{{{
    super.run_phase(phase);
    signals_reset(); 
    #5;
    fork
        get_req();
        run_w_req();
        run_r_req();
    join
endtask
//}}}
    
task driver::signals_reset();
//{{{
    vif.input_data  <= 0;
    vif.write       <= 0;
    vif.read        <= 0;            
endtask
//}}}

task driver::get_req();
//{{{
    Item m_item;
    forever begin
        #1;
        //`uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
        seq_item_port.get_next_item(m_item);
        item_transfer(m_item);
        seq_item_port.item_done();
    end
endtask
//}}}

task driver::item_transfer(Item m_item);
//{{{
    if (m_item.write == 1) begin
        w_item_queue.push_back(m_item);
    end 
    else begin
        r_item_queue.push_back(m_item);
    end
    item_sent++;
endtask
//}}}

task driver::run_w_req();
//{{{
    Item m_item;
    forever begin
        if (vif.w_reset == TB_RESET_VALUE) begin
            @(posedge vif.w_clk);
        end
        //else if (w_item_queue.size()==0 || vif.full == 1 || vif.read == 1) begin
        else if (w_item_queue.size()==0 || vif.full == 1 ) begin
            @(posedge vif.w_clk);
        end
        else if (w_m_item_indx < w_item_queue.size()) begin
            m_item = w_item_queue[w_m_item_indx];
            vif.input_data <= m_item.input_data;
            vif.write       <= 1;
            //vif.read        <= 0;            
            @(posedge vif.w_clk);
            vif.write       <= 0;
            w_m_item_indx += 1;
        end
        else begin
            @(posedge vif.w_clk);
        end
    end
endtask
//}}}

task driver::run_r_req();
//{{{
    Item m_item;
    forever begin
        if (vif.r_reset == TB_RESET_VALUE) begin
            @(posedge vif.r_clk);
        end
        //else if (r_item_queue.size()==0 || vif.empty == 1 || vif.write == 1) begin
        else if (r_item_queue.size()==0 || vif.empty == 1) begin
            @(posedge vif.r_clk);
        end
        else if (r_m_item_indx < r_item_queue.size()) begin
            m_item = r_item_queue[r_m_item_indx];
            //vif.write       <= 0;
            vif.read        <= 1;
            @(posedge vif.r_clk);
            vif.read        <= 0;
            r_m_item_indx += 1;
        end
        else begin
            @(posedge vif.r_clk);
        end
    end
endtask
//}}}



