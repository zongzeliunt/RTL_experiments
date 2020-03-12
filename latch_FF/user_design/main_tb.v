module main_tb ;

	reg s [7:0];
	reg r [7:0];
	reg d [7:0];
	reg e [7:0];
	
	reg j [7:0];
	reg k [7:0];
	
	reg t [7:0];
	
	reg [4:0] a_pos;
	reg [4:0] b_pos;
	
	reg CLK;
	reg RESET;
	reg [31:0] CLK_COUNTER;


	reg TB_SR_S;
	reg TB_SR_R;
	wire TB_SR_Q;
	wire TB_SR_QN;

	SR_latch SR_latch_tb(
		.s(TB_SR_S),
		.r(TB_SR_R),
		.q(TB_SR_Q),
		.qn(TB_SR_QN)
		);	
	
	reg TB_D_D;
	reg TB_D_E;
	wire TB_D_Q;
	D_latch D_latch_tb(
		.d(TB_D_D),
		.e(TB_D_E),
		.q(TB_D_Q)
		);	
	
	wire TB_D_FF_Q;
	D_FF D_FF_tb(
		.clk(CLK),
		.d(TB_D_D),
		.q(TB_D_FF_Q)
		);	
	
	reg TB_JK_J;
	reg TB_JK_K;
	wire TB_JK_Q;
	JK_latch JK_latch_tb(
		.clk (CLK),
		.reset (RESET),
		.j(TB_JK_J),
		.k(TB_JK_K),
		.q(TB_JK_Q)
		);	

	reg TB_T_T;
	wire TB_T_Q;
	
	/*
	JK_latch JK_latch_tb_1(
		.clk (CLK),
		.reset (RESET),
		.j(TB_T_T),
		.k(TB_T_T),
		.q(TB_T_Q)
		);	
	*/

	T_latch T_latch_tb(
		.clk (CLK),
		.reset (RESET),
		.t(TB_T_T),
		.q(TB_T_Q)
		);




//clk reset
//{{{
initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
end

initial begin
	RESET = 0;
	#100;
	RESET = 1;
	#40;
	RESET = 0;
	#1000;
	$finish;
end

always @( posedge CLK )
begin
	if (RESET == 1) begin
		CLK_COUNTER <= 0;
	end
	else begin
		CLK_COUNTER <= CLK_COUNTER + 1;
	end
end
//}}}


initial begin
	//SR latch
	//{{{
	s[0] = 0;
	r[0] = 1; //reset 
	s[1] = 0;
	r[1] = 0; //latch 0
 
	s[2] = 1;
	r[2] = 0; //set 
	s[3] = 0;
	r[3] = 0; //latch 1 

	s[4] = 0;
	r[4] = 1; //reset 1
	s[5] = 1;
	r[5] = 1; //not allow 
	
	s[6] = 1;
	r[6] = 0; //set
	s[7] = 1;
	r[7] = 1; //not allow
	//}}}

	//D latch
	//{{{
	d[0] = 0;
	e[0] = 1; //set 0 
	d[1] = 0;
	e[1] = 0; //no change 0
 
	d[2] = 1;
	e[2] = 0; //no change 0
	d[3] = 1;
	e[3] = 1; //set 1

	d[4] = 1;
	e[4] = 0; //no change 1
	d[5] = 0;
	e[5] = 1; //set 0 
	
	d[6] = 1;
	e[6] = 0; //no change 0
	d[7] = 1;
	e[7] = 1; //set 1
	//}}}

	//JK latch
	//{{{
	j[0] = 0;
	k[0] = 0; //hold 
	j[1] = 0;
	k[1] = 1; //reset to 0
 
	j[2] = 1;
	k[2] = 0; //set 1
	j[3] = 0;
	k[3] = 0; //hold

	j[4] = 1;
	k[4] = 1; //revert to 0
	j[5] = 0;
	k[5] = 0; //hold
	
	j[6] = 1;
	k[6] = 0; //set to 1
	j[7] = 1;
	k[7] = 1; //revert to 0 
	//}}}
	
	//T latch
	//{{{
	t[0] = 0;
	t[1] = 0; 
	t[2] = 1;
	t[3] = 1; 
	t[4] = 0;
	t[5] = 1; 
	t[6] = 0;
	t[7] = 1;  
	//}}}
end

//global position
//{{{
always @( posedge CLK )
begin
	if (RESET == 1) begin
		a_pos <= 0;	
		b_pos <= 0;	
	end
	else begin
		if (a_pos < 8) begin
			a_pos <= a_pos + 1;
		end
		
		if (b_pos < 8) begin
			b_pos <= b_pos + 1;
		end
	end
end
//}}}

//SR latch
//{{{
always @( posedge CLK )
begin
	if (RESET == 1) begin
		TB_SR_S <= 0;	
		TB_SR_R <= 0;	
	end
	else begin
		if (a_pos < 8) begin
			TB_SR_S <= s[a_pos];
		end
		else begin
			TB_SR_S <= 0;
		end
		if (b_pos < 8) begin
			TB_SR_R <= r[b_pos];
		end
		else begin
			TB_SR_R <= 0;
		end
	end
end
//}}}

//D latch and D_FF
//{{{
always @( posedge CLK )
begin
	if (RESET == 1) begin
		TB_D_D <= 0;	
		TB_D_E <= 0;	
	end
	else begin
		if (a_pos < 8) begin
			TB_D_D <= d[a_pos];
		end
		else begin
			TB_D_D <= 0;
		end
		if (b_pos < 8) begin
			TB_D_E <= e[b_pos];
		end
		else begin
			TB_D_E <= 0;
		end
	end
end
//}}}


//JK latch
//{{{
always @( posedge CLK )
begin
	if (RESET == 1) begin
		TB_JK_J <= 0;	
		TB_JK_K <= 0;	
	end
	else begin
		if (a_pos < 8) begin
			TB_JK_J <= j[a_pos];
		end
		else begin
			TB_JK_J <= 0;
		end
		if (b_pos < 8) begin
			TB_JK_K <= k[b_pos];
		end
		else begin
			TB_JK_K <= 0;
		end
	end
end
//}}}

//T latch
//{{{
always @( posedge CLK )
begin
	if (RESET == 1) begin
		TB_T_T <= 0;	
	end
	else begin
		if (a_pos < 8) begin
			TB_T_T <= t[a_pos];
		end
		else begin
			TB_T_T <= 0;
		end
	end
end
//}}}
endmodule
