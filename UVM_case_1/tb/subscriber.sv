
class counter_subscriber extends uvm_subscriber # (counter_trans);
//{{{
    `uvm_component_utils(counter_subscriber)
    uvm_analysis_port # (counter_trans) ap_objseq;
    counter_trans  req;
 
    function new (string name, uvm_component parent=null);
        //super.new(name, null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void write(counter_trans sb_tx);
        req = sb_tx;
        req.clk = sb_tx.clk;
        req.reset = sb_tx.reset;
        req.data = sb_tx.data;
    endfunction
endclass
//}}}
