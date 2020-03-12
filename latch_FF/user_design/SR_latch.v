/*
S	R	Q	Qnext	解释
0	0	0	0	维持
0	0	1	1	维持
0	1	0	0	重设
0	1	1	0	重设
1	0	0	1	设定
1	0	1	1	设定
1	1	0	-	不允许
1	1	1	-	不允许
*/

/*
2020 年3月6号：
数据：
A 0 0 1 0 0 1 1 1 
B 1 0 0 0 1 1 0 1
对应操作：
reset，latch 0，set 1，latch 1
reset, not allow，set 1, not allow

我用了三种模式，
1. 我自己的NAND：
	这个模式下的s和r必须是取反的！按wiki说的！
	1. S 0, R 1: reset，q = 0, qn = 1
	2. S 0, R 0: latch 0, q = 0, qn = 1
	3. S 1, R 0: set 1, q = 1, qn = 0
	4. S 0, R 0: latch 1, q = 1, qn = 1
	5. S 0, R 1: reset, q = 0, qn = 1
	6. S 1, R 1: not allow, q = 1, qn = 1
	7. S 1, R 0: set 1, q = 1, qn = 0
	8. S 1, R 1: not allow, q = 1, qn = 1
	
1. 我自己的NOR：
	1. S 0, R 1: reset，q = 1, qn = 0
	2. S 0, R 0: latch 0, q = 1, qn = 0
	3. S 1, R 0: set 1, q = 0, qn = 1
	4. S 0, R 0: latch 1, q = 0, qn = 1
	5. S 0, R 1: reset, q = 1, qn = 0
	6. S 1, R 1: not allow, q = 0, qn = 0
	7. S 1, R 0: set 1, q = 0, qn = 1
	8. S 1, R 1: not allow, q = 0, qn = 0

3. Xilinx 的nor：
	1. S 0, R 1: reset，q = 0, qn = 1
	2. S 0, R 0: latch 0, q = 0, qn = 1
	3. S 1, R 0: set 1, q = 1, qn = 0
	4. S 0, R 0: latch 1, q = 1, qn = 1
	5. S 0, R 1: reset, q = 0, qn = 1
	6. S 1, R 1: not allow, q = 0, qn = 0
	7. S 1, R 0: set 1, q = 1, qn = 0
	8. S 1, R 1: not allow, q = 0, qn = 0

用我的NAND和用xilinx的nor区别不大，只是在not allow那两个的时候我的NAND两个都是1, nor时两个都是0
用我的NOR和用xilinx的nor情况都一样，只是q和qn对调了，这点很奇怪
具体行为其实都差不多，都是正常情况下q和qn是相反，not allow情况下两个一样
我自己的NOR里也可以直接用nor门，结果和在本例子中的用XILINX nor的结果一样
可能是因为我外面用非阻塞赋值，用nor函数做异或和用assign做异或的延迟不一样，导致后面全变了。暂时无法解释。

*/


module SR_latch (s, r, q, qn);
	input s;
	input r;
	wire q;
	wire qn;
	output q;
	output qn;
	
	/*	
	NAND NAND_S (
		.a(~s),
		.b(qn),
		.q(q)
	);

	NAND NAND_R (
		.a(~r),
		.b(q),
		.q(qn)
	);
	*/
	/*
	NOR NOR_S (
		.a(qn),
		.b(s),
		.q(q)
	);
	
	NOR NOR_R (
		.a(q),
		.b(r),
		.q(qn)
	);
	*/
	
	//这是最稳定的做法		
	nor (qn, s, q); 
	nor (q, r, qn);
	
endmodule
