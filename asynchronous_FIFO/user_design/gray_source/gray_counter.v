module graycntr (gray, clk, inc, rst, bin);
	parameter SIZE = 4;
	output [SIZE-1:0] gray, bin;
	input clk, inc, rst;
	reg [SIZE-1:0] gnext, gray, bnext, bin;
	integer i;

always @(posedge clk or negedge rst)
	if (rst) gray <= 0;
	else gray <= gnext;

always @(gray or inc) begin
	for (i=0; i<SIZE; i=i+1)
		bin[i] = ^(gray>>i);
	bnext = bin + inc;
	gnext = (bnext>>1) ^ bnext;
end
endmodule


