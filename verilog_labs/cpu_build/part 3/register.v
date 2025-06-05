
module register(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);
	input CLK, WRITE, RESET;
	input [7:0] IN;
	input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;
	output [7:0] OUT1, OUT2;
	reg [7:0] Register [7:0];
	integer i;
	
	assign #2 OUT1 = Register[OUT1ADDRESS];
	assign #2 OUT2 = Register[OUT2ADDRESS];

	
	always @ (posedge CLK)
	begin
		if(RESET)
		begin
			#1 for(i=0; i<8; i = i+1) begin
				Register[i] = 8'b00000000;
			end
		end
		else if(WRITE)
		begin
			#1 Register[INADDRESS]= IN;
		end

	end	

endmodule
