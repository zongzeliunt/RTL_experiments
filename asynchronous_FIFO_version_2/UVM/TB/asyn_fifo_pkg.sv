
`ifndef ASYN_FIFO_SV
`define ASYN_FIFO_SV

package asyn_fifo_pkg;

import uvm_pkg::*;

//不要在这里include interface，编译器不允许
`include "asyn_fifo_transfer.sv"
`include "asyn_fifo_driver.sv"

`include "asyn_fifo_master_sequencer.sv"
`include "asyn_fifo_agent.sv"


endpackage 
`endif  // ASYN_FIFO_SV
