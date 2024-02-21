module modular_exponentiation_decrypt(
    input [7:0] C, // Cipher text
    input [7:0] d, // Private exponent
    input [7:0] n, // Modulus
    output reg [7:0] P // Plain text
);

    reg [7:0] result;
    integer i;
    always @* begin
        result = 1;
        for (i = 0; i < d; i = i + 1) begin
            result = (result * C) % n;
        end
        P = result;
    end

endmodule
