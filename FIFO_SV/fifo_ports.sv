`ifndef FIFO_PORTS_SV
`define FIFO_PORTS_SV

interface fifo_ports (
  input  wire        clk      ,
  output logic        rst      ,
  input  wire        full     ,
  input  wire        empty    ,
  output logic       wr_cs    ,
  output logic       rd_cs    ,
  output logic       rd_en    , 
  output logic       wr_en    ,
  output logic [7:0] data_in  ,
  input  wire  [7:0] data_out
);
endinterface


interface fifo_monitor_ports (
  input wire       clk      ,
  input wire        rst      ,
  input wire       full     ,
  input wire       empty    ,
  input wire       wr_cs    ,
  input wire       rd_cs    ,
  input wire       rd_en    , 
  input wire       wr_en    ,
  input wire [7:0] data_in  ,
  input wire [7:0] data_out
);
endinterface


`endif
