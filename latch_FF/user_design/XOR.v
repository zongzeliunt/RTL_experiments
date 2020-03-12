/*
XOR
可能是 a^b
a	b	q
0	0	0
0	1	1
1	0	1
1	1	0
*/

module XOR (a, b, q);
	input a;
	input b;
	reg q;
	output q;

always @(a, b) 
begin
	if (a == b) begin
		q = 0;
	end
	else begin
		q = 1;
	end
end



endmodule
