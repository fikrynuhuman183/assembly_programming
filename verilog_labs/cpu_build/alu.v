
//defining the ALU
module alu(op1,op2,s,r);
	input [7:0] op1, op2;
	input [2:0] s;
	output reg [7:0] r;
	wire [7:0] r_fwd,r_add,r_and,r_or;
	
	fwd_f fwd(op1,r_fwd);
	add_f add(op1,op2,r_add);
	and_f and_u(op1,op2,r_and);
	or_f or_u(op1,op2,r_or);
	
	always @ (op1,op2,s) begin
		case (s)
			3'b000 :  r = r_fwd;
			3'b001 :  r = r_add;
			3'b010 :  r = r_and;
			3'b011 :  r = r_or;
		endcase
	end

endmodule



//defining the add module
module add_f(op1, op2, r);
	
	input [7:0] op1, op2; //8 bit inputs

	output [7:0] r; //8 bit output

	assign #2 r = op1 + op2;
endmodule

//defining the and module
module and_f(op1, op2, r);
	
	input [7:0] op1, op2; //8 bit inputs

	output [7:0] r; //8 bit output

	assign #1 r = op1 & op2;
endmodule

///defining the or module
module or_f(op1, op2, r);
	
	input [7:0] op1, op2; //8 bit inputs

	output [7:0] r; //8 bit output

	assign #1 r = op1 | op2;
endmodule

//defining the fwd module
module fwd_f(op1, r);
	
	input [7:0] op1; //8 bit inputs

	output [7:0] r; //8 bit output

	assign #1 r = op1;
endmodule

