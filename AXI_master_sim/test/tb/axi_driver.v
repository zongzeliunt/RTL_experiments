`timescale 1 ns / 1 ps

module AESL_axi_slave (
    clk,
    reset,
	//AW: write request
	//{{{
    TRAN_AWVALID,
    TRAN_AWREADY,
    TRAN_AWADDR,
    TRAN_AWID,
    TRAN_AWLEN,
    TRAN_AWSIZE,
    TRAN_AWBURST,
    TRAN_AWLOCK,
    TRAN_AWCACHE,
    TRAN_AWPROT,
    TRAN_AWQOS,
    TRAN_AWREGION,
    TRAN_AWUSER,
   	//}}}

	//W: write data
	//{{{ 
	TRAN_WVALID,
    TRAN_WREADY,
    TRAN_WDATA,
    TRAN_WSTRB,
    TRAN_WLAST,
    TRAN_WID,
    TRAN_WUSER,
    //}}}

	//AR: read request
	//{{{
	TRAN_ARVALID,
    TRAN_ARREADY,
    TRAN_ARADDR,
    TRAN_ARID,
    TRAN_ARLEN,
    TRAN_ARSIZE,
    TRAN_ARBURST,
    TRAN_ARLOCK,
    TRAN_ARCACHE,
    TRAN_ARPROT,
    TRAN_ARQOS,
    TRAN_ARREGION,
    TRAN_ARUSER,
    //}}}

	//R: read data
	//{{{
	TRAN_RVALID,
    TRAN_RREADY,
    TRAN_RDATA,
    TRAN_RLAST,
    TRAN_RID,
    TRAN_RUSER,
    TRAN_RRESP,
    //}}}

	//B
	//{{{
	TRAN_BVALID,
    TRAN_BREADY,
    TRAN_BRESP,
    TRAN_BID,
    TRAN_BUSER,
	//}}}
    ready,
    done
    );

//------------------------Parameter----------------------
parameter ADDR_BITWIDTH = 32'd 32;
parameter AWUSER_BITWIDTH = 32'd 1;
parameter WUSER_BITWIDTH = 32'd 1;
parameter RUSER_BITWIDTH = 32'd 1;
parameter BUSER_BITWIDTH = 32'd 1;

parameter DATA_BITWIDTH = 32'd 32;
parameter ID_BITWIDTH = 32'd 1;
parameter MEM_DEPTH = 32'd 10;
	
parameter RESET_VALUE = 0;

// Input and Output
input clk;
input reset;

//AW
//{{{
input  TRAN_AWVALID;
output  TRAN_AWREADY;
input [ADDR_BITWIDTH - 1 : 0] TRAN_AWADDR;
input [ID_BITWIDTH - 1 : 0] TRAN_AWID;
input [8 - 1 : 0] TRAN_AWLEN;
input [3 - 1 : 0] TRAN_AWSIZE;
input [2 - 1 : 0] TRAN_AWBURST;
input [2 - 1 : 0] TRAN_AWLOCK;
input [4 - 1 : 0] TRAN_AWCACHE;
input [3 - 1 : 0] TRAN_AWPROT;
input [4 - 1 : 0] TRAN_AWQOS;
input [4 - 1 : 0] TRAN_AWREGION;
input [AWUSER_BITWIDTH - 1 : 0] TRAN_AWUSER;
//}}}

//W
//{{{
input  TRAN_WVALID;
output  TRAN_WREADY;
input [DATA_BITWIDTH - 1 : 0] TRAN_WDATA;
input [DATA_BITWIDTH/8 - 1 : 0] TRAN_WSTRB;
input  TRAN_WLAST;
input  TRAN_WID;
input [WUSER_BITWIDTH - 1 : 0] TRAN_WUSER;

reg TRAN_WREADY;
reg [31:0] W_count;

//完全从AR fifo复制
reg W_run;
reg [ADDR_BITWIDTH - 1 : 0] AW_ADDR_tmp;
reg [ID_BITWIDTH - 1 : 0] AW_ID_tmp;
reg [8 - 1 : 0] AW_LEN_tmp;
reg [3 - 1 : 0] AW_SIZE_tmp;
reg [2 - 1 : 0] AW_BURST_tmp;
integer 		AW_SIZE_tmp_i;
integer			AW_SIZE_real;
//}}}

//AR
//{{{
input  TRAN_ARVALID;
output  TRAN_ARREADY;
input [ADDR_BITWIDTH - 1 : 0] TRAN_ARADDR;
input [ID_BITWIDTH - 1 : 0] TRAN_ARID;
input [8 - 1 : 0] TRAN_ARLEN;
input [3 - 1 : 0] TRAN_ARSIZE;
input [2 - 1 : 0] TRAN_ARBURST;
input [2 - 1 : 0] TRAN_ARLOCK;
input [4 - 1 : 0] TRAN_ARCACHE;
input [3 - 1 : 0] TRAN_ARPROT;
input [4 - 1 : 0] TRAN_ARQOS;
input [4 - 1 : 0] TRAN_ARREGION;
input  TRAN_ARUSER;
//}}}

//R
//{{{
output  TRAN_RVALID;
input  TRAN_RREADY;
output [DATA_BITWIDTH - 1 : 0] TRAN_RDATA;
output  TRAN_RLAST;
output [ID_BITWIDTH - 1 : 0] TRAN_RID;
output [RUSER_BITWIDTH - 1 : 0] TRAN_RUSER;
output [2 - 1 : 0] TRAN_RRESP;

reg TRAN_RVALID;
reg [DATA_BITWIDTH - 1 : 0] TRAN_RDATA;
reg TRAN_RLAST;
reg [ID_BITWIDTH - 1 : 0] TRAN_RID;
reg [2 - 1 : 0] TRAN_RRESP;
reg [31:0] R_count;

//第一种写方式不需要请求寄存器
//第二种写方式要搞一套请求寄存器
reg R_run;
reg [ADDR_BITWIDTH - 1 : 0] AR_ADDR_tmp;
reg [ID_BITWIDTH - 1 : 0] AR_ID_tmp;
reg [8 - 1 : 0] AR_LEN_tmp;
reg [3 - 1 : 0] AR_SIZE_tmp;
reg [2 - 1 : 0] AR_BURST_tmp;
integer 		AR_SIZE_tmp_i;
integer			AR_SIZE_real;
//}}}

//B
//{{{
output  TRAN_BVALID;
input  TRAN_BREADY;
output [2 - 1 : 0] TRAN_BRESP;
output [ID_BITWIDTH - 1 : 0] TRAN_BID;
output [BUSER_BITWIDTH - 1 : 0] TRAN_BUSER;


reg TRAN_BVALID;
reg W_REQ_DONE;
reg [ID_BITWIDTH - 1 : 0] W_REQ_DONE_ID;
reg [2 - 1 : 0] TRAN_BRESP;
reg [ID_BITWIDTH - 1 : 0] TRAN_BID;
reg [BUSER_BITWIDTH - 1 : 0] TRAN_BUSER;




//}}}
input ready;
input done;

//data declare 
reg [ADDR_BITWIDTH - 1 : 0] data[MEM_DEPTH - 1 : 0];
integer data_i;

//AW_fifo
//{{{
wire [ADDR_BITWIDTH - 1 : 0] AW_fifo_ADDR_i;
wire [ID_BITWIDTH - 1 : 0] AW_fifo_ID_i;
wire [8 - 1 : 0] AW_fifo_LEN_i;
wire [3 - 1 : 0] AW_fifo_SIZE_i;
wire [2 - 1 : 0] AW_fifo_BURST_i;

wire [ADDR_BITWIDTH - 1 : 0] AW_fifo_ADDR_o;
wire [ID_BITWIDTH - 1 : 0] AW_fifo_ID_o;
wire [8 - 1 : 0] AW_fifo_LEN_o;
wire [3 - 1 : 0] AW_fifo_SIZE_o;
wire [2 - 1 : 0] AW_fifo_BURST_o;

reg AW_fifo_read;
wire AW_fifo_write;
wire AW_fifo_empty;
wire AW_fifo_full;

assign TRAN_AWREADY    =    ~AW_fifo_full; 
assign AW_fifo_write = TRAN_AWVALID;
assign AW_fifo_ADDR_i = TRAN_AWADDR;
assign AW_fifo_ID_i = TRAN_AWID;
assign AW_fifo_LEN_i = TRAN_AWLEN;
assign AW_fifo_SIZE_i = TRAN_AWSIZE;
assign AW_fifo_BURST_i = TRAN_AWBURST;

axi_fifo  #(
	.ADDR_BITWIDTH(ADDR_BITWIDTH),
	.ID_BITWIDTH(ID_BITWIDTH),
	.RESET_VALUE(RESET_VALUE)
	) AW_fifo
	(
		.clk(clk),
		.reset(reset),

		.ADDR_i(AW_fifo_ADDR_i),
		.ID_i(AW_fifo_ID_i),
		.LEN_i(AW_fifo_LEN_i),
		.SIZE_i(AW_fifo_SIZE_i),
		.BURST_i(AW_fifo_BURST_i),
		 
		.ADDR_o(AW_fifo_ADDR_o),
		.ID_o(AW_fifo_ID_o),
		.LEN_o(AW_fifo_LEN_o),
		.SIZE_o(AW_fifo_SIZE_o),
		.BURST_o(AW_fifo_BURST_o),

		
		.read(AW_fifo_read),
		.write(AW_fifo_write),
		.empty(AW_fifo_empty),
		.full(AW_fifo_full)
	);
//}}}

//AR_fifo
//{{{
wire [ADDR_BITWIDTH - 1 : 0] AR_fifo_ADDR_i;
wire [ID_BITWIDTH - 1 : 0] AR_fifo_ID_i;
wire [8 - 1 : 0] AR_fifo_LEN_i;
wire [3 - 1 : 0] AR_fifo_SIZE_i;
wire [2 - 1 : 0] AR_fifo_BURST_i;

wire [ADDR_BITWIDTH - 1 : 0] AR_fifo_ADDR_o;
wire [ID_BITWIDTH - 1 : 0] AR_fifo_ID_o;
wire [8 - 1 : 0] AR_fifo_LEN_o;
wire [3 - 1 : 0] AR_fifo_SIZE_o;
wire [2 - 1 : 0] AR_fifo_BURST_o;

reg AR_fifo_read;
wire AR_fifo_write;
wire AR_fifo_empty;
wire AR_fifo_full;

assign TRAN_ARREADY    =    ~AR_fifo_full; 
assign AR_fifo_write = TRAN_ARVALID;
assign AR_fifo_ADDR_i = TRAN_ARADDR;
assign AR_fifo_ID_i = TRAN_ARID;
assign AR_fifo_LEN_i = TRAN_ARLEN;
assign AR_fifo_SIZE_i = TRAN_ARSIZE;
assign AR_fifo_BURST_i = TRAN_ARBURST;

axi_fifo  #(
	.ADDR_BITWIDTH(ADDR_BITWIDTH),
	.RESET_VALUE(RESET_VALUE)
	) AR_fifo
	(
		.clk(clk),
		.reset(reset),

		.ADDR_i(AR_fifo_ADDR_i),
		.ID_i(AR_fifo_ID_i),
		.LEN_i(AR_fifo_LEN_i),
		.SIZE_i(AR_fifo_SIZE_i),
		.BURST_i(AR_fifo_BURST_i),
		 
		.ADDR_o(AR_fifo_ADDR_o),
		.ID_o(AR_fifo_ID_o),
		.LEN_o(AR_fifo_LEN_o),
		.SIZE_o(AR_fifo_SIZE_o),
		.BURST_o(AR_fifo_BURST_o),

		.read(AR_fifo_read),
		.write(AR_fifo_write),
		.empty(AR_fifo_empty),
		.full(AR_fifo_full)
	);
//}}}

//data initialize
//这是一个语法问题，对一段数据的写操作必须由同一套信号驱动，但是没必要写在一个进程里。所以data的初始化可以写在这里，W操作可以写在W进程里，两个进程由于驱动信号不同所以不会有冲突
//{{{
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		for (data_i = 0; data_i < MEM_DEPTH; data_i = data_i + 1) begin
			data[data_i] = data_i * 2;
		end
	end
end
//}}}

//R and AR_fifo read
//{{{
//第一种模式，读请求一直放在fifo里，不写完了fifo不read，理论上说这种方法其实不安全
//{{{
/*
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		TRAN_RVALID <= 0;
		TRAN_RDATA <= 0;
		TRAN_RLAST <= 0;
		TRAN_RID <= 0;
		TRAN_RRESP <= 0;
		R_count <= 0;
		AR_fifo_read <= 0;	
	end
	else begin
		//这里是非阻塞赋值，以下三个信号默认都是0，什么时候该成1里面有条件
		AR_fifo_read <= 0;
		TRAN_RVALID <= 0;
		TRAN_RLAST <= 0;
		TRAN_RDATA <= 0;
		if (AR_fifo_empty == 0 && AR_fifo_BURST_o == 1) begin 
			//这里处理burst 模式
			if (TRAN_RREADY == 1) begin	
				AR_SIZE_real = 1;
				for (AR_SIZE_tmp_i = 0; AR_SIZE_tmp_i < AR_SIZE_tmp; AR_SIZE_tmp_i = AR_SIZE_tmp_i + 1 ) begin
					AR_SIZE_real = AR_SIZE_real * 2;
				end

				if (TRAN_RVALID == 1 ) begin
					//上一拍写出去的数据在本拍被master吃了
					if (R_count != AR_fifo_LEN_o) begin
						//现地址不是最后一个数据，写下一个地址的数据
						TRAN_RDATA <= data[AR_fifo_ADDR_o / AR_SIZE_real + R_count + 1];
						TRAN_RVALID <= 1;
						TRAN_RID <= AR_fifo_ID_o;
						if (R_count == AR_fifo_LEN_o - 1) begin
							//下一拍要写最后一个数，last要拉高
							TRAN_RLAST <= 1;
						end
						R_count <= R_count + 1;
					end
					else begin
						//R_count == AR_fifo_LEN_o，且RVALID == 1
						//说明所有该写的数都被master吃了，这里要有一个数据全拿完了的 AR_fifo read操作
						AR_fifo_read <= 1;
						R_count <= 0;
					end
				end
				else begin
					if (AR_fifo_read == 1) begin
						//这里有一个问题，数据全被master拿完，要留一拍取走AR_fifo的最顶上的request，这就造成了在这一拍AR_fifo_read为1但是AR_fifo没变成空，于是如果不留这个分支，会吧R_count = 0的数又写一次
						//所以在这里要留一个判断，如果这一拍AR_fifo不是空，但是要读AR_fifo,那么就不再写任何东西了
						TRAN_RVALID <= 0;	
					end
					else begin
						//上一拍数据没吃
						TRAN_RDATA <= data[AR_fifo_ADDR_o / AR_SIZE_real + R_count];
						TRAN_RVALID <= 1;
						TRAN_RID <= AR_fifo_ID_o;
						if (R_count == AR_fifo_LEN_o) begin
							//下一拍要写最后一个数，last要拉高
							TRAN_RLAST <= 1;
						end
					end
				end
			end
		end
	end
end
*/
//}}}

//第二种模式是如果AR_fifo不空，就先把请求读出来，放在一套寄存器里，用一个模式状态机控制此时是不是进行写操作，理论上安全一点，但是要浪费一套寄存器
//用R_run这个信号来控制要不要写，R_run先拉一拍，写操作进程做看到R_run高了，开始写东西。
//当写进程全写完，R_run同步变低。fifo读进程看到R_run低了，就会读下一个fifo request。所以说每两套写操作中间有一拍的延迟。这样就安全了。
//AR_fifo read
//{{{
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		AR_ADDR_tmp		<= 0;
		AR_ID_tmp		<= 0;
		AR_LEN_tmp		<= 0;
		AR_SIZE_tmp		<= 0;
		AR_BURST_tmp	<= 0;
		AR_fifo_read <= 0;
		R_run <= 0;
	end
	else begin
		//fifo_read 默认为0
		AR_fifo_read <= 0;
		if (R_run == 0 ) begin
			//R_run为一个分支
			if ( AR_fifo_empty == 0) begin
				//用empty来判断要不要读	
				AR_fifo_read <= 1;
				AR_ADDR_tmp		<= AR_fifo_ADDR_o;
				AR_ID_tmp		<= AR_fifo_ID_o;
				AR_LEN_tmp		<= AR_fifo_LEN_o;
				AR_SIZE_tmp		<= AR_fifo_SIZE_o;
				AR_BURST_tmp	<= AR_fifo_BURST_o;
				R_run <= 1;
			end
		end
		else begin
			//这就是R_run为1的分支	
			if (TRAN_RREADY == 1 && TRAN_RVALID == 1 && R_count == AR_LEN_tmp) begin
				//最后一个数（R_count == AR_LEN_tmp）被读走了，R_run要变0
				//我不能用RLAST来判断，因为就算我这边拉了RLAST，master也未必吃。我不能把所有的希望都寄托在master肯定会吃这件事上，master要是真能依靠也用不着握手协议了。
				R_run <= 0;
			end		

		end
	end
end
//}}}

//R
//{{{
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		TRAN_RVALID <= 0;
		TRAN_RDATA <= 0;
		TRAN_RLAST <= 0;
		TRAN_RID <= 0;
		TRAN_RRESP <= 0;
		R_count <= 0;
	end
	else begin
		//这里是非阻塞赋值，以下三个信号默认都是0，什么时候该成1里面有条件
		TRAN_RVALID <= 0;
		TRAN_RLAST <= 0;
		TRAN_RDATA <= 0;
		if (R_run == 1 && AR_BURST_tmp == 1) begin 
			if (TRAN_RREADY == 1) begin
				AR_SIZE_real = 1;
				for (AR_SIZE_tmp_i = 0; AR_SIZE_tmp_i < AR_SIZE_tmp; AR_SIZE_tmp_i = AR_SIZE_tmp_i + 1 ) begin
					AR_SIZE_real = AR_SIZE_real * 2;
				end

				if (TRAN_RVALID == 1 ) begin
					//上一拍写出去的数据在本拍被master吃了
					if (R_count != AR_LEN_tmp) begin
						//现地址不是最后一个数据，写下一个地址的数据
						TRAN_RDATA <= data[AR_ADDR_tmp / AR_SIZE_real + R_count + 1];
						TRAN_RVALID <= 1;
						TRAN_RID <= AR_ID_tmp;
						if (R_count == AR_LEN_tmp - 1) begin
							//下一拍要写最后一个数，last要拉高
							TRAN_RLAST <= 1;
						end
						R_count <= R_count + 1;
					end
					else begin
						//R_count == AR_LEN_tmp，且RVALID == 1
						//说明所有该写的数都被master吃了,在这里就是R_count清0,在fifo那端就是R_run变0
						R_count <= 0;
					end
				end
				else begin
					//上一拍数据没吃
					TRAN_RDATA <= data[AR_ADDR_tmp / AR_SIZE_real + R_count];
					TRAN_RVALID <= 1;
					TRAN_RID <= AR_ID_tmp;
					if (R_count == AR_LEN_tmp) begin
						//下一拍要写最后一个数，last要拉高
						TRAN_RLAST <= 1;
					end
				end
			end
		end
	end
end
//}}}

//}}}


//W and AW_fifo read
//{{{
//第一种模式，写请求放在fifo里






//第二种模式，使用类似AR的请求寄存器模式
//AW_fifo read
//{{{
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		AW_ADDR_tmp		<= 0;
		AW_ID_tmp		<= 0;
		AW_LEN_tmp		<= 0;
		AW_SIZE_tmp		<= 0;
		AW_BURST_tmp	<= 0;
		AW_fifo_read <= 0;
		W_run <= 0;
	end
	else begin
		//fifo_read 默认为0
		AW_fifo_read <= 0;
		if (W_run == 0 ) begin
			if ( AW_fifo_empty == 0) begin
				//用empty来判断要不要读	
				AW_fifo_read <= 1;
				AW_ADDR_tmp		<= AW_fifo_ADDR_o;
				AW_ID_tmp		<= AW_fifo_ID_o;
				AW_LEN_tmp		<= AW_fifo_LEN_o;
				AW_SIZE_tmp		<= AW_fifo_SIZE_o;
				AW_BURST_tmp	<= AW_fifo_BURST_o;
				W_run <= 1;
			end
		end
		else begin
			//用两种方式判断最后一个数
			if (TRAN_WREADY == 1 && TRAN_WVALID == 1 && W_count == AW_LEN_tmp) begin
				W_run <= 0;
			end	
			/*	
			if (TRAN_WREADY == 1 && TRAN_WVALID == 1 && TRAN_WLAST == 1) begin
				W_run <= 0;
			end	
			*/	
		end
	end
end
//}}}

//W
//{{{
//第一种模式，ready一直为低，来valid了再拉高，代表我可以吃数
//但是！具体能不能改变mem的数据，还要看是不是valid和ready同时为1,这一点很重要，可以防止看见valid为高就不分青红枣白之间拿数据，ready下一拍才起，master那端不换数据，我这边又拿一个一模一样的。但是我这边的下标却变了，于是0位和1位都被写成了一样的数据
//{{{
/*
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin
		TRAN_WREADY <= 1;
		W_count <= 0;
	end
	else begin 
		TRAN_WREADY <= 0;
		if (W_run == 1 && AW_BURST_tmp == 1) begin
			AW_SIZE_real = 1;
			for (AW_SIZE_tmp_i = 0; AW_SIZE_tmp_i < AW_SIZE_tmp; AW_SIZE_tmp_i = AW_SIZE_tmp_i + 1) begin
				AW_SIZE_real = AW_SIZE_real * 2;
			end
			if (TRAN_WVALID == 1) begin
				TRAN_WREADY <= 1;
				//看见valid了我再起ready
				if (TRAN_WREADY == 1) begin
					//因为上一拍起了ready，所以这一拍才写memory
					data[AW_ADDR_tmp / AW_SIZE_tmp_i + W_count] <= TRAN_WDATA;
					TRAN_WREADY <= 1;

					//这里也有两种方式判断最后一个数，要么用W_count和AW_LEN_tmp比，要么看WLAST
					if (TRAN_WLAST == 1) begin
						W_count <= 0;
					end
					else begin
						W_count <= W_count + 1;
					end
				end
			end
		end 
	end
end
*/
//}}}

//第二种模式，ready一直为高，发现valid和ready都为高时马上写memory和改地址
//这种方式要求我这一端永远保持准备，因为master端发request以后一拍以后就发数据，如果我这边不准备好，就会错过数据！
//个人认为这种不安全，要么我得有READY变0的条件。要么我就用上边的方案。不存在所谓的永远ready的方式。
//其实也可以用一个fifo当buffer看具体情况
//{{{

always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		TRAN_WREADY <= 1;
		W_count <= 0;
	end
	else begin
		if (W_run == 1 && AW_BURST_tmp == 1) begin
			AW_SIZE_real = 1;
			for (AW_SIZE_tmp_i = 0; AW_SIZE_tmp_i < AW_SIZE_tmp; AW_SIZE_tmp_i = AW_SIZE_tmp_i + 1) begin
				AW_SIZE_real = AW_SIZE_real * 2;
			end
			if (TRAN_WVALID == 1 && TRAN_WREADY == 1) begin
				data[AW_ADDR_tmp / AW_SIZE_real + W_count] <= TRAN_WDATA;
				TRAN_WREADY <= 1;
				//这里也有两种方式判断最后一个数，要么用W_count和AW_LEN_tmp比，要么看WLAST
				if (TRAN_WLAST == 1) begin
					W_count <= 0;
				end
				else begin
					W_count <= W_count + 1;
				end
			end
		end 
	end
end
//}}}
//}}}
//}}}

//B
//B的作用是master给我写完一遍以后，我看见BREADY为1时就起一拍BVALID，说明一个request我处理完了，master就可以再给我发一个新request
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		TRAN_BVALID <= 0;
		TRAN_BRESP <= 0;
		TRAN_BID <= 0;
		TRAN_BUSER <= 0;
	end
	else begin
		TRAN_BVALID <= 0;
		TRAN_BID <= 0;
		if (W_REQ_DONE == 1 && TRAN_BREADY == 1) begin
			TRAN_BVALID <= 1;
			TRAN_BID <= W_REQ_DONE_ID;
		end
	end
end

//W_REQ_DONE 是一个比较重要的东西
//master要写给我的东西我写完了，我要用W_REQ_DONE来在我内部证明写操作结束
//W_REQ_DONE的拉高条件和W_run的拉低条件是一样的，所以我可以在W_run为1时通过一个条件来拉高W_REQ_DONE
//在W_run为低时，只要看到TRAN_BREADY为1,就写B_VALID，并且置W_REQ_DONE为0
//W_REQ_DONE_ID 用来保存完成的那个AW的ID
always @ (posedge clk) begin 
    if(reset === RESET_VALUE) begin 
		W_REQ_DONE <= 0;
		W_REQ_DONE_ID <= 0;
	end
	else begin
		if (W_run == 1) begin
			if (TRAN_WVALID == 1 && TRAN_WREADY == 1 && TRAN_WLAST == 1) begin
				W_REQ_DONE <= 1;
				W_REQ_DONE_ID <= AW_ID_tmp;
			end
		end
		else begin
			if (W_REQ_DONE == 1 && TRAN_BREADY == 1) begin
				W_REQ_DONE <= 0;
				W_REQ_DONE_ID <= 0;
			end
		end
	end
end


endmodule
