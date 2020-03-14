`timescale 1ns/10ps

module fifo_test;
	reg CLK;
	reg RESET;
	reg [31:0] CLK_COUNTER;

	reg [31:0] fifo_input_data;
	wire [31:0] fifo_output_data;
	reg fifo_read;
	reg fifo_write;
	wire fifo_empty;
	wire fifo_full;

	reg [31:0] tb_test_data_array[31:0];
	reg [31:0] tb_array_write_addr;
	integer tb_array_i;

	parameter TB_RESET_VALUE = 1;
	parameter FIFO_DEPTH = 16;
	//parameter TB_DEPTH = FIFO_DEPTH * 2;
	parameter TB_DEPTH = 32;

	fifo #(
			.DEPTH(FIFO_DEPTH),
			.RESET_VALUE(TB_RESET_VALUE)
		) FIFO
	(
		.clk(CLK),
		.reset(RESET),
		.input_data(fifo_input_data),
		.output_data(fifo_output_data),
		.read(fifo_read),
		.write(fifo_write),
		.empty(fifo_empty),
		.full(fifo_full)
	);


//write opt
//{{{
always@(posedge CLK) begin
	if (RESET == TB_RESET_VALUE) begin
		tb_array_write_addr <= 0;
		fifo_write <= 0;
	end
	else begin
		//这里用的是我的paper里的pipeline的driver，可以保证在跑仿真的时候输入数组的下标和本拍的数据完全对应，没有延迟。
		if (fifo_full != 1 && tb_array_write_addr < TB_DEPTH) begin
			if (fifo_write == 1) begin
				//fifo_write == 1 意味着write和full==0 在fifo端形成一次有效的写操作，造成本拍的数据被fifo吃掉
				//那么下一拍要尝试输入数组的下一个数据，并且下标可以加1
				if (tb_array_write_addr != TB_DEPTH - 1) begin	
					//现地址只要不是最后一个数据，就写下一个地址的数据
					fifo_input_data <= tb_test_data_array[tb_array_write_addr + 1];
					fifo_write <= 1;
				end
				else begin
					//由于数组最后一个数据被吃了，那么不能再给fifo写东西了
					fifo_write <= 0;
				end
				//不管如何，下标也要加1。如果造成下标变成了TB_DEPTH，达成上面的停止条件，以后再也不能写数据了
				tb_array_write_addr <= tb_array_write_addr + 1;
			end
			else begin
				//进入此条件有两个可能，1.这是第一个数; 2.上一拍没有成功写入。那么说明上一拍没要求本拍修改下标
				//本拍要继续写上一拍没成功的那个数。
				fifo_input_data <= tb_test_data_array[tb_array_write_addr];
				fifo_write <= 1;
			end
			
		end 
		else begin
			fifo_write <= 0;
		end
	end
end
//}}}

//read opt
//{{{
always@(posedge CLK) begin
	if (RESET == TB_RESET_VALUE) begin
		fifo_read <= 0;
	end
	else begin
		//if (fifo_empty != 1) begin
		if (fifo_empty != 1 && fifo_full == 1) begin
			//这只是一个tb里的试验，上面是只要fifo不空就读，下面是等fifo写满了再读，这样可以做极限测试。
			fifo_read <= 1;
		end 
		else begin
			fifo_read <= 0;
		end
	end
end
//}}}

//test data
//{{{
always@(posedge CLK) begin
	if (RESET == TB_RESET_VALUE) begin
		for (tb_array_i = 0; tb_array_i < TB_DEPTH; tb_array_i = tb_array_i + 1) begin
			tb_test_data_array[tb_array_i] = tb_array_i * 2;
		end	
	end
end
//}}}

//clk, reset
//{{{
initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
end

initial begin
        RESET = ~TB_RESET_VALUE;
        #100;
            RESET = TB_RESET_VALUE;
        #20;
            RESET = ~TB_RESET_VALUE;
        #10000000;

            $finish;
end    

always @( posedge CLK )
begin
	if (RESET == TB_RESET_VALUE) begin
		CLK_COUNTER <= 0;
	end
	else begin
		CLK_COUNTER <= CLK_COUNTER + 1;
	end
end
//}}}

endmodule
