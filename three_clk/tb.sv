`timescale 1 ns / 1 ps

module tb #(

);

reg clk;
wire clkout;

three (clk, clkout);


initial begin
    #10000;
    $finish;

end


//clk
//{{{
initial begin
    clk = 0;
    forever begin
        #5 clk ^= 1;
        #5 clk ^= 1;
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
