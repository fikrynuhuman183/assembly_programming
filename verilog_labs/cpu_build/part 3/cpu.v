`include "alu.v"
`include "register.v"


module cpu(PC, INSTRUCTION, CLK, RESET);
	input CLK, RESET;
	input [31:0] INSTRUCTION;
	
	output reg [31:0] PC;
	
	reg [31:0] PCREG;
	
	wire [7:0] IMMEDIATE;
	
	wire [2:0] READREG1, READREG2, WRITEREG;
	
	wire [7:0] REGOUT1, REGOUT2,MUXOUT1, MUXOUT2, ALURESULT;
	reg [2:0] ALUOP;
	
	reg MUX1,MUX2;
	
	reg WRITEENABLE;
	
	wire [7:0] neg;
	
	reg [7:0] opcode;
	
	
	//alu(op1,op2,s,r)
	alu myalu(REGOUT1, MUXOUT2, ALURESULT,ALUOP);
	
	//register(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET)
	register myregister(ALURESULT,REGOUT1, REGOUT2, WRITEREG, READREG1,READREG2,WRITEENABLE,CLK, RESET);
	
	assign #1 neg = ~REGOUT2 + 1;
	
	//mux(IN1, IN2,S, OUT);
	mux mux1(REGOUT2, neg, MUX1, MUXOUT1);
	
	mux mux2(MUXOUT1, IMMEDIATE , MUX2, MUXOUT2);
	
	assign READREG1 = INSTRUCTION[15:8];
	assign IMMEDIATE = INSTRUCTION[7:0];
	assign READREG2 = INSTRUCTION[7:0];
	assign WRITEREG = INSTRUCTION[23:16];
	
	
	always @ (INSTRUCTION)
	begin
	
		#1 opcode = INSTRUCTION[31:24];
		
		case(opcode)
		
		//LOAD
		8'b00000000: begin
			ALUOP = 3'b000;	
			MUX1 = 0;
			MUX2 = 1;
			WRITEENABLE = 1;
		end
		
		//MOV
		8'b00000001: begin
			ALUOP = 3'b000;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
		end
		
		//ADD
		8'b00000010: begin
			ALUOP = 3'b001;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
		end
		
		//SUB
		8'b00000010: begin
			ALUOP = 3'b001;
			MUX1 = 1;
			MUX2 = 0;
			WRITEENABLE = 1;
		end
		
		//AND
		8'b00000100: begin
			ALUOP = 3'b010;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
		end
		
		//OR
		8'b00000101: begin
			ALUOP = 3'b011;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
		end
		
		endcase		
		
	end
	
	always @ (posedge CLK)
	begin
		if(RESET) begin
			#1 PC = 0 ;
			PCREG = 0;
		end
		else #1 PC = PCREG;
	end
	
	always @ (PC)
	begin
		#1 PCREG = PCREG +4;
	end

			
endmodule

//module control_unit(OPCODE, ALU, MUX1, MUX2, WRITEENABLE);
	

//endmodule

module mux(IN1, IN2,S, OUT);

	input [7:0] IN1, IN2;
	output [7:0] OUT;
	input S;
	
	assign OUT = S ? IN2:IN1;
endmodule
	
