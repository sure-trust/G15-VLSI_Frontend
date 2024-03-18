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

module top();
  bit clk,rst;
  test tb;
  intf pif(clk,rst);
  
  async_fifo dut(.clk(pif.clk),
                 .rst(pif.rst),
                 .rd(pif.rd),
                 .wr(pif.wr),
                 .din(pif.din),
                 .empty(pif.empty),
                 .full(pif.full),
                 .dout(pif.dout),
                 .fifo_cnt(pif.fifo_cnt),
                 .fifo_mem(pif.fifo_mem),
                 .rd_ptr(pif.rd_ptr),
                 .wr_ptr(pif.wr_ptr));
  
  always #1 clk=~clk;
  
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
    #150 $finish();
  end
endmodule
