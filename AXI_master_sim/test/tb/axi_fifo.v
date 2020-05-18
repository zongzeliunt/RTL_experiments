module axi_fifo (
	clk, 
	reset,
	ADDR_i,
	ID_i,
	LEN_i,
	SIZE_i,
	BURST_i,
	
	ADDR_o,
	ID_o,
	LEN_o,
	SIZE_o,
	BURST_o,

	read,
	write,
	empty,
	full
	);
	parameter DEPTH = 16;
	parameter ADDR_BITWIDTH = 32; 
	parameter ID_BITWIDTH = 1;

	parameter ADDR_BIT = 4;
	parameter RESET_VALUE = 1;
	
	input clk;
	input reset;
	input [ADDR_BITWIDTH - 1 : 0] ADDR_i;
	input [ID_BITWIDTH - 1 : 0] ID_i;
	input [8-1:0] LEN_i;
	input [3-1:0] SIZE_i;
	input [2-1:0] BURST_i;

	output [ADDR_BITWIDTH - 1 : 0] ADDR_o;
	output [ID_BITWIDTH - 1 : 0] ID_o;
	output [8-1:0] LEN_o;
	output [3-1:0] SIZE_o;
	output [2-1:0] BURST_o;
	
	input read;
	input write;
	output empty;
	output full;
	
	
	reg [ADDR_BITWIDTH - 1:0] ADDR[DEPTH - 1: 0];
	reg [ID_BITWIDTH - 1:0] ID[DEPTH - 1: 0];
	reg [7:0] LEN[DEPTH - 1: 0];
	reg [2:0] SIZE[DEPTH - 1: 0];
	reg [1:0] BURST[DEPTH - 1: 0];
	
	reg flap;
	reg [ADDR_BIT - 1:0] write_addr;
	reg [ADDR_BIT - 1:0] read_addr;	
	
	
	integer array_i; 
	assign ADDR_o = ADDR[read_addr];
	assign ID_o = ID[read_addr];
	assign LEN_o = LEN[read_addr];
	assign SIZE_o = SIZE[read_addr];
	assign BURST_o = BURST[read_addr];
	
	//第一版本，直连信号给full empty
	//信号直连必须用wire类型
	/*
	wire empty;
	wire full;
	assign full = (write_addr == read_addr && flap == 1) ? 1 : 0; 
	assign empty = (write_addr == read_addr && flap == 0) ? 1 : 0; 
	*/

//第二版本，组合逻辑
//组合逻辑必须用reg类型
reg empty;
reg full;	


//full
always @(write_addr, read_addr, flap) begin
	if (write_addr == read_addr && flap == 1) begin
		full = 1;
	end
	else full = 0;
end

//empty
always @(write_addr, read_addr, flap) begin
	if (write_addr == read_addr && flap == 0) begin
		empty = 1;
	end
	else empty = 0;
end



//data_array 
//{{{
always@(posedge clk) begin
	if (write == 1 && full != 1) begin
		ADDR[write_addr] <= ADDR_i;
		ID[write_addr] <= ID_i;
		LEN[write_addr] <= LEN_i;
		SIZE[write_addr] <= SIZE_i;
		BURST[write_addr] <= BURST_i;
	end
end 
//}}}

//write_addr
//{{{
always@(posedge clk) begin
	if (reset == RESET_VALUE) begin
		write_addr <= 0;
	end
	else begin
		if (write == 1 && full != 1) begin
			if (write_addr == DEPTH - 1) begin
				write_addr <= 0;
			end
			else begin
				write_addr <= write_addr + 1;
			end
		end
	end
end 
//}}}

//read_addr
//{{{
always@(posedge clk) begin
	if (reset == RESET_VALUE) begin
		read_addr <= 0;
	end
	else begin
		if (read == 1 && empty != 1) begin
			if (read_addr == DEPTH - 1) begin
				read_addr <= 0;
			end
			else begin
				read_addr <= read_addr + 1;
			end
		end

	end
end
//}}}

//flap
//flap == 0: write greater than read
//flap == 1: write less than read
//{{{
always@(posedge clk) begin
	if (reset == RESET_VALUE) begin
		flap <= 0;
	end
	else begin
		if (write == 1 && full != 1) begin
			//write
			if (write_addr == DEPTH - 1) begin
				flap <= ~flap;
			end
		end
		if (read == 1 && empty != 1 ) begin
			//read
			if (read_addr == DEPTH - 1) begin
				flap <= ~flap;
			end
		end
	end
end 
//}}}
endmodule
