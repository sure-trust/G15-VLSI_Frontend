module compute_d(
  input [7:0] e, phi_n,
  input clk,
  output reg [15:0] d
);

  task multiplicative_inverse;
    input [7:0] e, phi_n;
    output reg [15:0] d;
    int mi;
    int r1, r2, t1, t2;
    int q, r, t;
    
    r1 = e;
    r2 = phi_n;
    t1 = 0;
    t2 = 1;
    
    while (r2 > 0) begin
      q = r1 / r2;
      r = r1 % r2;
      r1 = r2;
      r2 = r;
      t = t1 - q * t2;
      t1 = t2;
      t2 = t;      
    end
   
    d = t;
  endtask

endmodule
