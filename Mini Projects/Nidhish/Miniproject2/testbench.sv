`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
module tbench_top;
environment env;
  bit clk;
  bit reset;

 
  intf pif(clk,reset);
  
 // test t1(pif);

  memory DUT (
    .clk(pif.clk),
    .reset(pif.clk),
    
    .addr(pif.addr),
    .wr_en(pif.wr_en),
    .rd_en(pif.rd_en),
    .wdata(pif.wdata),
    .rdata(pif.rdata)
   );
   always #5 clk = ~clk;

  initial begin
    reset = 1'b1;
    #10 reset =1'b0;
  end
  
  initial begin
    env=new(pif);
    env.run();
  end

  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
  initial begin
    #200 $finish;
  end
endmodule