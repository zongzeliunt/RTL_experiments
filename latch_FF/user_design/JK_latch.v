/*

J	K	动作	Qnext	Q	Qnext	动作	J	K
0	0	保持	Q		0	0		不变	0	X
0	1	重置	0		0	1		设置	1	X
1	0	设置	1		1	0		重置	X	1
1	1	反转	Q		1	1		不变	X	0

J	K	动作	J	~k	(~k & q)	(j & ~q)	^(异或)		+	|
0	0	保持 	0 	1 	q 			0			q			q	q
0	1	重置 	0 	0 	0 			0			0			0	0
1	0	设置 	1	1 	q 			~q			1			1	1
1	1	反转 	1 	0 	0 			~q			~q			~q	~q

注释：
1）三种操作 ^(异或)，+，|(或) 都能达到相同效果不过原理不同，+更直观一点
2）保持：q与0异或。q为0,与0异或结果为0,即q。q为1,与0异或结果为1,即q。
3）0 与0 异或，加，或，都是0
4）设置：～q与q异或，一定为1
5）反转：
		
		0与～q异或。q为1,～q为0,与0异或结果为0,即～q。q为0,～q为1,与0异或结果为1,即～q。
		0与～q加。q为1,～q为0, ～q+0 = 0. q为0,～q为1,～q+0 = 1.即～q
		0与～q或。q为1，～q为0, ～q|0 = 0. q为0, ～q为1, ～q|0 = 1.即～q


*/


module JK_latch (clk, reset, j, k, q);
	input clk;
	input reset;
	input j;
	input k;
	reg q;
	output q;

	always @(j, k, reset) begin
		if (reset == 1) begin
			q = 0;
		end
		else begin
			q = (~k & q) ^ (j & ~q);
			//q = (~k & q) + (j & ~q);
			//q = (~k & q) | (j & ~q);
		end

	end


endmodule
