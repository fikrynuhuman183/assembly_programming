module testBench();
	reg [7:0]  a, b;
	reg s;
	wire [7:0] z;

	logicSelector l1(a,b,s,z);	

	initial
	begin
		$monitor("a= %0d, b=%0d, s=%b, z=%0d",a,b,s,z);
		$dumpfile("logicsel.vcd");
		$dumpvars(0, l1);

		a = 8'd2; b=8'd54; s=1'b0;
		#5;
		a = 8'd2; b=8'd7; s=1'b0;
		#5;	
		a = 8'd2; b=8'd14; s=1'b1;
		#5;
		a = 8'd2; b=8'd14; s=1'b0;
		#5;
		a = 8'd27; b=8'd14; s=1'b0;
		#5;
		$finish;
		
	end
	
endmodule

module logicSelector(A, B, S, Z);
	input [7:0] A;
	input [7:0] B;
	output [7:0] Z;
	input S;
	wire [7:0] C, D;

	andUnit a(A, B, C);
	orUnit o(A,B,D);

	
	muxUnit u(C, D, S, Z);
	 
endmodule

module andUnit(A, B, C);
	input [7:0] A;
	input [7:0] B;
	output [7:0] C;

	assign C = A & B;

endmodule

module orUnit(A, B, C);

	input [7:0] A;
	input [7:0] B;
	output [7:0] C;

	assign C = A | B;

endmodule

module muxUnit(C, D, S, Z);
	
	input [7:0] C;
	input [7:0] D;
	input S;
	output [7:0] Z;

	assign Z = S ? D : C;

endmodule
