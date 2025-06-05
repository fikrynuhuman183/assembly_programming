module testbench;

    // Define input registers for ALU operations
    reg [7:0] op1, op2;  // 8-bit operands
    reg [2:0] sel;       // 3-bit operation selector
    
    // Define output wire for ALU result
    wire [7:0] result;   // 8-bit output from ALU
    
    // Instantiate the ALU module with inputs and output
    alu my_alu(op1, op2, result, sel);
    
    // Initialize test sequence with different input values
    initial begin
        // Test Forward operation (Pass-through)
        op1 = 8;    
        op2 = 15;
        sel = 0;
        
        #5
        
        // Test Addition operation
        op2 = 10;
        sel = 1;
        
        #5
        
        // Test Addition with different values
        op1 = 6;
        op2 = 20;
        
        #5
        
        // Test Bitwise AND operation
        op1 = 12;
        sel = 3;
        
    end
    
    // Setup waveform monitoring and simulation control
    initial begin
        $dumpfile("wavedata.vcd");  // Store simulation data in VCD file
        $dumpvars(0, my_alu);        // Record all variables of ALU module
        $monitor("TIME = %g OP1 = %d OP2 = %d SEL = %b OUT = %d", 
                 $time, op1, op2, sel, result); // Display execution details
        
        #50 $finish;  // Terminate simulation after 50 time units
    end

endmodule
