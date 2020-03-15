module main_tb ;

	parameter DSIZE = 8;
	parameter ASIZE = 4; 
	parameter FIFO_DEPTH = (1<<ASIZE);
	parameter TB_RESET_VALUE = 1;

	reg W_CLK;
	reg W_RESET;
	reg [31:0] W_CLK_COUNTER;
	reg [DSIZE - 1: 0] W_DATA;
	reg WRITE;
	wire FULL;



	reg R_CLK;
	reg R_RESET;
	reg [31:0] R_CLK_COUNTER;
	wire [DSIZE - 1: 0] R_DATA;
	reg READ;
	wire EMPTY;


	parameter TB_DEPTH = FIFO_DEPTH * 2;
	reg [31:0] tb_test_data_array[TB_DEPTH - 1 : 0];
	reg [31:0] tb_array_write_addr;
	integer tb_array_i;

	
	asyn_fifo #(
		.DSIZE(DSIZE),
		.ASIZE(ASIZE),
		.RESET_VALUE(TB_RESET_VALUE)
	) 
	asyn_fifo_tb(
		.rdata(R_DATA), 
		.empty(EMPTY), 
		.read(READ), 
		.rclk(R_CLK), 
		.rrst(R_RESET), 
		
		.wdata(W_DATA), 
		.full(FULL), 
		.write(WRITE), 
		.wclk(W_CLK), 
		.wrst(W_RESET) 
	);


//write clk reset
//{{{
initial begin
        W_CLK = 0;
        forever #10 W_CLK = ~W_CLK;
end

initial begin
	W_RESET = ~TB_RESET_VALUE;
	#100;
	W_RESET = TB_RESET_VALUE;
	#40;
	W_RESET = ~TB_RESET_VALUE;
	#10000000;
	$finish;
end

always @( posedge W_CLK )
begin
	if (W_RESET == TB_RESET_VALUE) begin
		W_CLK_COUNTER <= 0;
	end
	else begin
		W_CLK_COUNTER <= W_CLK_COUNTER + 1;
	end
end
//}}}


//read clk reset
//{{{
initial begin
        R_CLK = 0;
        forever #12 R_CLK = ~R_CLK;
end

initial begin
	R_RESET = ~TB_RESET_VALUE;
	#80;
	R_RESET = TB_RESET_VALUE;
	#40;
	R_RESET = ~TB_RESET_VALUE;
	#1000;
end

always @( posedge R_CLK )
begin
	if (R_RESET == TB_RESET_VALUE) begin
		R_CLK_COUNTER <= 0;
	end
	else begin
		R_CLK_COUNTER <= R_CLK_COUNTER + 1;
	end
end
//}}}

//write opt
//{{{
always@(posedge W_CLK) begin
	if (W_RESET == TB_RESET_VALUE) begin
		tb_array_write_addr <= 0;
		WRITE <= 0;
	end
	else begin
		//这里用的是我的paper里的pipeline的driver，可以保证在跑仿真的时候输入数组的下标和本拍的数据完全对应，没有延迟。
		if (FULL != 1 && tb_array_write_addr < TB_DEPTH) begin
			if (WRITE == 1) begin
				//WRITE == 1 意味着write和full==0 在fifo端形成一次有效的写操作，造成本拍的数据被fifo吃掉
				//那么下一拍要尝试输入数组的下一个数据，并且下标可以加1
				if (tb_array_write_addr != TB_DEPTH - 1) begin	
					//现地址只要不是最后一个数据，就写下一个地址的数据
					W_DATA <= tb_test_data_array[tb_array_write_addr + 1];
					WRITE <= 1;
				end
				else begin
					//由于数组最后一个数据被吃了，那么不能再给fifo写东西了
					WRITE <= 0;
				end
				//不管如何，下标也要加1。如果造成下标变成了TB_DEPTH，达成上面的停止条件，以后再也不能写数据了
				tb_array_write_addr <= tb_array_write_addr + 1;
			end
			else begin
				//进入此条件有两个可能，1.这是第一个数; 2.上一拍没有成功写入。那么说明上一拍没要求本拍修改下标
				//本拍要继续写上一拍没成功的那个数。
				W_DATA <= tb_test_data_array[tb_array_write_addr];
				WRITE <= 1;
			end
			
		end 
		else begin
			WRITE <= 0;
		end
	end
end

//}}}

//read opt
//{{{
always@(posedge R_CLK) begin
	if (R_RESET == TB_RESET_VALUE) begin
		READ <= 0;
	end
	else begin
		//if (EMPTY != 1) begin
		if (EMPTY != 1 && FULL == 1) begin
			READ <= 1;
		end 
		else begin
			READ <= 0;
		end
	end
end
//}}}

//test data
//{{{
initial begin
	for (tb_array_i = 0; tb_array_i < TB_DEPTH; tb_array_i = tb_array_i + 1) begin
		tb_test_data_array[tb_array_i] = tb_array_i * 2;
	end	
end
//}}}



endmodule
