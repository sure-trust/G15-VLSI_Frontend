module compute_n(p,q,n,phi);
  input [3:0]p,q;
  //input clk;
  output reg [7:0]n,phi;
  
  //compute the value of n
  assign n=p*q;
  
  //finding the value of totient function
  assign phi=(n-1)*(p-1);
  
endmodule
