/*
gray[0]= bin[0] ^ bin[1];
gray[1] = bin[1] ^ bin[2];
gray[2] = bin[2] ^ bin[3];
gray[3] = bin[3];

bin	gary
0	0
1	1
2	3
3	2
4	6
5	7
6	5
7	4
8	c
9	d
a	f
b	e
c	a
d	b
e	9
f	8



bin >> 1高位补0
0 ^ 0 = 0
0 ^ 1 = 1
*/

module bin2gray (gray, bin);
	parameter SIZE = 4;
	output [SIZE-1:0] gray;
	input [SIZE-1:0] bin;
	assign gray = (bin>>1) ^ bin;

endmodule
