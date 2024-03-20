`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"
`include "environment.sv"
`include "test.sv"


module top();
  bit clk,rst;
  test tb;
  intf pif(clk,rst);
  
  fifo dut(.rst(pif.rst),.clk(pif.clk),.rd_en(pif.rd_en),.wr_en(pif.wr_en),.din(pif.din),.full(pif.full),.empty(pif.empty),.dout(pif.dout),.count(pif.count),.fifo_mem(pif.fifo_mem),.wr_ptr(pif.wr_ptr),.rd_ptr(pif.rd_ptr));
  
  always #5 clk=~clk;
  
  initial begin
    rst=1;
    #1 rst=0;
  end
  
  initial begin
    $display("display from top");
    tb=new(pif);
    tb.main();
  end
  initial begin
    $dumpfile("dum.vcd"); 
    $dumpvars();
    #175 $finish();
  end
endmodule
