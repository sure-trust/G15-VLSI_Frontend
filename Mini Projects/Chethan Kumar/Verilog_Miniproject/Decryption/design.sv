module Decryption(p,q,P,d,n,phi_n,C);
  input [8:0] p,q;
  output [63:0] P;
  input [63:0] d;
  output [63:0] n,phi_n;
  input [63:0] C;
  
  compute_n dut1(p,q,n,phi_n);
  modular_exponentiation dut2(C,d,n,P);
  
  
endmodule

module compute_n(p,q,n,phi);
  input [8:0]p,q;
  
  output reg [63:0]n,phi;
  
  //compute the value of n
  assign n=p*q;
  
  //finding the value of totient function
  assign phi=(p-1)*(q-1);
  
endmodule

module modular_exponentiation_decrypt(
  input [63:0] C, // Cipher text
  input [63:0] d, // Private exponent
  input [63:0] n, // Modulus
  output reg [63:0] P // Plain text
);

  reg [63:0] result;
    integer i;
    always @* begin
        result = 1;
        for (i = 0; i < d; i = i + 1) begin
            result = (result * C);
        end
      result = result %n;
        P = result;
    end

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

