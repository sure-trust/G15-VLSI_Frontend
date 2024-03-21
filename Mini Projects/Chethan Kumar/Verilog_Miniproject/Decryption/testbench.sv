module tb;
  reg [8:0] p,q;
  bit [63:0] P;
  reg [63:0] d;
  bit [63:0] n,phi_n;
  reg [63:0] C;
  
  Decryption dut(p,q,P,d,n,phi_n,C);
  
  initial begin
    $monitor("p: %0d q: %0d P: %0d d: %0d n: %0d phi_n: %0d C: %0d",p,q,P,d,n,phi_n,C);
  end
  
  initial begin
    p=0;
    q=0;
    d=0;
    C=0;
    
    #10;
    p=3;
    q=11;
    d=3;
    C=29;
  end
  
endmodule
