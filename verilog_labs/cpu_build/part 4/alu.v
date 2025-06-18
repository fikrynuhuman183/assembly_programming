/*
 * ALU (Arithmetic Logic Unit) Module
 * Performs arithmetic and logical operations on two 8-bit inputs
 * based on a 3-bit operation select signal
 */

module alu(DATA1, DATA2, RESULT, SELECT, ZERO);
    // Input ports:
    
    input [7:0] DATA1, DATA2;
    input [2:0] SELECT;
    
    // Output port:
    
    output reg [7:0] RESULT;
    output ZERO;
    
    // Internal wires to connect functional unit outputs:
    
    wire [7:0] forwardOut, addOut, andOut, orOut;
    
    
    // Instantiate all functional units:
    // Each unit performs a specific operation on the inputs
    FORWARD forwardUnit(DATA2, forwardOut);  // Pass-through DATA2
    ADD addUnit(DATA1, DATA2, addOut);       // Arithmetic addition
    AND andUnit(DATA1, DATA2, andOut);       // Bitwise AND
    OR orUnit(DATA1, DATA2, orOut);          // Bitwise OR
    
    /*
     * Operation selection logic
     * Sensitive to changes in functional unit outputs or SELECT signal
     * Routes the appropriate result to output based on SELECT value
     */
     
    always @ (forwardOut, addOut, andOut, orOut, SELECT)
    begin
        case (SELECT)
            3'b000 : #1 RESULT = forwardOut;  // Forward DATA2 to output
            3'b001 : #2 RESULT = addOut;       // Output addition result
            3'b010 : #1 RESULT = andOut;      // Output bitwise AND result
            3'b011 : #1 RESULT = orOut; 	// Output bitwise OR result
        endcase
        	
    end
    assign ZERO = ~(RESULT[0] | RESULT[1] | RESULT[2] | RESULT[3] | RESULT[4] | RESULT[5] | RESULT[6] | RESULT[7]);
   
    
endmodule

/*
 * ADD Module - Performs 8-bit addition
 * Implements: RESULT = DATA1 + DATA2
 * Propagation delay: 2 time units
 */
module ADD(DATA1, DATA2, RESULT);
    input [7:0] DATA1, DATA2;     // Two 8-bit operands
    output [7:0] RESULT;          // 8-bit sum output
    
    // Addition operation with timing delay
    assign RESULT = DATA1 + DATA2;
endmodule

/*
 * AND Module - Performs bitwise AND operation
 * Implements: RESULT = DATA1 & DATA2
 * Propagation delay: 1 time unit
 */
module AND(DATA1, DATA2, RESULT);
    input [7:0] DATA1, DATA2;     // Two 8-bit operands
    output [7:0] RESULT;          // 8-bit AND result
    
    // Bitwise AND operation with timing delay
    assign RESULT = DATA1 & DATA2;
endmodule

/*
 * FORWARD Module - Pass-through operation
 * Implements: RESULT = DATA (no operation)
 * Propagation delay: 1 time unit
 * Used for MOV operations or data forwarding
 */
module FORWARD(DATA, RESULT);
    input [7:0] DATA;             // 8-bit input data
    output [7:0] RESULT;          // 8-bit output (same as input)
    
    // Simple pass-through with timing delay
    assign RESULT = DATA;
endmodule

/*
 * OR Module - Performs bitwise OR operation
 * Implements: RESULT = DATA1 | DATA2
 * Propagation delay: 1 time unit
 */
module OR(DATA1, DATA2, RESULT);
    input [7:0] DATA1, DATA2;     // Two 8-bit operands
    output [7:0] RESULT;          // 8-bit OR result
    
    // Bitwise OR operation with timing delay
    assign RESULT = DATA1 | DATA2;
endmodule
