`timescale 1ns / 1ps

module Multiplicative_Inverse_Calculator_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
  reg [63:0] num, modulo;
  bit [63:0] inverse;
    wire valid;

    // Instantiate the module under test
    Multiplicative_Inverse_Calculator uut(
        .num(num),
        .modulo(modulo),
        .inverse(inverse),
        .valid(valid)
    );

    // Clock generation
    reg clk = 0;
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Stimulus
    initial begin
        
        num = 5;
        modulo = 96;
        #100; 
        $display("Test Case 1: num = %d, modulo = %d, Inverse = %d, Valid = %b", num, modulo, inverse, valid);

        
        // End simulation
        $finish;
    end

endmodule
