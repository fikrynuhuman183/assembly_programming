`include "alu.v"
`include "register.v"


module cpu(PC, INSTRUCTION, CLK, RESET);

	//CPU module
	input CLK, RESET;
	input [31:0] INSTRUCTION;
	output reg [31:0] PC;
	
	
	//Instruction related
	wire [7:0] IMMEDIATE;
	wire [2:0] READREG1; 
	wire [2:0] READREG2;
	wire [2:0] WRITEREG;
	
	//Register related
	reg WRITEENABLE;
	wire [7:0] REGOUT1;
	wire [7:0] REGOUT2;
	wire [7:0] ALURESULT;
	
	//INVERTING MUX related
	wire [7:0] MUXOUT1;
	wire [7:0] neg;
	reg MUX1;
	
	//IMMEDIATE MUX related
	wire [7:0] MUXOUT2;
	reg MUX2;
	
	//ALU related
	reg [2:0] ALUOP;
	wire ZERO;

	//Other CU, PC and branching related 
	reg [7:0] opcode;
	reg JUMP;
	reg BRANCH;
	wire FLOW_S;
	wire [31:0] TARGET;
	wire [7:0] OFFSET;
	
	//PC related
	wire [31:0] PCPLUS;
	wire [31:0] NEWPC;
	
	//alu(op1,op2,s,r,zero)
	alu myalu(REGOUT1, MUXOUT2, ALURESULT,ALUOP, ZERO);
	
	//register(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET)
	register myregister(ALURESULT,REGOUT1, REGOUT2, WRITEREG, READREG1,READREG2,WRITEENABLE,CLK, RESET);
	
	//mux(IN1, IN2,S, OUT);//
	
	//Inverting MUX
	assign #1 neg = ~REGOUT2 + 1;
	
	mux mux1(REGOUT2, neg, MUX1, MUXOUT1);
	
	//Immediate selection MUX
	mux mux2(MUXOUT1, IMMEDIATE , MUX2, MUXOUT2);
	
	//Branch/Jump selection MUX
	muxExtend mux3(PCPLUS, TARGET , FLOW_S, NEWPC);
	
	//pcadder(PC, PCPLUS)
	pcAdder myPCAdder(PC, PCPLUS);
	
	//pcadder(target, offset, pc)
	branchAdder myAdder(TARGET, OFFSET, PCPLUS);
	
	flowControlUnit flowUnit(BRANCH, JUMP, ZERO, FLOW_S);

	
	assign READREG1 = INSTRUCTION[15:8];
	assign IMMEDIATE = INSTRUCTION[7:0];
	assign READREG2 = INSTRUCTION[7:0];
	assign WRITEREG = INSTRUCTION[23:16];
	assign OFFSET = INSTRUCTION[23:16];
	
	
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
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//MOV
		8'b00000001: begin
			ALUOP = 3'b000;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//ADD
		8'b00000010: begin
			ALUOP = 3'b001;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//SUB
		8'b00000011: begin
			ALUOP = 3'b001;
			MUX1 = 1;
			MUX2 = 0;
			WRITEENABLE = 1;
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//AND
		8'b00000100: begin
			ALUOP = 3'b010;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//OR
		8'b00000101: begin
			ALUOP = 3'b011;
			MUX1 = 0;
			MUX2 = 0;
			WRITEENABLE = 1;
			JUMP = 1'b0;			
			BRANCH = 1'b0;
		end
		
		//JUMP
		8'b00000110: begin
			
			JUMP = 1;
			BRANCH = 0;
			WRITEENABLE = 0;
			
		end
		//BRANCH
		8'b00000111: begin
			ALUOP = 3'b001;
			MUX1 = 1;
			MUX2 = 0;
			JUMP = 0;
			BRANCH = 1;
			WRITEENABLE = 0;
		end
		
		endcase		
	end
	
	always @ (posedge CLK)
	begin
		if(RESET) begin
			#1 PC <= 0;
		end
		else begin
		#1 PC <= NEWPC;
		end
	end
			
			
endmodule

//module control_unit(OPCODE, ALU, MUX1, MUX2, WRITEENABLE);
	

//endmodule


module pcAdder(PC, PCPLUS);
	input [31:0] PC;
	output [31:0] PCPLUS;
	
	assign #1 PCPLUS = PC +4;
	
endmodule

module branchAdder(target, offset, pc);
	output [31:0] target;
	input [31:0] pc;
	input [7:0] offset;
	
	
	
	assign #2 target = pc + {24'b0, offset};

endmodule

module mux(IN1, IN2,S, OUT);

	input [7:0] IN1, IN2;
	output [7:0] OUT;
	input S;
	
	assign OUT = S ? IN2:IN1;
endmodule

module muxExtend(IN1, IN2,S, OUT);

	input [31:0] IN1, IN2;
	output [31:0] OUT;
	input S;
	
	assign OUT = S ? IN2:IN1;
endmodule
	
module flowControlUnit(BRANCH, JUMP, ZERO, FLOW_S);
	input BRANCH, JUMP, ZERO;
	output FLOW_S;
	
	assign FLOW_S = (BRANCH & ZERO) | JUMP ;
	
endmodule;
