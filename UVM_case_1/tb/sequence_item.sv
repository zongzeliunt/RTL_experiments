
class counter_trans extends uvm_sequence_item;
//{{{ 
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
//}}}
