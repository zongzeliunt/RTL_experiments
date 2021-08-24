`timescale 1ns / 1ns
longint unsigned ns_counter;
longint unsigned clock_counter;

module adder_test;
	reg clk;
	reg reset;

	reg [31:0] input_a;
	reg [31:0] input_b;

	wire [31:0] result;
	
	parameter TB_RESET_VALUE = 1;
	
	adder ADDER (
		.ina (input_a),
		.inb (input_b),
		.outx (result)
	);

initial begin
    //reset
    @(posedge clk);
    while (reset == TB_RESET_VALUE) begin
        @(posedge clk);
    end
    
    input_a <= 0;
    input_b <= 0;

    @(posedge clk);
    @(posedge clk);

    input_a <= 5;
    input_b <= 2;
    @(posedge clk);

    $display("result = ", result);


end

//reset
//{{{
initial begin
    reset = TB_RESET_VALUE;
    #20;
    reset = ~TB_RESET_VALUE;
    //messager.dump_message("sim start");
    //#500000;
    #500;
    //messager.dump_message("sim end");
    $finish;
end
//}}}

//clk
//{{{
initial begin
    clk = 0;
    clock_counter = 0;
    ns_counter = 0;
    forever begin
        #5 clk ^= 1;
        ns_counter += 5;
        #5 clk ^= 1;
        ns_counter += 5;
        clock_counter += 1;
    end
end
//}}}

//waveform
//{{{
initial begin
    $vcdplusfile("waveforms.vpd");
    $vcdpluson();
    $vcdplusmemon();
end
//}}}

endmodule
