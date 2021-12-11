
`ifndef ASYN_FIFO_TRANSFER_SV
`define ASYN_FIFO_TRANSFER_SV

//originally write in a typedef file
typedef enum { READ = 0, WRITE = 1 }                          direction_enum;

class asyn_fifo_transfer extends uvm_sequence_item;
    rand direction_enum   rw;
    rand int input_data;
    rand int output_data;
    rand bit read;
    rand bit write;
    rand bit empty;
    rand bit full;

    `uvm_object_utils_begin(asyn_fifo_transfer)
        `uvm_field_enum (direction_enum, rw,  UVM_DEFAULT)
        `uvm_field_int  (input_data,    UVM_DEFAULT)
        `uvm_field_int  (output_data,   UVM_DEFAULT)
        `uvm_field_int  (read,          UVM_DEFAULT)
        `uvm_field_int  (write,         UVM_DEFAULT)
        `uvm_field_int  (empty,         UVM_DEFAULT)
        `uvm_field_int  (full,          UVM_DEFAULT)

    `uvm_object_utils_end

    function new (string name = "asyn_fifo_transfer");
        super.new(name);
    endfunction
endclass : asyn_fifo_transfer


`endif // ASYN_FIFO_TRANSFER_SV
