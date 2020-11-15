`include "fifo_ports.sv"

program fifo_top (fifo_ports ports, fifo_monitor_ports mports);
  `include "fifo_sb.sv"
  `include "fifo_driver.sv"

  fifo_driver driver = new(ports, mports);

  initial begin
    driver.go();
  end

endprogram
