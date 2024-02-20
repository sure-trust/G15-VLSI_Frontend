module tb;
  reg [7:0]e,phi_n,clk;
  wire [7:0]d;
  int out;
  compute_d dut(e,phi_n,clk,d);
  
  initial begin
    clk=1'b0;
  end
  
  always #5 clk=~clk;
  
  initial begin
    e=11;
    phi_n=26;
    
    $display("Multipliactive inverse is %0d",d);
    $dumpfile("dump.vcd");
    $dumpvars();
    #100 $finish;
    
  end
endmodule


  
