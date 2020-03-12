/*
NAND
a	b	q
0	0	1
0	1	1
1	0	1
1	1	0
*/


module NAND (a, b, q);
	input a;
	input b;
	output q;

	assign q = ~(a & b);




endmodule
