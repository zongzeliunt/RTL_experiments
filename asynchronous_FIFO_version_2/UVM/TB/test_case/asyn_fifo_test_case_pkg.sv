
`ifndef TEST_CASE_PKG_SV
`define TEST_CASE_PKG_SV

package asyn_fifo_test_case_pkg;


import uvm_pkg::*;
`include "uvm_macros.svh"



`include "asyn_fifo_pkg.sv"
import asyn_fifo_pkg::*;

`include "asyn_fifo_seq_lib_pkg.sv"
import asyn_fifo_seq_lib_pkg::*;

//`include "test_case_scoreboard.sv"
`include "asyn_fifo_master_test_case.sv"


endpackage : asyn_fifo_test_case_pkg

`endif // TEST_CASE_PKG_SV
