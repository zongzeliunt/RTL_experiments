/*
XNOR
a	b	q
0	0	1
0	1	0
1	0	0
1	1	1
*/

module XNOR (a, b, q);
	input a;
	input b;
	reg q;
	output q;

always @(a, b) 
begin
	if (a == b) begin
		q = 1;
	end
	else begin
		q = 0;
	end
end


endmodule
