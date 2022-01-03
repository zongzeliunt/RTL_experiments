// This is the base transaction object that will be used
// in the environment to initiate new transactions and 
// capture transactions at DUT interface

class Item extends uvm_sequence_item;
    `uvm_object_utils(Item)
    rand bit[9:0]    input_data;
    bit[9:0]         output_data;
    bit         write;
    bit         read;

    function new (string name = "Item");
        super.new(name);
    endfunction

    //constraint c1 {in dist {0:/20, 1:/80}; } //这大概是个比例，0： 20%，1：80%
endclass

