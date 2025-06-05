module testbed();
	reg a, b,clk;
	wire q,qbar;
	
	d_flop d(a,b,clk,q,qbar);

	
	initial
	begin
	$monitor("a=%b, b=%b, clk=%b, q=%b, qbar=%b", a,b,clk,q,qbar);
	a = 0; b=1; clk=1;
	#10;
	a=1; b=0; 
	#10 a=0; b=0; clk=0;
	#10 a=0; b=1; clk=0;
	#10 a=0; b=1; clk=1;
	#10;
	$finish;
	end
endmodule


module d_flop(r, s, clk, q, qbar);
	input r,s,clk;
	wire a,b;
	output q, qbar;
	
	
		and and1(a,r,clk);
		and and2(b,s,clk);
		nor (q,a,qbar);
		nor (qbar, q,b);
	
endmodule
