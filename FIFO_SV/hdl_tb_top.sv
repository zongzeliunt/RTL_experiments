`include "ram_dp_ar_aw.v"
`include "syn_fifo.v"

module fifo_tb();

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 3;

reg clk;
wire rst, wr_cs, rd_cs;
wire rd_en, wr_en;
wire [DATA_WIDTH-1:0] data_in ;
wire full, empty;
wire [DATA_WIDTH-1:0] data_out ;

fifo_ports ports (
  .clk           (clk     ),
  .rst           (rst     ),
  .wr_cs         (wr_cs   ),
  .rd_cs         (rd_cs   ),
  .rd_en         (rd_en   ),
  .wr_en         (wr_en   ),
  .data_in       (data_in ),
  .full          (full    ),
  .empty         (empty   ),
  .data_out      (data_out)
);

fifo_monitor_ports mports (
  .clk           (clk     ),
  .rst           (rst     ),
  .wr_cs         (wr_cs   ),
  .rd_cs         (rd_cs   ),
  .rd_en         (rd_en   ),
  .wr_en         (wr_en   ),
  .data_in       (data_in ),
  .full          (full    ),
  .empty         (empty   ),
  .data_out      (data_out)
);


fifo_top top(ports,mports);

  
initial begin
  $dumpfile("fifo.vcd");
  $dumpvars();
  clk = 0;
end

always #1 clk  = ~clk;

syn_fifo #(DATA_WIDTH,ADDR_WIDTH) fifo(
.clk      (clk),     // Clock input
.rst      (rst),     // Active high reset
.wr_cs    (wr_cs),   // Write chip select
.rd_cs    (rd_cs),   // Read chipe select
.data_in  (data_in), // Data input
.rd_en    (rd_en),   // Read enable
.wr_en    (wr_en),   // Write Enable
.data_out (data_out),// Data Output
.empty    (empty),   // FIFO empty
.full     (full)     // FIFO full
);

endmodule