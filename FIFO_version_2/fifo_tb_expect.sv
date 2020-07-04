`timescale 1ns/1ns

module dut_tb;
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

initial begin
	$vcdplusfile("waveforms.vpd");
	$vcdpluson();
	$vcdplusmemon();
	CLK <= 1'b0;
	RESET <= 1'b1;
	fifo_write <= 0;
	fifo_input_data <= 0;
	fifo_read <= 0;
	#5 CLK ^= 1;
	#5 CLK ^= 1;
	#5 CLK ^= 1; //15
	RESET <= 1'b0;
	#5 CLK ^= 1;
	#5 CLK ^= 1; //25
	fifo_write <= 1;
	fifo_input_data <= 32'd10;
	#5 CLK ^= 1;
	#5 CLK ^= 1; //35
	//我只能写一个数！
	fifo_write <= 0;
	fifo_input_data <= 32'd0;
	//这里不能期待empty是1,因为不稳定
	//if (fifo_empty != 0) begin
	//	$error("expect empty = 0 but get 1");
	//end
	//data 也不稳定
	//if (fifo_output_data != 32'd10) begin
	//	$error("expect read data error");
	//end
	#5 CLK ^= 1;
	#5 CLK ^= 1; //45
	//在这里就稳定了
	if (fifo_empty != 0) begin
		$error("expect empty = 0 but get 1");
	end
	if (fifo_output_data != 32'd10) begin
		$error("expect read data error");
	end
	fifo_read <= 1;
	#5 CLK ^= 1;
	#5 CLK ^= 1; //55
	fifo_read <= 0;
	//在这里不能看empty
	//if (fifo_empty != 1) begin
	//	$error("expect empty = 1 but get 0");
	//end
	#5 CLK ^= 1;
	#5 CLK ^= 1; //65
	if (fifo_empty != 1) begin
		$error("expect empty = 1 but get 0");
	end
	if (fifo_output_data != 0) begin
		$error("expect read data error");
	end
	
	#5 CLK ^= 1;
	#5 CLK ^= 1; //85
	#5 CLK ^= 1;
	#5 CLK ^= 1; //95
	
	$finish;
end
endmodule
