module testbed();
	reg clk;
	reg reset;
	reg enable;
	wire [3:0] count;

	counter c(clk,reset,enable, count);

	always #5 clk = ~clk;

	initial begin
		clk = 0;
		reset = 0;
		enable = 0;
		
		$dumpfile("counter.vcd");
		$dumpvars(clk,reset,enable,count);
		$monitor("clk=%b, reset=%b, enable=%b, count=%d", clk, reset, enable, count);
		reset = 1;

		#10;reset = 0 ;  enable = 1;
		
		#50;

		reset = 1;

		#10;

		reset = 0;

		#40;

		enable = 0;

		#30;

		enable = 1;

		#30;


		$finish;
	end
endmodule

module counter(clk, reset, enable, count);
	input clk, reset, enable;
	output reg [3:0] count;

	always @ (posedge clk) begin
		if(reset)
			count <= 4'b0000;
		else if(enable) 
			count <= count +1;
	end

	
endmodule
