
`ifndef ASYN_FIFO_TB_SV
`define ASYN_FIFO_TB_SV

class asyn_fifo_tb extends uvm_env;

    asyn_fifo_virtual_sequencer virtual_sequencer;
  
    `uvm_component_utils_begin(asyn_fifo_tb)
    `uvm_component_utils_end

    //AXI_env          m_axi_env;
    //Demo_scoreboard  m_asyn_fifo_scoreboard;
    //Demo_conf        m_asyn_fifo_conf;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    extern virtual function void build_phase(uvm_phase phase);
    //extern virtual function void connect_phase(uvm_phase phase);

endclass : asyn_fifo_tb

// set up conf to sub leaf masters/slaves
function void asyn_fifo_tb::build_phase(uvm_phase phase);
    super.build_phase(phase);
    virtual_sequencer = asyn_fifo_virtual_sequencer::type_id::create("virtual_sequencer",this);
    //m_asyn_fifo_conf       = Demo_conf::type_id::create("m_asyn_fifo_conf", this);
    //m_asyn_fifo_scoreboard = Demo_scoreboard::type_id::create("m_asyn_fifo_scoreboard", this);
    //m_axi_env         = AXI_env::type_id::create("m_axi_env", this);
    //m_axi_env.assign_conf(m_asyn_fifo_conf);
endfunction : build_phase

// TLM analysis port from master/slave monitor to scoreboard
function void asyn_fifo_tb::connect_phase(uvm_phase phase);
    //Virtual_sequencer.axi_sequencer = m_axi_env.m_masters[0].m_sequencer;
    //M_axi_env.m_masters[0].m_monitor.item_collected_port.connect(m_asyn_fifo_scoreboard.item_collected_imp);
    //M_axi_env.m_slaves[0].m_monitor.item_collected_port.connect(m_asyn_fifo_scoreboard.item_collected_imp);
endfunction : connect_phase
`endif // ASYN_FIFO_TB_SV
