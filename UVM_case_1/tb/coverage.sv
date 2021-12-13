
class coverage extends uvm_subscriber # (counter_trans);
//{{{
    `uvm_component_utils(coverage)
    counter_trans req;
 
    function new(string name, uvm_component parent=null);
        //super.new(name,null);
        super.new(.name(name), .parent(parent));
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
//}}}
