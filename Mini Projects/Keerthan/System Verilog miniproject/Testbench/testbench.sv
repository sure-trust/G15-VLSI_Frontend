`include "transaction.sv"
`include "interface.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
module tb;

  environment env;
  counter_intf vif();
  mailbox gen2driv, mon2sco;

  sram dut (vif.clk, vif.rst, vif.wr_en, vif.data_input, vif.address, vif.data_out);

  always #5 vif.clk = ~vif.clk;

  initial begin
    vif.clk = 0;
    vif.rst = 1;
//      vif.wr_en=0;
    #3;
    vif.rst=0;
//     vif.wr_en=1;
//     #100 vif.wr_en=0;
//     #100 vif.wr_en=1;
//     #100 vif.wr_en=0;
  end

  initial begin
    gen2driv = new();
    mon2sco = new();

    env = new(gen2driv,mon2sco);
    env.vif = vif;
    env.run();
    #600;
    $finish();
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule