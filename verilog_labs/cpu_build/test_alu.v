module test_alu();
	reg [7:0] op1, op2;
	wire [7:0] r;
	reg [2:0] s;
	
	alu my_alu(op1,op2,s,r);
	
	initial begin
		#5
		op1 = 5;
		op2 = 6;
		s = 0;
		
		#10
		op1= 10;
		op2= 12;
		s = 1;
		
		#10
		op1 = 15;
		op2 = 13;
		s = 2;
		
		#30;
	end
	always @ (op1,op2,s) begin
		$display("%d %d %3b %d", op1, op2, s, r);
	end	
	
endmodule
