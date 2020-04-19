`timescale 1ps/1ps

module adder_test;
	reg CLK;
	reg RESET;
	reg [31:0] CLK_COUNTER;

	reg [31:0] input_a;
	reg [31:0] input_b;

	wire [31:0] result;
	
	parameter TB_RESET_VALUE = 1;
	
	adder ADDER (
		.ina (input_a),
		.inb (input_b),
		.outx (result)
	);

always@(posedge CLK) begin
	if (RESET == TB_RESET_VALUE) begin
		input_a <= 0;
		input_b <= 0;
	end
	else begin
		if (CLK_COUNTER == 10) begin
			input_a <= 5;
			input_b <= 2;
		end
	end

end

always @(result) begin
	$display("result = ", result);
end 

//clk, reset
//{{{
initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
end


initial begin
	$vcdpluson;
end

initial begin
        RESET = ~TB_RESET_VALUE;
        #100;
            RESET = TB_RESET_VALUE;
        #20;
            RESET = ~TB_RESET_VALUE;
        #10000;

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
