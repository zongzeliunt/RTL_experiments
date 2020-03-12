/*
其实D latch的e如果接了clk就会变成D FF
用e来决定是不是要给d赋值

D	E	Q	Qnext
0	1	X	0
1	1	X	1
X	0	0	0
X	0	1	1
*/



module D_latch (d, e, q);
	input d;
	input e;
	output q;

	wire add_0;
	wire add_1;
	wire sr_latch_qn;
	
	assign add_0 = d & e;
	assign add_1 = ~d & e;
	
	SR_latch SR_latch(
		.s(add_0),
		.r(add_1),
		.q(q),
		.qn(sr_latch_qn)
		);	
	 
endmodule

