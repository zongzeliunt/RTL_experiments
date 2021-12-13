//sequencer defination 
class counter_sequencer extends uvm_sequencer # (counter_trans);
//{{{
    `uvm_component_utils(counter_sequencer)
 
    function new(string name="", uvm_component parent=null);
        //super.new(name,null);
        super.new(.name(name), .parent(parent));
    endfunction
endclass
//}}}
