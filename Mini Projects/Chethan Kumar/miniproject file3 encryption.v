
module modular_exponentiation(
    input [7:0] P, // Plain text
    input [7:0] e, // Exponent
    input [7:0] n, // Modulus
    output reg [7:0] C // Cipher text
);
    reg [7:0] result;
  int i=0;
    always @* begin
        result = 1;
        for (i = 0; i < e; i = i + 1) begin
            result = (result * P) % n;
        end
        C = result;
    end

endmodule
