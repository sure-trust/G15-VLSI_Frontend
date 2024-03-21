module Coprime_Checker( num1,num2,coprime);

  input [31:0] num1;
  input [31:0] num2;
  output reg coprime;
  
    function automatic int gcd(int a, int b);
        begin
            if (b == 0)
                gcd = a;
            else
                gcd = gcd(b, a % b);
        end
    endfunction

    
    always @(*) begin
        if (gcd(num1, num2) == 1)
            coprime = 1; // Numbers are coprime
        else
            coprime = 0; // Numbers are not coprime
    end

endmodule
