module tb;
  reg [3:0]p,q;
  wire [7:0]phi,n;
  
  compute_n uut1(p,q,n,phi);
  
  initial begin
    $monitor("p=%0d, b=%0d  n=%0d phi=%0d",p,q,n,phi);
  end
  
  initial begin
    p=3;
    q=7;
    #10;
    p=3;
    q=10;
    #10 $finish;
  end
endmodule

