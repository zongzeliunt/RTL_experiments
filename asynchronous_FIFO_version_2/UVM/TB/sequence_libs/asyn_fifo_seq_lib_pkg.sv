`ifndef ASYN_FIFO_SEQ_LIB_PKG_SV
`define ASYN_FIFO_SEQ_LIB_PKG_SV

package asyn_fifo_seq_lib_pkg;

// Import the UVM class library  and UVM automation macros
import uvm_pkg::*;
`include "uvm_macros.svh"


`include "asyn_fifo_pkg.sv"
import asyn_fifo_pkg::*;



`include "asyn_fifo_seq_lib.sv"
endpackage : asyn_fifo_seq_lib_pkg

`endif  // AXI_SEQ_LIB_PKG_SV
