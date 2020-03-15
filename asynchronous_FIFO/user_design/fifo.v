/*
	ASIZE 是地址下标的宽度，而和格雷码相关的那些寄存器都是比地址多一位（ASIZE + 1）
	真正的mem长度是 [(1<<ASIZE - 1) : 0], 即1左移动ASIZE位，右端补0,再减1
		如ASIZE = 4, mem宽 1<<4 = 16。 4位地址可以表示16个地址
		再如ASIZE = 6, mem 宽 1<<6 = 100000 = 64。 6位地址可以表示64个地址
	




*/

module asyn_fifo(rdata, empty, read, rclk, rrst, wdata, full, write, wclk, wrst );
	parameter DSIZE = 8; 
	parameter ASIZE = 4;
	parameter RESET_VALUE = 1;
	output [DSIZE-1:0] rdata;
	output full;
	output empty;
	input [DSIZE-1:0] wdata;
	input write, wclk, wrst;
	input read, rclk, rrst;
	reg full,empty;
	//除了waddr 和raddr是ASIZE位，其他都要是ASIZE+1位！
	reg [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr, wq1_rptr,rq1_wptr;
	reg [ASIZE:0] rbin, wbin;
	reg [DSIZE-1:0] mem[0:(1<<ASIZE)-1];
	wire [ASIZE-1:0] waddr, raddr;
	wire [ASIZE:0] rgraynext, rbinnext,wgraynext,wbinnext;
	wire empty_val,full_val;

//mem 寄存器
	assign rdata = mem[raddr];
	always @(posedge wclk)
		if (!full && write) 
			mem[waddr] <= wdata;

//wq2_rptr 通过两层buffer，用两个cycle 与rptr同步
//always @(posedge wclk or posedge wrst)
	always @(posedge wclk) begin
		if (wrst == RESET_VALUE) begin
			wq2_rptr <= 0;
			wq1_rptr <= 0; 
		end
		else begin
			wq2_rptr <= wq1_rptr;
			wq1_rptr <= rptr;
		end
	end

//rq2_wptr 通过两层buffer，用两个cycle 与wptr同步
	//always @(posedge rclk or posedge rrst)
	always @(posedge rclk) begin
		if (rrst == RESET_VALUE) begin
			rq2_wptr <= 0;
			rq1_wptr <= 0; 
		end
		else begin
			rq2_wptr <= rq1_wptr;
			rq1_wptr <= wptr;
		end
	end

//产生empty 和 raddr
	//rptr 是格雷码格式的read地址下标，通过两层buffer与wq2_rptr 同步，用来判断是否empty
	//rbin 是二进制类型的地址下标，用来储存mem的读地址
	//always @(posedge rclk or posedge rrst) // GRAYSTYLE2 pointer
	always @(posedge rclk) begin// GRAYSTYLE2 pointer
		if (rrst == RESET_VALUE) begin
			rbin <= 0;
			rptr <= 0;
		end
		else begin 
			rbin <= rbinnext;
			rptr <= rgraynext;
		end
	end
	
	//rbinnext 就是真正的raddr的二进制计数器，每有read操作rbinnext加一
	assign rbinnext = rbin + (read & ~empty);
	//rgraynext就是rbinnext的格雷码计数器
	assign rgraynext = (rbinnext>>1) ^ rbinnext;
	//raddr就是rbin的后ASIZE位，直接对应输出数据
	assign raddr = rbin[ASIZE-1:0];

	// FIFO empty when the next rptr == synchronized wptr or on reset
	assign empty_val = (rgraynext == rq2_wptr);
	//always @(posedge rclk or posedge rrst)
	always @(posedge rclk)
		if (rrst == RESET_VALUE) empty <= 1'b1;
		else empty <= empty_val;

//产生full 和 waddr 
	//wptr 是格雷码格式的write地址下标，通过两层buffer与rq2_wptr 同步，用来判断是否full
	//wbin 是二进制类型的地址下标，用来储存mem的写地址

	always @(posedge wclk) begin // GRAYSTYLE2 pointer
		if (wrst == RESET_VALUE) begin
			wbin <= 0;
			wptr <= 0;
		end
		else begin 
			wbin <= wbinnext;
			wptr <= wgraynext;
		end
	end
	
	
	//wbinnext 就是真正的waddr的二进制计数器，每有write操作wbinnext加一
	assign wbinnext = wbin + (write & ~full);
	//wgraynext就是wbinnext的格雷码计数器
	assign wgraynext = (wbinnext>>1) ^ wbinnext;
	//waddr 是mem的写标，wbin的后四位
	assign waddr = wbin[ASIZE-1:0];
	//full_val 的判断和empty_val的判断方式不一样
	//empty_val的判断是rgraynext 等于 rq2_wptr
	//full_val的判断是wgraynext 前两位要等于wq2_rptr的前两位取反
	//具体为什么现在还不确定
	assign full_val = (wgraynext=={~wq2_rptr[ASIZE:ASIZE-1], wq2_rptr[ASIZE-2:0]}); //:ASIZE-1]
	always @(posedge wclk or posedge wrst)
		if (wrst == RESET_VALUE) full <= 1'b0;
		else full <= full_val;


























/*
//-----------------双口RAM存储器--------------------
assign rdata=mem[raddr];

always@(posedge wclk)
	if (write && !full) mem[waddr] <= wdata;
//-------------同步rptr 指针-------------------------

always @(posedge wclk or posedge wrst)
	if (wrst) {wq2_rptr,wq1_rptr} <= 0;
	else {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};

//-------------同步wptr指针---------------------------
always @(posedge rclk or posedge rrst)
	if (rrst) {rq2_wptr,rq1_wptr} <= 0;
	else {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};

//-------------empty产生与raddr产生-------------------
always @(posedge rclk or posedge rrst) // GRAYSTYLE2 pointer
	if (rrst) {rbin, rptr} <= 0;
	else {rbin, rptr} <= {rbinnext, rgraynext};

// Memory read-address pointer (okay to use binary to address memory)
assign raddr = rbin[ASIZE-1:0];
assign rbinnext = rbin + (read & ~empty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;
// FIFO empty when the next rptr == synchronized wptr or on reset
assign empty_val = (rgraynext == rq2_wptr);
always @(posedge rclk or posedge rrst)
	if (rrst) empty <= 1'b1;
	else empty <= empty_val;

//---------------full产生与waddr产生------------------------------
always @(posedge wclk or posedge wrst) // GRAYSTYLE2 pointer
	if (wrst) {wbin, wptr} <= 0;
	else {wbin, wptr} <= {wbinnext, wgraynext};

// Memory write-address pointer (okay to use binary to address memory)
assign waddr = wbin[ASIZE-1:0];
assign wbinnext = wbin + (write & ~full);
assign wgraynext = (wbinnext>>1) ^ wbinnext;
assign full_val = (wgraynext=={~wq2_rptr[ASIZE:ASIZE-1], wq2_rptr[ASIZE-2:0]}); //:ASIZE-1]
always @(posedge wclk or posedge wrst)
	if (wrst) full <= 1'b0;
	else full <= full_val;
*/

endmodule
