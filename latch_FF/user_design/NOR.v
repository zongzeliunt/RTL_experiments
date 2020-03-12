/*
NOR
a	b	q
0	0	1
0	1	0
1	0	0
1	1	0
*/

module NOR (a, b, q);
	input a;
	input b;
	output q;

	assign q = ~(a | b);
	//nor (a,b,q);



endmodule
