`timescale 1 ns / 1 ps

module asyn_fifo #
(
    parameter integer DATA_BITS	= 10,
    parameter integer FIFO_LENGTH	= 16,
	parameter ADDR_BIT = $clog2(FIFO_LENGTH),
    
    parameter RESET_VALUE = 0
)
(

    `ifdef UVM_SIM //use uvm interface
    des_if.rtl rtl_interface
    `else //use common interface
    asyn_fifo_interface.rtl rtl_interface
    `endif

);
    
    //wire
    wire empty_val,full_val;
	wire [ADDR_BIT:0] rgreynext, rbinnext, wgreynext, wbinnext;

    //reg
	reg [DATA_BITS - 1 : 0] data_array[FIFO_LENGTH - 1: 0];
	//reg flap;
	reg [ADDR_BIT - 1:0] write_addr;
	reg [ADDR_BIT - 1:0] read_addr;
	
    reg [ADDR_BIT:0] wptr, rptr, wq2_rptr, rq2_wptr, wq1_rptr, rq1_wptr;
    reg [ADDR_BIT:0] rbin, wbin; 
	


    //assign
	assign rtl_interface.output_data = data_array[read_addr];

    //read counter and empty_val 
    //{{{
	assign rbinnext = rbin + (rtl_interface.read & ~rtl_interface.empty);
	    //rbinnext 就是真正的read_addr的二进制计数器，每有read操作rbinnext加一
	assign read_addr = rbin[ADDR_BIT - 1 : 0];
	    //read_addr就是rbin的后ADDR_BIT 位，直接对应输出数据
	assign empty_val = (rgreynext == rq2_wptr);
    //}}}

    //write counter and full_val
    //{{{
	assign wbinnext = wbin + (rtl_interface.write & ~rtl_interface.full);
        //wbinnext 就是真正的waddr的二进制计数器，每有write操作wbinnext加一
	assign write_addr = wbin[ADDR_BIT - 1 : 0];
        //write_addr 就是rbin的后ADDR_BIT 位, 是data_array的写标
	assign full_val = (wgreynext=={~wq2_rptr[ADDR_BIT : ADDR_BIT - 1], wq2_rptr[ADDR_BIT - 2 : 0]}); //:ASIZE-1]
        //full_val 的判断和empty_val的判断方式不一样
        //full_val的判断是wgreynext 前两位要等于wq2_rptr的前两位取反
            //具体为什么现在还不确定
            //大致猜测是，wq2_rptr 是从read端传过来的，大概grey码的计数法就是高两位不同其实就是这两个数其实差1，而差1就意味着full了，
    //}}}
    

    //write 格雷码计数器
    //{{{
	    //assign wgreynext = (wbinnext>>1) ^ wbinnext;
            //wgreynext就是wbinnext的格雷码计数器
    grey_converter #(
        .DATA_BIT(ADDR_BIT)
    ) wgrey_conv (
        .bin_input (wbinnext),
        .grey_output (wgreynext)
    ); 
    //}}}
    
    //read 格雷码计数器
    //{{{
	    //assign rgreynext = (rbinnext>>1) ^ rbinnext;
	        //rgreynext就是rbinnext的格雷码计数器
    grey_converter #(
        .DATA_BIT(ADDR_BIT)
    ) rgrey_conv (
        .bin_input (rbinnext),
        .grey_output (rgreynext)
    ); 
    //}}}

//data_array 
//{{{
always@(posedge rtl_interface.w_clk) begin
    if (rtl_interface.write == 1 && rtl_interface.full != 1) begin
        data_array[write_addr] <= rtl_interface.input_data;
    end
end 
//}}}

//wq2, wq1_rptr
//使用两层buffer，用两个w_clk与rptr同步
//wq_rptr 用来判断是否full
//{{{
always@(posedge rtl_interface.w_clk) begin
	if (rtl_interface.w_reset == RESET_VALUE) begin
        wq2_rptr <= 0;
        wq1_rptr <= 0;
    end 
    else begin
        wq2_rptr <= wq1_rptr;
        wq1_rptr <= rptr;
    end
end
//}}}

//rq2, rq1_wptr
//使用两层buffer，用两个r_clk与wptr同步
//{{{
always@(posedge rtl_interface.r_clk) begin
	if (rtl_interface.r_reset == RESET_VALUE) begin
        rq2_wptr <= 0;
        rq1_wptr <= 0;
    end 
    else begin
        rq2_wptr <= rq1_wptr;
        rq1_wptr <= wptr;
    end
end
//}}}

//rbin 和 rptr
//rbin 是read_addr和read端的flap
//rptr 是格雷码格式的read地址下标，通过两层buffer与wq2_rptr 同步，用来判断是否full
//{{{
always@(posedge rtl_interface.r_clk) begin
	if (rtl_interface.r_reset == RESET_VALUE) begin
        rbin <= 0;
        rptr <= 0; 
    end
    else begin
        rbin <= rbinnext;
        rptr <= rgreynext;
    end
end
//}}}    

//empty
//{{{
always@(posedge rtl_interface.r_clk) begin
	if (rtl_interface.r_reset == RESET_VALUE) begin
        rtl_interface.empty <= 1;
    end
    else begin
        rtl_interface.empty <= empty_val;
    end
end
//}}}


//wbin 和 wptr
//wbin 是write_addr和write端的flap
//wptr 是格雷码格式的write地址下标，通过两层buffer与rq2_wptr 同步，用来判断是否empty
//{{{
always@(posedge rtl_interface.w_clk) begin
	if (rtl_interface.w_reset == RESET_VALUE) begin
        wbin <= 0;
        wptr <= 0; 
    end
    else begin
        wbin <= wbinnext;
        wptr <= wgreynext;
    end
end
//}}}    

//empty
//{{{
always@(posedge rtl_interface.w_clk) begin
	if (rtl_interface.w_reset == RESET_VALUE) begin
        rtl_interface.full <= 1;
    end
    else begin
        rtl_interface.full <= full_val;
    end
end
//}}}

endmodule



