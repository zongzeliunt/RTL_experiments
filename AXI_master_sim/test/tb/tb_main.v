`timescale 1 ns / 1 ps

`define AUTOTB_DUT      example
`define AUTOTB_DUT_INST AESL_inst_example
`define AUTOTB_TOP      apatb_example_top
`define AUTOTB_TOP_INST AESL_inst_apatb_example_top

`define AESL_DEPTH_a 1
module `AUTOTB_TOP;

parameter PROGRESS_TIMEOUT = 10000000;
parameter LENGTH_a = 10;

parameter RESET_VALUE = 0;
parameter RESET_VALUE_n = 1;

reg clk;
reg reset;
reg start;
reg ready_init;
reg dut_ready_delay;
wire dut_ready;
wire done;
wire idle;
wire internal_ready;

assign internal_ready = (ready_init | dut_ready_delay);
//axi signal
//{{{
wire  a_AWVALID;
wire  a_AWREADY;
wire [31 : 0] a_AWADDR;
wire [0 : 0] a_AWID;
wire [7 : 0] a_AWLEN;
wire [2 : 0] a_AWSIZE;
wire [1 : 0] a_AWBURST;
wire [1 : 0] a_AWLOCK;
wire [3 : 0] a_AWCACHE;
wire [2 : 0] a_AWPROT;
wire [3 : 0] a_AWQOS;
wire [3 : 0] a_AWREGION;
wire [0 : 0] a_AWUSER;
wire  a_WVALID;
wire  a_WREADY;
wire [31 : 0] a_WDATA;
wire [3 : 0] a_WSTRB;
wire  a_WLAST;
wire [0 : 0] a_WID;
wire [0 : 0] a_WUSER;
wire  a_ARVALID;
wire  a_ARREADY;
wire [31 : 0] a_ARADDR;
wire [0 : 0] a_ARID;
wire [7 : 0] a_ARLEN;
wire [2 : 0] a_ARSIZE;
wire [1 : 0] a_ARBURST;
wire [1 : 0] a_ARLOCK;
wire [3 : 0] a_ARCACHE;
wire [2 : 0] a_ARPROT;
wire [3 : 0] a_ARQOS;
wire [3 : 0] a_ARREGION;
wire [0 : 0] a_ARUSER;
wire  a_RVALID;
wire  a_RREADY;
wire [31 : 0] a_RDATA;
wire  a_RLAST;
wire [0 : 0] a_RID;
wire [0 : 0] a_RUSER;
wire [1 : 0] a_RRESP;
wire  a_BVALID;
wire  a_BREADY;
wire [1 : 0] a_BRESP;
wire [0 : 0] a_BID;
wire [0 : 0] a_BUSER;
//}}}

//top
`AUTOTB_DUT `AUTOTB_DUT_INST(
//{{{
    .ap_clk(clk),
    .ap_rst_n(reset),
    .ap_start(start),
    .ap_done(done),
    .ap_idle(idle),
    .ap_ready(dut_ready),
	//{{{
    .m_axi_a_AWVALID(a_AWVALID),
    .m_axi_a_AWREADY(a_AWREADY),
    .m_axi_a_AWADDR(a_AWADDR),
    .m_axi_a_AWID(a_AWID),
    .m_axi_a_AWLEN(a_AWLEN),
    .m_axi_a_AWSIZE(a_AWSIZE),
    .m_axi_a_AWBURST(a_AWBURST),
    .m_axi_a_AWLOCK(a_AWLOCK),
    .m_axi_a_AWCACHE(a_AWCACHE),
    .m_axi_a_AWPROT(a_AWPROT),
    .m_axi_a_AWQOS(a_AWQOS),
    .m_axi_a_AWREGION(a_AWREGION),
    .m_axi_a_AWUSER(a_AWUSER),
    .m_axi_a_WVALID(a_WVALID),
    .m_axi_a_WREADY(a_WREADY),
    .m_axi_a_WDATA(a_WDATA),
    .m_axi_a_WSTRB(a_WSTRB),
    .m_axi_a_WLAST(a_WLAST),
    .m_axi_a_WID(a_WID),
    .m_axi_a_WUSER(a_WUSER),
    .m_axi_a_ARVALID(a_ARVALID),
    .m_axi_a_ARREADY(a_ARREADY),
    .m_axi_a_ARADDR(a_ARADDR),
    .m_axi_a_ARID(a_ARID),
    .m_axi_a_ARLEN(a_ARLEN),
    .m_axi_a_ARSIZE(a_ARSIZE),
    .m_axi_a_ARBURST(a_ARBURST),
    .m_axi_a_ARLOCK(a_ARLOCK),
    .m_axi_a_ARCACHE(a_ARCACHE),
    .m_axi_a_ARPROT(a_ARPROT),
    .m_axi_a_ARQOS(a_ARQOS),
    .m_axi_a_ARREGION(a_ARREGION),
    .m_axi_a_ARUSER(a_ARUSER),
    .m_axi_a_RVALID(a_RVALID),
    .m_axi_a_RREADY(a_RREADY),
    .m_axi_a_RDATA(a_RDATA),
    .m_axi_a_RLAST(a_RLAST),
    .m_axi_a_RID(a_RID),
    .m_axi_a_RUSER(a_RUSER),
    .m_axi_a_RRESP(a_RRESP),
    .m_axi_a_BVALID(a_BVALID),
    .m_axi_a_BREADY(a_BREADY),
    .m_axi_a_BRESP(a_BRESP),
    .m_axi_a_BID(a_BID),
    .m_axi_a_BUSER(a_BUSER)
	//}}}
	);
//}}}

//a driver
AESL_axi_slave #( 
	.MEM_DEPTH (10)
	) AESL_AXI_SLAVE_a(
//{{{
    .clk   (clk),
    .reset (reset),
	//{{{
    .TRAN_AWVALID (a_AWVALID),
    .TRAN_AWREADY (a_AWREADY),
    .TRAN_AWADDR (a_AWADDR),
    .TRAN_AWID (a_AWID),
    .TRAN_AWLEN (a_AWLEN),
    .TRAN_AWSIZE (a_AWSIZE),
    .TRAN_AWBURST (a_AWBURST),
    .TRAN_AWLOCK (a_AWLOCK),
    .TRAN_AWCACHE (a_AWCACHE),
    .TRAN_AWPROT (a_AWPROT),
    .TRAN_AWQOS (a_AWQOS),
    .TRAN_AWREGION (a_AWREGION),
    .TRAN_AWUSER (a_AWUSER),
    .TRAN_WVALID (a_WVALID),
    .TRAN_WREADY (a_WREADY),
    .TRAN_WDATA (a_WDATA),
    .TRAN_WSTRB (a_WSTRB),
    .TRAN_WLAST (a_WLAST),
    .TRAN_WID (a_WID),
    .TRAN_WUSER (a_WUSER),
    .TRAN_ARVALID (a_ARVALID),
    .TRAN_ARREADY (a_ARREADY),
    .TRAN_ARADDR (a_ARADDR),
    .TRAN_ARID (a_ARID),
    .TRAN_ARLEN (a_ARLEN),
    .TRAN_ARSIZE (a_ARSIZE),
    .TRAN_ARBURST (a_ARBURST),
    .TRAN_ARLOCK (a_ARLOCK),
    .TRAN_ARCACHE (a_ARCACHE),
    .TRAN_ARPROT (a_ARPROT),
    .TRAN_ARQOS (a_ARQOS),
    .TRAN_ARREGION (a_ARREGION),
    .TRAN_ARUSER (a_ARUSER),
    .TRAN_RVALID (a_RVALID),
    .TRAN_RREADY (a_RREADY),
    .TRAN_RDATA (a_RDATA),
    .TRAN_RLAST (a_RLAST),
    .TRAN_RID (a_RID),
    .TRAN_RUSER (a_RUSER),
    .TRAN_RRESP (a_RRESP),
    .TRAN_BVALID (a_BVALID),
    .TRAN_BREADY (a_BREADY),
    .TRAN_BRESP (a_BRESP),
    .TRAN_BID (a_BID),
    .TRAN_BUSER (a_BUSER),
	//}}}
    .ready (internal_ready),
    .done  (done)
);
//}}}

//clk, reset, clk_cnt
//{{{
reg [31:0] clk_cnt = 0;

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

always @ (posedge clk) begin
	clk_cnt <= clk_cnt + 1;
end

initial begin : initial_process
    reset = RESET_VALUE;
    # 100;
    repeat(3) @ (posedge clk);
    reset = RESET_VALUE_n;
end
//}}}

initial begin : start_process
    start = 0;
    wait (reset === RESET_VALUE_n);
    @ (posedge clk);
    #0 start = 1;
end

initial begin : done_process
    forever begin
        @ (posedge clk);
    	if (done == 1) begin 
			@ (posedge clk);
			@ (posedge clk);
			@ (posedge clk);
			@ (posedge clk);

			$finish;
		end
	end
end

initial begin : ready_initial_process
    ready_init = 0;
    wait (start === 1);
    ready_init = 1;
    @(posedge clk);
    ready_init = 0;
end

always @(posedge clk)
begin
    if(reset === RESET_VALUE)
      dut_ready_delay = 0;
  else
      dut_ready_delay = dut_ready;
end
endmodule
