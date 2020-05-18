// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2018.3
// Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="example,hls_ip_2018_3,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020clg484-2,HLS_INPUT_CLOCK=13.333000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=11.666375,HLS_SYN_LAT=57,HLS_SYN_TPT=none,HLS_SYN_MEM=2,HLS_SYN_DSP=0,HLS_SYN_FF=698,HLS_SYN_LUT=717,HLS_VERSION=2018_3}" *)

module example (
        ap_clk,
        ap_rst_n,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        m_axi_a_AWVALID,
        m_axi_a_AWREADY,
        m_axi_a_AWADDR,
        m_axi_a_AWID,
        m_axi_a_AWLEN,
        m_axi_a_AWSIZE,
        m_axi_a_AWBURST,
        m_axi_a_AWLOCK,
        m_axi_a_AWCACHE,
        m_axi_a_AWPROT,
        m_axi_a_AWQOS,
        m_axi_a_AWREGION,
        m_axi_a_AWUSER,
        m_axi_a_WVALID,
        m_axi_a_WREADY,
        m_axi_a_WDATA,
        m_axi_a_WSTRB,
        m_axi_a_WLAST,
        m_axi_a_WID,
        m_axi_a_WUSER,
        m_axi_a_ARVALID,
        m_axi_a_ARREADY,
        m_axi_a_ARADDR,
        m_axi_a_ARID,
        m_axi_a_ARLEN,
        m_axi_a_ARSIZE,
        m_axi_a_ARBURST,
        m_axi_a_ARLOCK,
        m_axi_a_ARCACHE,
        m_axi_a_ARPROT,
        m_axi_a_ARQOS,
        m_axi_a_ARREGION,
        m_axi_a_ARUSER,
        m_axi_a_RVALID,
        m_axi_a_RREADY,
        m_axi_a_RDATA,
        m_axi_a_RLAST,
        m_axi_a_RID,
        m_axi_a_RUSER,
        m_axi_a_RRESP,
        m_axi_a_BVALID,
        m_axi_a_BREADY,
        m_axi_a_BRESP,
        m_axi_a_BID,
        m_axi_a_BUSER
);

parameter    ap_ST_fsm_state1 = 17'd1;
parameter    ap_ST_fsm_state2 = 17'd2;
parameter    ap_ST_fsm_state3 = 17'd4;
parameter    ap_ST_fsm_state4 = 17'd8;
parameter    ap_ST_fsm_state5 = 17'd16;
parameter    ap_ST_fsm_state6 = 17'd32;
parameter    ap_ST_fsm_state7 = 17'd64;
parameter    ap_ST_fsm_pp0_stage0 = 17'd128;
parameter    ap_ST_fsm_state11 = 17'd256;
parameter    ap_ST_fsm_state12 = 17'd512;
parameter    ap_ST_fsm_state13 = 17'd1024;
parameter    ap_ST_fsm_pp1_stage0 = 17'd2048;
parameter    ap_ST_fsm_state17 = 17'd4096;
parameter    ap_ST_fsm_state18 = 17'd8192;
parameter    ap_ST_fsm_state19 = 17'd16384;
parameter    ap_ST_fsm_state20 = 17'd32768;
parameter    ap_ST_fsm_state21 = 17'd65536;
parameter    C_M_AXI_A_ID_WIDTH = 1;
parameter    C_M_AXI_A_ADDR_WIDTH = 32;
parameter    C_M_AXI_A_DATA_WIDTH = 32;
parameter    C_M_AXI_A_AWUSER_WIDTH = 1;
parameter    C_M_AXI_A_ARUSER_WIDTH = 1;
parameter    C_M_AXI_A_WUSER_WIDTH = 1;
parameter    C_M_AXI_A_RUSER_WIDTH = 1;
parameter    C_M_AXI_A_BUSER_WIDTH = 1;
parameter    C_M_AXI_A_TARGET_ADDR = 0;
parameter    C_M_AXI_A_USER_VALUE = 0;
parameter    C_M_AXI_A_PROT_VALUE = 0;
parameter    C_M_AXI_A_CACHE_VALUE = 3;
parameter    C_M_AXI_DATA_WIDTH = 32;

parameter C_M_AXI_A_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   m_axi_a_AWVALID;
input   m_axi_a_AWREADY;
output  [C_M_AXI_A_ADDR_WIDTH - 1:0] m_axi_a_AWADDR;
output  [C_M_AXI_A_ID_WIDTH - 1:0] m_axi_a_AWID;
output  [7:0] m_axi_a_AWLEN;
output  [2:0] m_axi_a_AWSIZE;
output  [1:0] m_axi_a_AWBURST;
output  [1:0] m_axi_a_AWLOCK;
output  [3:0] m_axi_a_AWCACHE;
output  [2:0] m_axi_a_AWPROT;
output  [3:0] m_axi_a_AWQOS;
output  [3:0] m_axi_a_AWREGION;
output  [C_M_AXI_A_AWUSER_WIDTH - 1:0] m_axi_a_AWUSER;
output   m_axi_a_WVALID;
input   m_axi_a_WREADY;
output  [C_M_AXI_A_DATA_WIDTH - 1:0] m_axi_a_WDATA;
output  [C_M_AXI_A_WSTRB_WIDTH - 1:0] m_axi_a_WSTRB;
output   m_axi_a_WLAST;
output  [C_M_AXI_A_ID_WIDTH - 1:0] m_axi_a_WID;
output  [C_M_AXI_A_WUSER_WIDTH - 1:0] m_axi_a_WUSER;
output   m_axi_a_ARVALID;
input   m_axi_a_ARREADY;
output  [C_M_AXI_A_ADDR_WIDTH - 1:0] m_axi_a_ARADDR;
output  [C_M_AXI_A_ID_WIDTH - 1:0] m_axi_a_ARID;
output  [7:0] m_axi_a_ARLEN;
output  [2:0] m_axi_a_ARSIZE;
output  [1:0] m_axi_a_ARBURST;
output  [1:0] m_axi_a_ARLOCK;
output  [3:0] m_axi_a_ARCACHE;
output  [2:0] m_axi_a_ARPROT;
output  [3:0] m_axi_a_ARQOS;
output  [3:0] m_axi_a_ARREGION;
output  [C_M_AXI_A_ARUSER_WIDTH - 1:0] m_axi_a_ARUSER;
input   m_axi_a_RVALID;
output   m_axi_a_RREADY;
input  [C_M_AXI_A_DATA_WIDTH - 1:0] m_axi_a_RDATA;
input   m_axi_a_RLAST;
input  [C_M_AXI_A_ID_WIDTH - 1:0] m_axi_a_RID;
input  [C_M_AXI_A_RUSER_WIDTH - 1:0] m_axi_a_RUSER;
input  [1:0] m_axi_a_RRESP;
input   m_axi_a_BVALID;
output   m_axi_a_BREADY;
input  [1:0] m_axi_a_BRESP;
input  [C_M_AXI_A_ID_WIDTH - 1:0] m_axi_a_BID;
input  [C_M_AXI_A_BUSER_WIDTH - 1:0] m_axi_a_BUSER;

reg ap_done;
reg ap_idle;
reg ap_ready;

 reg    ap_rst_n_inv;
(* fsm_encoding = "none" *) reg   [16:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    a_blk_n_AR;
reg    a_blk_n_R;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0;
reg   [0:0] exitcond1_reg_217;
reg    a_blk_n_AW;
wire    ap_CS_fsm_state12;
wire   [0:0] exitcond_fu_176_p2;
reg    a_blk_n_W;
reg    ap_enable_reg_pp1_iter2;
wire    ap_block_pp1_stage0;
reg   [0:0] exitcond8_reg_245;
reg   [0:0] exitcond8_reg_245_pp1_iter1_reg;
reg    a_blk_n_B;
wire    ap_CS_fsm_state21;
reg    a_AWVALID;
wire    a_AWREADY;
reg    a_WVALID;
wire    a_WREADY;
reg    a_ARVALID;
wire    a_ARREADY;
wire    a_RVALID;
reg    a_RREADY;
wire   [31:0] a_RDATA;
wire    a_RLAST;
wire   [0:0] a_RID;
wire   [0:0] a_RUSER;
wire   [1:0] a_RRESP;
wire    a_BVALID;
reg    a_BREADY;
wire   [1:0] a_BRESP;
wire   [0:0] a_BID;
wire   [0:0] a_BUSER;
reg   [3:0] indvar_reg_125;
reg   [3:0] indvar_reg_125_pp0_iter1_reg;
wire    ap_block_state8_pp0_stage0_iter0;
reg    ap_block_state9_pp0_stage0_iter1;
wire    ap_block_state10_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [3:0] indvar6_reg_148;
wire   [0:0] exitcond1_fu_159_p2;
reg   [0:0] exitcond1_reg_217_pp0_iter1_reg;
wire   [3:0] indvar_next_fu_165_p2;
reg   [3:0] indvar_next_reg_221;
reg    ap_enable_reg_pp0_iter0;
reg   [31:0] a_read_reg_226;
reg    ap_sig_ioackin_a_AWREADY;
reg    ap_block_state12_io;
wire   [3:0] i_1_fu_182_p2;
reg   [3:0] i_1_reg_235;
reg   [3:0] buff_addr_1_reg_240;
wire   [0:0] exitcond8_fu_200_p2;
wire    ap_CS_fsm_pp1_stage0;
wire    ap_block_state14_pp1_stage0_iter0;
wire    ap_block_state15_pp1_stage0_iter1;
wire    ap_block_state16_pp1_stage0_iter2;
reg    ap_sig_ioackin_a_WREADY;
reg    ap_block_state16_io;
reg    ap_block_pp1_stage0_11001;
wire   [3:0] indvar_next7_fu_206_p2;
reg    ap_enable_reg_pp1_iter0;
wire   [31:0] buff_q0;
reg   [31:0] buff_load_1_reg_259;
reg    ap_enable_reg_pp1_iter1;
wire    ap_CS_fsm_state7;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state8;
reg    ap_enable_reg_pp0_iter2;
reg    ap_block_pp1_stage0_subdone;
reg    ap_condition_pp1_exit_iter0_state14;
reg   [3:0] buff_address0;
reg    buff_ce0;
reg    buff_we0;
reg   [31:0] buff_d0;
reg   [3:0] ap_phi_mux_indvar_phi_fu_129_p4;
reg   [3:0] i_reg_137;
wire    ap_CS_fsm_state13;
wire    ap_CS_fsm_state11;
wire   [63:0] indvar2_fu_171_p1;
wire   [63:0] tmp_fu_188_p1;
wire   [63:0] indvar1_fu_212_p1;
reg    ap_reg_ioackin_a_ARREADY;
reg    ap_sig_ioackin_a_ARREADY;
reg    ap_reg_ioackin_a_AWREADY;
reg    ap_reg_ioackin_a_WREADY;
wire    ap_block_pp1_stage0_01001;
wire   [31:0] tmp_1_fu_193_p2;
reg   [16:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_idle_pp1;
wire    ap_enable_pp1;

// power-on initialization
initial begin
#0 ap_CS_fsm = 17'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp1_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp1_iter0 = 1'b0;
#0 ap_enable_reg_pp1_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_reg_ioackin_a_ARREADY = 1'b0;
#0 ap_reg_ioackin_a_AWREADY = 1'b0;
#0 ap_reg_ioackin_a_WREADY = 1'b0;
end

example_a_m_axi #(
    .CONSERVATIVE( 0 ),
    .USER_DW( 32 ),
    .USER_AW( 32 ),
    .USER_MAXREQS( 5 ),
    .NUM_READ_OUTSTANDING( 16 ),
    .NUM_WRITE_OUTSTANDING( 16 ),
    .MAX_READ_BURST_LENGTH( 16 ),
    .MAX_WRITE_BURST_LENGTH( 16 ),
    .C_M_AXI_ID_WIDTH( C_M_AXI_A_ID_WIDTH ),
    .C_M_AXI_ADDR_WIDTH( C_M_AXI_A_ADDR_WIDTH ),
    .C_M_AXI_DATA_WIDTH( C_M_AXI_A_DATA_WIDTH ),
    .C_M_AXI_AWUSER_WIDTH( C_M_AXI_A_AWUSER_WIDTH ),
    .C_M_AXI_ARUSER_WIDTH( C_M_AXI_A_ARUSER_WIDTH ),
    .C_M_AXI_WUSER_WIDTH( C_M_AXI_A_WUSER_WIDTH ),
    .C_M_AXI_RUSER_WIDTH( C_M_AXI_A_RUSER_WIDTH ),
    .C_M_AXI_BUSER_WIDTH( C_M_AXI_A_BUSER_WIDTH ),
    .C_TARGET_ADDR( C_M_AXI_A_TARGET_ADDR ),
    .C_USER_VALUE( C_M_AXI_A_USER_VALUE ),
    .C_PROT_VALUE( C_M_AXI_A_PROT_VALUE ),
    .C_CACHE_VALUE( C_M_AXI_A_CACHE_VALUE ))
example_a_m_axi_U(
    .AWVALID(m_axi_a_AWVALID),
    .AWREADY(m_axi_a_AWREADY),
    .AWADDR(m_axi_a_AWADDR),
    .AWID(m_axi_a_AWID),
    .AWLEN(m_axi_a_AWLEN),
    .AWSIZE(m_axi_a_AWSIZE),
    .AWBURST(m_axi_a_AWBURST),
    .AWLOCK(m_axi_a_AWLOCK),
    .AWCACHE(m_axi_a_AWCACHE),
    .AWPROT(m_axi_a_AWPROT),
    .AWQOS(m_axi_a_AWQOS),
    .AWREGION(m_axi_a_AWREGION),
    .AWUSER(m_axi_a_AWUSER),
    .WVALID(m_axi_a_WVALID),
    .WREADY(m_axi_a_WREADY),
    .WDATA(m_axi_a_WDATA),
    .WSTRB(m_axi_a_WSTRB),
    .WLAST(m_axi_a_WLAST),
    .WID(m_axi_a_WID),
    .WUSER(m_axi_a_WUSER),
    .ARVALID(m_axi_a_ARVALID),
    .ARREADY(m_axi_a_ARREADY),
    .ARADDR(m_axi_a_ARADDR),
    .ARID(m_axi_a_ARID),
    .ARLEN(m_axi_a_ARLEN),
    .ARSIZE(m_axi_a_ARSIZE),
    .ARBURST(m_axi_a_ARBURST),
    .ARLOCK(m_axi_a_ARLOCK),
    .ARCACHE(m_axi_a_ARCACHE),
    .ARPROT(m_axi_a_ARPROT),
    .ARQOS(m_axi_a_ARQOS),
    .ARREGION(m_axi_a_ARREGION),
    .ARUSER(m_axi_a_ARUSER),
    .RVALID(m_axi_a_RVALID),
    .RREADY(m_axi_a_RREADY),
    .RDATA(m_axi_a_RDATA),
    .RLAST(m_axi_a_RLAST),
    .RID(m_axi_a_RID),
    .RUSER(m_axi_a_RUSER),
    .RRESP(m_axi_a_RRESP),
    .BVALID(m_axi_a_BVALID),
    .BREADY(m_axi_a_BREADY),
    .BRESP(m_axi_a_BRESP),
    .BID(m_axi_a_BID),
    .BUSER(m_axi_a_BUSER),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .I_ARVALID(a_ARVALID),
    .I_ARREADY(a_ARREADY),
    .I_ARADDR(32'd0),
    .I_ARID(1'd0),
    .I_ARLEN(32'd10),
    .I_ARSIZE(3'd0),
    .I_ARLOCK(2'd0),
    .I_ARCACHE(4'd0),
    .I_ARQOS(4'd0),
    .I_ARPROT(3'd0),
    .I_ARUSER(1'd0),
    .I_ARBURST(2'd0),
    .I_ARREGION(4'd0),
    .I_RVALID(a_RVALID),
    .I_RREADY(a_RREADY),
    .I_RDATA(a_RDATA),
    .I_RID(a_RID),
    .I_RUSER(a_RUSER),
    .I_RRESP(a_RRESP),
    .I_RLAST(a_RLAST),
    .I_AWVALID(a_AWVALID),
    .I_AWREADY(a_AWREADY),
    .I_AWADDR(32'd0),
    .I_AWID(1'd0),
    .I_AWLEN(32'd10),
    .I_AWSIZE(3'd0),
    .I_AWLOCK(2'd0),
    .I_AWCACHE(4'd0),
    .I_AWQOS(4'd0),
    .I_AWPROT(3'd0),
    .I_AWUSER(1'd0),
    .I_AWBURST(2'd0),
    .I_AWREGION(4'd0),
    .I_WVALID(a_WVALID),
    .I_WREADY(a_WREADY),
    .I_WDATA(buff_load_1_reg_259),
    .I_WID(1'd0),
    .I_WUSER(1'd0),
    .I_WLAST(1'b0),
    .I_WSTRB(4'd15),
    .I_BVALID(a_BVALID),
    .I_BREADY(a_BREADY),
    .I_BRESP(a_BRESP),
    .I_BID(a_BID),
    .I_BUSER(a_BUSER)
);

example_buff #(
    .DataWidth( 32 ),
    .AddressRange( 10 ),
    .AddressWidth( 4 ))
buff_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(buff_address0),
    .ce0(buff_ce0),
    .we0(buff_we0),
    .d0(buff_d0),
    .q0(buff_q0)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state8))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state7)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp0_exit_iter0_state8)) begin
                ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state8);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if ((1'b1 == ap_CS_fsm_state7)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp1_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp1_stage0_subdone) & (1'b1 == ap_condition_pp1_exit_iter0_state14) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
            ap_enable_reg_pp1_iter0 <= 1'b0;
        end else if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
            ap_enable_reg_pp1_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp1_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp1_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp1_exit_iter0_state14)) begin
                ap_enable_reg_pp1_iter1 <= (1'b1 ^ ap_condition_pp1_exit_iter0_state14);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp1_iter1 <= ap_enable_reg_pp1_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp1_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp1_stage0_subdone)) begin
            ap_enable_reg_pp1_iter2 <= ap_enable_reg_pp1_iter1;
        end else if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
            ap_enable_reg_pp1_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_reg_ioackin_a_ARREADY <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state1)) begin
            if (~((ap_sig_ioackin_a_ARREADY == 1'b0) | (ap_start == 1'b0))) begin
                ap_reg_ioackin_a_ARREADY <= 1'b0;
            end else if (((ap_start == 1'b1) & (1'b1 == a_ARREADY))) begin
                ap_reg_ioackin_a_ARREADY <= 1'b1;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_reg_ioackin_a_AWREADY <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
            if ((1'b0 == ap_block_state12_io)) begin
                ap_reg_ioackin_a_AWREADY <= 1'b0;
            end else if ((1'b1 == a_AWREADY)) begin
                ap_reg_ioackin_a_AWREADY <= 1'b1;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_reg_ioackin_a_WREADY <= 1'b0;
    end else begin
        if (((ap_enable_reg_pp1_iter2 == 1'b1) & (exitcond8_reg_245_pp1_iter1_reg == 1'd0))) begin
            if ((1'b0 == ap_block_pp1_stage0_11001)) begin
                ap_reg_ioackin_a_WREADY <= 1'b0;
            end else if (((1'b0 == ap_block_pp1_stage0_01001) & (1'b1 == a_WREADY))) begin
                ap_reg_ioackin_a_WREADY <= 1'b1;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state11)) begin
        i_reg_137 <= 4'd0;
    end else if ((1'b1 == ap_CS_fsm_state13)) begin
        i_reg_137 <= i_1_reg_235;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
        indvar6_reg_148 <= 4'd0;
    end else if (((1'b0 == ap_block_pp1_stage0_11001) & (ap_enable_reg_pp1_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0) & (exitcond8_fu_200_p2 == 1'd0))) begin
        indvar6_reg_148 <= indvar_next7_fu_206_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond1_reg_217 == 1'd0))) begin
        indvar_reg_125 <= indvar_next_reg_221;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        indvar_reg_125 <= 4'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond1_reg_217 == 1'd0))) begin
        a_read_reg_226 <= a_RDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd0))) begin
        buff_addr_1_reg_240 <= tmp_fu_188_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp1_stage0_11001) & (ap_enable_reg_pp1_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0) & (exitcond8_reg_245 == 1'd0))) begin
        buff_load_1_reg_259 <= buff_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        exitcond1_reg_217 <= exitcond1_fu_159_p2;
        exitcond1_reg_217_pp0_iter1_reg <= exitcond1_reg_217;
        indvar_reg_125_pp0_iter1_reg <= indvar_reg_125;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp1_stage0_11001) & (1'b1 == ap_CS_fsm_pp1_stage0))) begin
        exitcond8_reg_245 <= exitcond8_fu_200_p2;
        exitcond8_reg_245_pp1_iter1_reg <= exitcond8_reg_245;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12))) begin
        i_1_reg_235 <= i_1_fu_182_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
        indvar_next_reg_221 <= indvar_next_fu_165_p2;
    end
end

always @ (*) begin
    if (((ap_reg_ioackin_a_ARREADY == 1'b0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        a_ARVALID = 1'b1;
    end else begin
        a_ARVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_reg_ioackin_a_AWREADY == 1'b0) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
        a_AWVALID = 1'b1;
    end else begin
        a_AWVALID = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == a_BVALID) & (1'b1 == ap_CS_fsm_state21))) begin
        a_BREADY = 1'b1;
    end else begin
        a_BREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond1_reg_217 == 1'd0))) begin
        a_RREADY = 1'b1;
    end else begin
        a_RREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp1_stage0_01001) & (ap_reg_ioackin_a_WREADY == 1'b0) & (ap_enable_reg_pp1_iter2 == 1'b1) & (exitcond8_reg_245_pp1_iter1_reg == 1'd0))) begin
        a_WVALID = 1'b1;
    end else begin
        a_WVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        a_blk_n_AR = m_axi_a_ARREADY;
    end else begin
        a_blk_n_AR = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
        a_blk_n_AW = m_axi_a_AWREADY;
    end else begin
        a_blk_n_AW = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state21)) begin
        a_blk_n_B = m_axi_a_BVALID;
    end else begin
        a_blk_n_B = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond1_reg_217 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        a_blk_n_R = m_axi_a_RVALID;
    end else begin
        a_blk_n_R = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp1_iter2 == 1'b1) & (1'b0 == ap_block_pp1_stage0) & (exitcond8_reg_245_pp1_iter1_reg == 1'd0))) begin
        a_blk_n_W = m_axi_a_WREADY;
    end else begin
        a_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if ((exitcond1_fu_159_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state8 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state8 = 1'b0;
    end
end

always @ (*) begin
    if ((exitcond8_fu_200_p2 == 1'd1)) begin
        ap_condition_pp1_exit_iter0_state14 = 1'b1;
    end else begin
        ap_condition_pp1_exit_iter0_state14 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == a_BVALID) & (1'b1 == ap_CS_fsm_state21))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp1_iter1 == 1'b0) & (ap_enable_reg_pp1_iter0 == 1'b0) & (ap_enable_reg_pp1_iter2 == 1'b0))) begin
        ap_idle_pp1 = 1'b1;
    end else begin
        ap_idle_pp1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond1_reg_217 == 1'd0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_indvar_phi_fu_129_p4 = indvar_next_reg_221;
    end else begin
        ap_phi_mux_indvar_phi_fu_129_p4 = indvar_reg_125;
    end
end

always @ (*) begin
    if (((1'b1 == a_BVALID) & (1'b1 == ap_CS_fsm_state21))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((ap_reg_ioackin_a_ARREADY == 1'b0)) begin
        ap_sig_ioackin_a_ARREADY = a_ARREADY;
    end else begin
        ap_sig_ioackin_a_ARREADY = 1'b1;
    end
end

always @ (*) begin
    if ((ap_reg_ioackin_a_AWREADY == 1'b0)) begin
        ap_sig_ioackin_a_AWREADY = a_AWREADY;
    end else begin
        ap_sig_ioackin_a_AWREADY = 1'b1;
    end
end

always @ (*) begin
    if ((ap_reg_ioackin_a_WREADY == 1'b0)) begin
        ap_sig_ioackin_a_WREADY = a_WREADY;
    end else begin
        ap_sig_ioackin_a_WREADY = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp1_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0) & (1'b0 == ap_block_pp1_stage0))) begin
        buff_address0 = indvar1_fu_212_p1;
    end else if ((1'b1 == ap_CS_fsm_state13)) begin
        buff_address0 = buff_addr_1_reg_240;
    end else if ((1'b1 == ap_CS_fsm_state12)) begin
        buff_address0 = tmp_fu_188_p1;
    end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        buff_address0 = indvar2_fu_171_p1;
    end else begin
        buff_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state13) | ((1'b0 == ap_block_pp1_stage0_11001) & (ap_enable_reg_pp1_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp1_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12)))) begin
        buff_ce0 = 1'b1;
    end else begin
        buff_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state13)) begin
        buff_d0 = tmp_1_fu_193_p2;
    end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        buff_d0 = a_read_reg_226;
    end else begin
        buff_d0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state13) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (exitcond1_reg_217_pp0_iter1_reg == 1'd0)))) begin
        buff_we0 = 1'b1;
    end else begin
        buff_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_sig_ioackin_a_ARREADY == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (exitcond1_fu_159_p2 == 1'd1)) & ~((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (exitcond1_fu_159_p2 == 1'd1)))) begin
                ap_NS_fsm = ap_ST_fsm_state11;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            end else if (((1'b0 == ap_block_state12_io) & (1'b1 == ap_CS_fsm_state12) & (exitcond_fu_176_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state13;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state12;
            end
        end
        ap_ST_fsm_state13 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_pp1_stage0 : begin
            if ((~((1'b0 == ap_block_pp1_stage0_subdone) & (ap_enable_reg_pp1_iter1 == 1'b0) & (ap_enable_reg_pp1_iter0 == 1'b1) & (exitcond8_fu_200_p2 == 1'd1)) & ~((1'b0 == ap_block_pp1_stage0_subdone) & (ap_enable_reg_pp1_iter1 == 1'b0) & (ap_enable_reg_pp1_iter2 == 1'b1)))) begin
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            end else if ((((1'b0 == ap_block_pp1_stage0_subdone) & (ap_enable_reg_pp1_iter1 == 1'b0) & (ap_enable_reg_pp1_iter0 == 1'b1) & (exitcond8_fu_200_p2 == 1'd1)) | ((1'b0 == ap_block_pp1_stage0_subdone) & (ap_enable_reg_pp1_iter1 == 1'b0) & (ap_enable_reg_pp1_iter2 == 1'b1)))) begin
                ap_NS_fsm = ap_ST_fsm_state17;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp1_stage0;
            end
        end
        ap_ST_fsm_state17 : begin
            ap_NS_fsm = ap_ST_fsm_state18;
        end
        ap_ST_fsm_state18 : begin
            ap_NS_fsm = ap_ST_fsm_state19;
        end
        ap_ST_fsm_state19 : begin
            ap_NS_fsm = ap_ST_fsm_state20;
        end
        ap_ST_fsm_state20 : begin
            ap_NS_fsm = ap_ST_fsm_state21;
        end
        ap_ST_fsm_state21 : begin
            if (((1'b1 == a_BVALID) & (1'b1 == ap_CS_fsm_state21))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state21;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd7];

assign ap_CS_fsm_pp1_stage0 = ap_CS_fsm[32'd11];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state11 = ap_CS_fsm[32'd8];

assign ap_CS_fsm_state12 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state13 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_state21 = ap_CS_fsm[32'd16];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((1'b0 == a_RVALID) & (ap_enable_reg_pp0_iter1 == 1'b1) & (exitcond1_reg_217 == 1'd0));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((1'b0 == a_RVALID) & (ap_enable_reg_pp0_iter1 == 1'b1) & (exitcond1_reg_217 == 1'd0));
end

assign ap_block_pp1_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp1_stage0_01001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp1_stage0_11001 = ((1'b1 == ap_block_state16_io) & (ap_enable_reg_pp1_iter2 == 1'b1));
end

always @ (*) begin
    ap_block_pp1_stage0_subdone = ((1'b1 == ap_block_state16_io) & (ap_enable_reg_pp1_iter2 == 1'b1));
end

assign ap_block_state10_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state12_io = ((ap_sig_ioackin_a_AWREADY == 1'b0) & (exitcond_fu_176_p2 == 1'd1));
end

assign ap_block_state14_pp1_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp1_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state16_io = ((ap_sig_ioackin_a_WREADY == 1'b0) & (exitcond8_reg_245_pp1_iter1_reg == 1'd0));
end

assign ap_block_state16_pp1_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state9_pp0_stage0_iter1 = ((1'b0 == a_RVALID) & (exitcond1_reg_217 == 1'd0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_pp1 = (ap_idle_pp1 ^ 1'b1);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign exitcond1_fu_159_p2 = ((ap_phi_mux_indvar_phi_fu_129_p4 == 4'd10) ? 1'b1 : 1'b0);

assign exitcond8_fu_200_p2 = ((indvar6_reg_148 == 4'd10) ? 1'b1 : 1'b0);

assign exitcond_fu_176_p2 = ((i_reg_137 == 4'd10) ? 1'b1 : 1'b0);

assign i_1_fu_182_p2 = (i_reg_137 + 4'd1);

assign indvar1_fu_212_p1 = indvar6_reg_148;

assign indvar2_fu_171_p1 = indvar_reg_125_pp0_iter1_reg;

assign indvar_next7_fu_206_p2 = (indvar6_reg_148 + 4'd1);

assign indvar_next_fu_165_p2 = (ap_phi_mux_indvar_phi_fu_129_p4 + 4'd1);

assign tmp_1_fu_193_p2 = (buff_q0 + 32'd100);

assign tmp_fu_188_p1 = i_reg_137;

endmodule //example