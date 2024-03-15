`include "intf.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module top;
  environment env;
  
  bit clk,enb  ; //rst
  always #5 clk=~clk;
  initial begin
   	enb=0; //rst
    repeat(1)@(negedge clk);
    enb=1; //rst
    #1000 $finish;
  end
  
  intf pif(clk,enb) ;  //rst
  do_mem dut(.clk(pif.clk), 
             //.rst(pif.rst), 
			.enb(pif.enb), 
			.wr(pif.wr), 
			.rd(pif.rd),	 
            .w_addr(pif.w_addr),					 										.r_addr(pif.r_addr),					 										.w_data(pif.w_data), 
			.r_data(pif.r_data)
            );
 
  initial begin
    env=new(pif);
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule