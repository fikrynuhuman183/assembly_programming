module testbed;

	reg A_test, B_test;
	wire S_test, C_Test;	
	half_adder half(A_test, B_test, S_test, C_test);


	
	initial
	begin
		$monitor("A_test = %b, B_test = %b, S_test = %b, C_test = %b",A_test,B_test,S_test,C_test);
		$dumpfile("wavedata.vcd");
		$dumpvars(0, testbed);
		A_test = 0;
		B_test = 0; 

		#5
		A_test = 1;
		
		#5
		B_test = 1;
		A_test = 0;

		$finish;
	end

endmodule 

module half_adder(A, B, S, C);
	//port declaration
	input A, B;
	output S, C;

	//internal inplementation
	xor x1(S, A, B);
	and a1(C, A, B);
	
endmodule
