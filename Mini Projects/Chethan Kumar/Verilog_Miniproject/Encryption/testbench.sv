module tb;
  reg [8:0] p,q;
  reg [63:0] P;
  reg [63:0] e;
  bit [63:0] n,phi_n;
  bit [63:0] C;
  
  Encryption dut(p,q,P,e,n,phi_n,C);
  
  initial begin
    $monitor("p: %0d q: %0d P: %0d e: %0d n: %0d phi_n: %0d C: %0d",p,q,P,e,n,phi_n,C);
  end
  
  initial begin
    p=0;
    q=0;
    e=0;
    P=0;
    
    #10;
    p=3;
    q=11;
    e=7;
    P=2;
  end
  
endmodule