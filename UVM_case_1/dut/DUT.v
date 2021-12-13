
module Counter(clk,reset,data);
    input wire clk,reset;
    output reg [3:0] data;
    
    always @ (posedge clk)
    begin
        if(reset)
            data<=0;
        else
            data<=data+1;
    end
endmodule
