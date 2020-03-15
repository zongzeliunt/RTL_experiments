/*
bin[0]= gray[3] ^ gray[2] ^ gray[1] ^ gray[0] ; // gray>>0
bin[1] = 1'b0 ^ gray[3] ^ gray[2] ^ gray[1] ; // gray>>1
bin[2] = 1'b0 ^ 1'b0 ^ gray[3] ^ gray[2] ; // gray>>2
bin[3] = 1'b0 ^ 1'b0 ^ 1'b0 ^ gray[3] ; // gray>>3

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


(gray >> i) 高位补0
^(gray >> i) 的意思就是移位以后再把所有位都异或

*/

module gray2bin (bin, gray);
	parameter SIZE = 4;
	output [SIZE-1:0] bin;
	input [SIZE-1:0] gray;
	reg [SIZE-1:0] bin;
	integer i;
always @(gray)
	for (i=0; i<SIZE; i=i+1)
		bin[i] = ^(gray>>i);
endmodule
