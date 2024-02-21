module modular_exponentiation_decrypt_tb;

    reg [7:0] C; // Cipher text
    reg [7:0] d; // Private exponent
    reg [7:0] n; // Modulus
    wire [7:0] P; // Plain text

    modular_exponentiation_decrypt uut(
        .C(C),
        .d(d),
        .n(n),
        .P(P)
    );

    initial begin
        
        C = 29;
        d = 3;
        n = 33;
        #10;
        $display("C = %d, d = %d, n = %d, P = %d", C, d, n, P);

        $finish;
    end

endmodule
