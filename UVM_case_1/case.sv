module Counter(clk,reset,data);
  input wire clk,reset;
  output reg [3:0] data;
 
  always @ (posedge clk)
    begin
      if(reset)
        data<=0;
      else
        data<=data+1;
    end
endmodule
 
interface Bus_if;
        wire clk;
        wire reset;
  reg [3:0] data;
endinterface
 
`include "uvm_macros.svh"
 
module top();
//generate the clock
  reg    clk = 0;
  initial begin
    forever #5  clk = ~clk;
  end
//interface instance
  Bus_if Bus_if1();
 
// Dut instance
  Counter Counter1(Bus_if1.clk,Bus_if1.reset,Bus_if1.data);
 
//set virtual interface
  initial begin
         uvm_config_db#(virtual Bus_if)::set(null,"*","Bus_if1",Bus_if1);
   run_test();
end
endmodule
 
//testbench starts here
import uvm_pkg::*;
class counter_trans extends uvm_sequence_item;
 
  rand bit clk;
  rand bit reset;
  rand bit data;
 
  function new(string name="");
    super.new(name)     ;
  endfunction
 
  `uvm_object_utils_begin(counter_trans)
  `uvm_field_int ( clk,  UVM_ALL_ON )
  `uvm_field_int ( reset,UVM_ALL_ON )
  `uvm_field_int ( data, UVM_ALL_ON )
    `uvm_object_utils_end
endclass
//counter sequence definition is here
class count_seq extends uvm_sequence#(counter_trans);
 
  `uvm_object_utils(count_seq)
 
  virtual Bus_if Bus_if1;
 
  function new(string name="");
    super.new(name)     ;
     void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
    if(!uvm_config_db#(virtual Bus_if)::get(this,"*     ","Bus_if1",Bus_if1))   begin
      `uvm_error("","uvm_config_db::get failed in driver");
    end
  endfunction
 
 
  task body     ();
    counter_trans  req;
    req=counter_trans::type_id::create("req",this);
 
    if(Bus_if1.clk) begin
    start_item( req.randomize() );
      finish_item(req); // this function used to send transaction items to driver
    end
     // req.start(sqr);
    else if (!req.randomize()) begin
      `uvm_error("MY_SEQUENCE", "Randomize failed.");
    end
  endtask
endclass
//sequencer defination
 
class counter_sequencer extends uvm_sequencer # (counter_trans);
  `uvm_component_utils(counter_sequencer)
 
 function new(string name="");
    super.new(name)     ;
  endfunction
 
endclass
class driver extends uvm_driver # (counter_trans);
  `uvm_component_utils(driver)
 
  virtual Bus_if Bus_if1;
 
  function new(string name,uvm_component_parent="null");
    super.new(name,null);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // req = sequence_gen::type_id::create("req",this);
    void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
    if(!uvm_config_db#(virtual Bus_if)::get(this,"*     ","Bus_if1",Bus_if1))   begin
      `uvm_error("","uvm_config_db::get failed in driver");
    end
  endfunction
 
  task run_phase(uvm_phase phase);
 
    counter_trans req;
 
    fork
      forever begin
       seq_item_port.get_next_item(req);
       // gets the sequence item from the sequence_gen
        if(Bus_if1.clk<=req.clk)
       Bus_if1.reset <=req.reset;
       Bus_if1.data <= req.data;
       seq_item_port.item_done();
      end
   join_none
  endtask
  endclass
class monitor extends uvm_monitor;
 
    `uvm_component_utils(monitor)
 
  uvm_analysis_port # (counter_trans) ap_objseq;
        virtual Bus_if Bus_if1;
 
  function new(string name, uvm_component_parent="null");
    super.new(name, null);
    endfunction
 
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      void'(uvm_config_db#(virtual Bus_if)::get(this,"*","Bus_if1",Bus_if1));
      ap_objseq = new(.name("ap_objseq"),.parent(this));
 
    endfunction
 
  task run_phase(       uvm_phase phase);
    forever begin
      //sequence_gen req;
      counter_trans req;
          req=counter_trans::type_id::create("req",this);
      @ Bus_if1.clk;
      req.reset = Bus_if1.reset;
      req.data = Bus_if1.data;
      ap_objseq.write(req);
    end
    endtask
   endclass
class coverage extends uvm_subscriber # (counter_trans);
      `uvm_component_utils(coverage)
      counter_trans req;
 
  function new(string name, uvm_component_parent="null");
    super.new(name,null);
      endfunction
 
      covergroup count_cov;
          coverpoint req.clk;
          coverpoint req.reset;
          coverpoint req.data;
        endgroup
 
      function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        count_cov = new();
      endfunction
 
  function void write(counter_trans cov_tx);
        req = cov_tx;
        req.clk = cov_tx.clk;
        req.reset = cov_tx.reset;
        req.data = cov_tx.data;
        count_cov.sample();
      endfunction
      endclass
 
typedef class scoreboard;
                   class counter_subscriber extends uvm_subscriber # (counter_trans);
//{{{
         `uvm_component_utils(counter_subscriber)
    counter_trans  req;
 
    function new (string name, uvm_component_parent="null");
      super.new(name, null);
        endfunction
 
    function void write(counter_trans sb_tx);
      req = sb_tx;
      req.clk = sb_tx.clk;
      req.reset = sb_tx.reset;
      req.data = sb_tx.data;
    endfunction
 
  endclass
//}}}

class scoreboard extends uvm_scoreboard;
//}}} 
        `uvm_component_utils(scoreboard)
 
  uvm_analysis_port # (counter_trans)  ap_objseq;
 
        scoreboard sb;
 
    local counter_subscriber counter_sub;
 
                rand bit store;
 
  function new (string name, uvm_component_parent="null");
    super.new(name, null);
        endfunction
 
        function void build_phase (uvm_phase phase);
          super.build_phase(phase);
         // ap_objseq = sequence_gen::type_id::create("ap_objseq",this);
          ap_objseq = new(.name("ap_objseq"),.parent(this));
                                    counter_sub=counter_subscriber::type_id::create("counter_sub",this);
                  endfunction
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ap_objseq.connect( counter_sub.analysis_export );
  endfunction
 
task run_phase();
        //  if(Bus_if1.clk) begin
         //   if(!Bus_if1.reset) begin
           if(sb.clk) begin
            if(!sb.reset) begin
                sb.store = sb.store+1;
                end
                else begin
              sb.store = 0;
            end
          end
          if(sb.store==req.data) begin
            `uvm_info("","test has been passed","UVM_LOW");
          end
                endtask
 
endclass
//}}}
          
class agent extends uvm_agent;
//{{{ 
  `uvm_component_utils(agent)
 
  uvm_analysis_port # (counter_trans) ap_objseq;
 
 // virtual Bus_if Bus_if1;
 
 
        counter_sequencer        sqr;
        driver       drv;
    monitor      mtr;
        scoreboard   sb;
        coverage     cov;
 
  function new(string name, uvm_component_parent="null");
    super.new(name,null);
  endfunction
 
function void build_phase(uvm_phase phase);
  super.buid_phase(phase);
  ap_objseq = new(.name("ap_objseq"),.parent(this));
  drv = driver::type_id::create("drv",this);
  mtr = monitor::type_id::create("mtr",this);
  sb = scoreboard::type_id::create("sb",this);
  cov = coverage::type_id::create("cov",this);
  sqr = counter_sequencer::type_id::create("sqr",this);
 
  /*if(!uvm_config_db#(virtual Bus_if)::get(this,"","Bus_if1",Bus_if1))
  begin
    `uvm_fatal("In agent","virtual interface not got successful");
  end
  */
/*  uvm_config_db # (virtual Bus_if)::set(this,"monitor","Bus_if1",Bus_if1);
  uvm_config_db # (virtual Bus_if)::set(this,"driver","Bus_if1",Bus_if1);
  uvm_config_db # (virtual Bus_if)::set(this,"monitor","Bus_if1",Bus_if1);
  uvm_config_db # (virtual Bus_if)::set(this,"coverage","Bus_if1",Bus_if1);
*/
  endfunction
 
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  drv.seq_item_port.connect(sqr.seq_item_export);
  mtr.ap_objseq.connect(ap_objseq);
endfunction
endclass
//}}}

// environment defination 
class environment extends uvm_env;
//{{{
  `uvm_component_utils(environment)
 
  uvm_analysis_port # (counter_trans)   ap_objseq;
 
  agent agt;
  coverage cov;
  scoreboard sb;
  counter_subscriber count_sub;
 
 
  function new(string name, uvm_component_parent="null");
    super.new(name,parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    agt = agent::type_id::create("agt",this);
   // seq_env = sequence_gen :: type_id::create("seq_env",this);
    cov = coverage :: type_id::create("cov",this);
    sb = scoreboard :: type_id::create("sb",this);
    count_sub=counter_subscriber::type_id::create("count_sub",this);
  endfunction
 
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    agt.ap_objseq.connect(cov.analysis_export);
    agt.ap_objseq.connect(sb.analysis_export);
    agt.ap_objseq.connect(count_sub.analysis_export);
  endfunction
 
endclass
//}}}

class test_count extends uvm_test;
//{{{
  `uvm_component_utils(test_count)
 
  environment env;
 
  function new(string name, uvm_component_parent="null");
    super.new(name,null);
  endfunction
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  env = environment::type_id::create("env",this);
  endfunction
 
//  task run_test(uvm_phase phase);
task run_phase(uvm_phase phase);
    counter_trans  req;
    phase.raise_objection(this);
  req.start(env.agt.sqr);
    #10
    phase.drop_objection(this);
  endtask
 
endclass
//}}}
