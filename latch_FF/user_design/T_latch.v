/*
T	Q	Qnext	动作				Q	Qnext	T	动作
0	0	0		保持（无上升沿）	0	0		0	不变
0	1	1		保持（无上升沿）	1	1		0	不变
1	0	1		反转				0	1		1	反相
1	1	0		反转				1	0		1	反相

t 异或 q
+外面加个圈

*/

/*
笔记：
1. 网上的方法全是时序的，没有组合的
2. 我这里写了两个方法，时序和组合，行为其实都对，也可以用一个JK触发器，把JK两个信号全写成T
3. TB 的T值为 0，0，1, 1, 0, 1, 0, 1
4.组合的行为：
	CLK 	0		1	2	3	4	5	6	7 	8
	T		0(reset)0 	0	1	1	0	1	0	1
	Q		0(reset)0	0	1	1	1	0	0	1	
	这个行为基本符合上面的真值表。
		比如 Q[2] = nor(T[2], Q[1]) = nor (0, 0) = 0。
		再比如Q[6] = nor(T[6], Q[5]) = nor (1, 1) = 0。
	组合和时序不同，组合是在信号有变化时立即改变被赋值信号。
	但是有个有趣的现象就是 Q[4].
	本来Q[4]应该等于 nor(T[4], Q[3]) = nor (1, 1) = 0。然而，由于进程的触发信号是(t，q，reset)，而在clk为4时刻，t，q都和上一时刻无变化，那么这一进程根本不触发，于是就保持了。
	其他时刻均正常。


5. 时序的行为：
	CLK 	0		1	2	3	4	5	6	7 	8
	T		0(reset)0 	0	1	1	0	1	0	1
	Q		0(reset)0	0	0	1	0	0	1	1	
	由于采样时间不同，赋值方式也不同。
	时序是在时钟沿触发，触发时按照时钟沿时采样的其他信号的值来跟本时钟的被赋值信号赋值。
	比如，Q[4]是clk = 4 时采样的T[3]，Q[3]的值。
		Q[4] = xor (T[3], Q[3]) = xor(1, 0) = 1
	再比如Q[6] = xor(T[5], Q[5]) = xor(0, 0) = 0
	实验结果完全正确，只是有一拍的延迟。

6. 其实还有一种方法，就是 assign q = (t == q) ? 0 : 1;
	但是这种方法照顾不到reset，q没有初始值。
	我曾经尝试过 assign qt = (t == q) ? 0 : 1;
				assign q = (reset == 1) ? 0 : qt;
		这样出错,仿真没结果

7. 归根结底，时序逻辑最靠谱，就是有一个cycle的延迟。
*/

module T_latch (clk, reset, t, q);
	input clk;
	input reset;
	input t;
	reg q;

	output q;
	/*	
	always @(t, q, reset) begin
		if (reset == 1) begin
			q = 0;
		end
		else begin
			q <= t ^ q; 				//方法 1
			//q = (~t & q) ^ (t & ~q);	//方法	2
			//q = (~t & q) + (t & ~q);	//方法3
			//q = (~t & q) | (t & ~q);	//方法4
			//if (t == q) q = 0;		//方法5
			//else q = 1;
	
		end

	end
	*/

	always @(posedge clk) begin
		if (reset == 1) begin
			q = 0;
		end
		else begin
			//q <= (~t & q) ^ (t & ~q);
			//q <= t ^ q;
			q <=(~t & q) + (t & ~q);
			//q <= (~t & q) | (t & ~q);
			//if (t == q) q <= 0;
			//else q <= 1;
	
		end

	end
endmodule


