
`ifndef ASYN_FIFO_AGENT_SV
`define ASYN_FIFO_AGENT_SV

class asyn_fifo_agent extends uvm_agent;

    //AXI_master_conf     m_conf;
    virtual asyn_fifo_interface.tb channel;

	asyn_fifo_uvm_driver_class  m_driver;
	asyn_fifo_master_sequencer	m_sequencer;
	//asyn_fifo_master_monitor		m_monitor;

	// reserve fields
	`uvm_component_utils_begin(asyn_fifo_agent)
	`uvm_component_utils_end


	// constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new


	// build phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		//m_monitor = asyn_fifo_master_monitor::type_id::create("m_monitor", this);

		//if (m_conf.is_active == UVM_ACTIVE) begin
			m_driver = asyn_fifo_uvm_driver_class::type_id::create("m_driver", this);
			m_sequencer = asyn_fifo_master_sequencer::type_id::create("m_sequencer", this);
		//end
        
		//m_monitor.assign_conf(m_conf);
        /*
		if (m_conf.is_active == UVM_ACTIVE) begin
//			m_sequencer.assign_conf(axi_conf);
			m_driver.assign_conf(m_conf);
		end
        */

		//m_monitor.assign_vi(m_vif);
		//if (m_conf.is_active == UVM_ACTIVE) begin
//			m_sequencer.assign_vi(m_vif);
			m_driver.assign_vi(channel);
		//end

	endfunction : build_phase


	// connect phase
	virtual function void connect_phase(uvm_phase phase);
    //if (m_conf.is_active == UVM_ACTIVE) begin
	    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    //end
	endfunction : connect_phase


	// assign virtual interface
	//virtual function void assign_vi(virtual interface asyn_fifo_vif axi_vif);
	virtual function void assign_vi(virtual asyn_fifo_interface.tb channel);
        this.channel = channel;
	endfunction : assign_vi


	// assign configure
    /*
	virtual function void assign_conf(asyn_fifo_master_conf axi_conf);
        m_conf = axi_conf;
	endfunction : assign_conf
    */
endclass : asyn_fifo_agent


`endif // asyn_fifo_master_agent
