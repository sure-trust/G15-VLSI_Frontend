// Code your testbench here
// or browse Examples
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"
`include "environment.sv"
`include "test.sv"

module top;
  bit clk,rst;
  test tb;
  intf pif(clk,rst);
  sipo dut(.clk(pif.clk),
           .rst(pif.rst),
           .in(pif.in),
           .out(pif.out));
 
  
  always #5 clk=~clk;
  initial begin
    rst=1;
    repeat(10)@(negedge clk);
    rst=0;
    #150 $finish;
  end
  
  initial begin
    tb=new(pif);
    tb.main();
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
  
  
  