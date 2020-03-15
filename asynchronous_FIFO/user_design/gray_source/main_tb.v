module main_tb ;
	parameter SIZE = 8;
	reg CLK;
	reg RESET;
	reg [31:0] CLK_COUNTER;
	reg gray_inc;
	wire [SIZE-1:0] gray_gray, gray_bin;

	graycntr #(.SIZE(SIZE)) graycntr_tb (
		.clk(CLK),
		.rst(RESET),
		.inc(gray_inc),
		.gray(gray_gray),
		.bin(gray_bin)


		); 

always @(posedge CLK) begin
	if (RESET == 1) begin
		gray_inc <= 0;
	end
	else begin
		gray_inc <= ~gray_inc;
	end	
end

//clk reset
//{{{
initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
end

initial begin
	RESET = 0;
	#100;
	RESET = 1;
	#40;
	RESET = 0;
	#1000;
	$finish;
end

always @( posedge CLK )
begin
	if (RESET == 1) begin
		CLK_COUNTER <= 0;
	end
	else begin
		CLK_COUNTER <= CLK_COUNTER + 1;
	end
end
//}}}



endmodule
