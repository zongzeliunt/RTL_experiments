module fifo (
	clk, 
	reset,
	input_data,
	output_data,
	read,
	write,
	empty,
	full
	);
	input clk;
	input reset;
	input [31:0] input_data;
	output [31:0] output_data;
	
	input read;
	input write;
	output empty;
	output full;
	
	parameter DEPTH = 16;
	parameter ADDR_BIT = 4;
	parameter RESET_VALUE = 1;
	reg [31:0] data_array[DEPTH - 1: 0];
	reg flap;
	reg [ADDR_BIT - 1:0] write_addr;
	reg [ADDR_BIT - 1:0] read_addr;	
	
	
	integer array_i; 
	assign output_data = data_array[read_addr];
	
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
	if (reset == RESET_VALUE) begin
		for (array_i = 0; array_i < DEPTH; array_i = array_i + 1) begin
			data_array[array_i] <= 0;
		end
	end
	else begin
		if (write == 1 && full != 1) begin
			data_array[write_addr] <= input_data;
		end
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
