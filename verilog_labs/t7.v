module testbed;
	reg a,b,c;
	reg x,y;
	
	

endmodule



module nb(a, b, c,x,y);
	input a,b,c;
	output x,y;
	
	always @ (a, b, c)
	begin
		x <= a & b;
		y <= x & c;
	end

endmodule
module nb(a, b, c,x,y);
	input a,b,c;
	output x,y;
	
	always @(a,b,c)
	begin
		x = a & b;
		y = x & c;
	end

endmodule



