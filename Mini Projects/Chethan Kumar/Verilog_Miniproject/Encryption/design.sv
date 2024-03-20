module Encryption(p,q,P,e,n,phi_n,C);
  input [8:0] p,q;
  input [63:0] P;
  input [63:0] e;
  output [63:0] n,phi_n;
  output [63:0] C;
  
  compute_n dut1(p,q,n,phi_n);
  modular_exponentiation dut2(P,e,n,C);
  
  
endmodule

module compute_n(p,q,n,phi);
  input [8:0]p,q;
  
  output reg [63:0]n,phi;
  
  //compute the value of n
  assign n=p*q;
  
  //finding the value of totient function
  assign phi=(p-1)*(q-1);
  
endmodule

module modular_exponentiation(
  input [63:0] P, // Plain text
  input [63:0] e, // Exponent
  input [63:0] n, // Modulus
  output reg [63:0] C // Cipher text
);
  reg [63:0] result;
  int i=0;
    always @* begin
        result = 1;
        for (i = 0; i < e; i = i + 1) begin
            result = (result * P) ;
        end
        C = result % n;
    end

endmodule

