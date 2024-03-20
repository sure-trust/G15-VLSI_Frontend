module Multiplicative_Inverse_Calculator(
  input [63:0] num,
  input [63:0] modulo,
  output reg [63:0] inverse,
    output reg valid
);

    // Function to find the multiplicative inverse using Extended Euclidean Algorithm
  function automatic int extended_gcd(longint a, longint b, ref longint x, ref longint y);
        begin
            if (b == 0) begin
                x = 1;
                y = 0;
                extended_gcd = a;
            end
            else begin
                longint x1, y1;
                extended_gcd = extended_gcd(b, a % b, .x(x1), .y(y1));
                x = y1;
                y = x1 - (a / b) * y1;
            end
        end
    endfunction

    // Main calculation
    longint x, y, gcd;
    always @(*) begin
        if (num == 0 || modulo == 0) begin
            inverse = 0; 
            valid = 0;   
        end
        else begin
            gcd = extended_gcd(num, modulo, .x(x), .y(y));
            if (gcd == 1) begin
                inverse = (x % modulo + modulo) % modulo;
                valid = 1; 
            end
            else begin
                inverse = 0; 
                valid = 0;   
            end
        end
    end

endmodule
