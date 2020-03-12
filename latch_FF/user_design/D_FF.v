/*
Q的波形将会和D一模一样

D	E	Q	Qnext
0	1	X	0
1	1	X	1
X	0	0	0
X	0	1	1
*/

module D_FF (clk, d, q);
	input d;
	input clk;
	output q;

	wire add_0;
	wire add_1;
	wire sr_latch_qn;
	
	assign add_0 = d & clk;
	assign add_1 = ~d & clk;
	
	SR_latch SR_latch(
		.s(add_0),
		.r(add_1),
		.q(q),
		.qn(sr_latch_qn)
		);	
	 
endmodule
