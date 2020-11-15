class fifo_driver;
  fifo_sb sb;
  virtual fifo_ports ports;
  virtual fifo_monitor_ports mports;

  bit rdDone;
  bit wrDone;

  integer wr_cmds;
  integer rd_cmds;

  function new (virtual fifo_ports ports, virtual fifo_monitor_ports mports);
  begin
    this.ports = ports;
    this.mports = mports;
    sb = new();
    wr_cmds = 5;
    rd_cmds = 5;
    rdDone = 0;
    wrDone = 0;
    ports.wr_cs  = 0;
    ports.rd_cs  = 0;
    ports.wr_en  = 0;
    ports.rd_en  = 0;
    ports.data_in  = 0;
  end
  endfunction
  
  task monitorPush();
  begin
    bit [7:0] data = 0;
    while (1) begin
      @ (posedge mports.clk);
      if (mports.wr_cs== 1 &&  mports.wr_en== 1) begin
        data = mports.data_in;
        sb.addItem(data);
        $write("%dns : Write posting to scoreboard data = %x\n",$time, data);
      end
    end
  end
  endtask

  task monitorPop();
  begin
    bit [7:0] data = 0;
    while (1) begin
      @ (posedge mports.clk);
      if (mports.rd_cs== 1 &&  mports.rd_en== 1) begin
        data = mports.data_out;
        $write("%dns : Read posting to scoreboard data = %x\n",$time, data);
        sb.compareItem(data);
      end
    end
  end
  endtask

  task go();
  begin
    // Assert reset first
    reset();
    // Start the monitors
    repeat (5) @ (posedge ports.clk);
    $write("%dns : Starting Pop and Push monitors\n",$time);
    fork
      monitorPop();
      monitorPush();
    join_none
    $write("%dns : Starting Pop and Push generators\n",$time);
    fork
      genPush();
      genPop(); 
    join_none

    while (!rdDone && !wrDone) begin
      @ (posedge ports.clk);
    end
    repeat (10) @ (posedge ports.clk);
    $write("%dns : Terminating simulations\n",$time);
  end
  endtask

  task reset();
  begin
    repeat (5) @ (posedge ports.clk);
    $write("%dns : Asserting reset\n",$time);
    ports.rst= 1'b1;
    // Init all variables
    rdDone = 0;
    wrDone = 0;
    repeat (5) @ (posedge ports.clk);
    ports.rst= 1'b0;
    $write("%dns : Done asserting reset\n",$time);
  end
  endtask

  task genPush();
  begin
    bit [7:0] data = 0;
    integer i = 0;
    for ( i  = 0; i < wr_cmds; i++)  begin
       data = $random();
       @ (posedge ports.clk);
       while (ports.full== 1'b1) begin
        ports.wr_cs  = 1'b0;
        ports.wr_en  = 1'b0;
        ports.data_in= 8'b0;
        @ (posedge ports.clk); 
       end
       ports.wr_cs  = 1'b1;
       ports.wr_en  = 1'b1;
       ports.data_in= data;
    end
    @ (posedge ports.clk);
    ports.wr_cs  = 1'b0;
    ports.wr_en  = 1'b0;
    ports.data_in= 8'b0;
    repeat (10) @ (posedge ports.clk);
    wrDone = 1;
  end
  endtask
  
  task genPop();
  begin
    integer i = 0;
    for ( i  = 0; i < rd_cmds; i++)  begin
       @ (posedge ports.clk);
       while (ports.empty== 1'b1) begin
         ports.rd_cs  = 1'b0;
         ports.rd_en  = 1'b0;
         @ (posedge ports.clk); 
       end
       ports.rd_cs  = 1'b1;
       ports.rd_en  = 1'b1;
    end
    @ (posedge ports.clk);
    ports.rd_cs   = 1'b0;
    ports.rd_en   = 1'b0;
    repeat (10) @ (posedge ports.clk);
    rdDone = 1;
  end
  endtask
endclass
