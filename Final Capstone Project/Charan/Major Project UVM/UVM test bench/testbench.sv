`include "list.svh"
module tb;
  
  intf vif();
  
  i2c_mem dut (.clk(vif.clk),
               .rst(vif.rst),
               .wr(vif.wr),
               .addr(vif.addr),
               .din(vif.din),
               .datard(vif.datard),
               .done(vif.done));
  
  initial begin
    vif.clk <= 0;
  end

  always #1 vif.clk <= ~vif.clk;
  
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(), "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
endmodule