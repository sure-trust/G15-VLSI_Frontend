module modular_exponentiation_tb;

    reg [7:0] P; // Plain text
    reg [7:0] e; // Exponent
    reg [7:0] n; // Modulus
    wire [7:0] C; // Cipher text

    modular_exponentiation uut(
        .P(P),
        .e(e),
        .n(n),
        .C(C)
    );    
    initial begin
        
        P = 2;
        e = 7;
        n = 33;
        #10;
        $display("Test Case 1: P = %d, e = %d, n = %d, C = %d", P, e, n, C);
                
        #10;
        $finish;
    end

endmodule
