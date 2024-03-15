class driver;
mailbox gen2driv;
transaction t;
virtual counter_intf vif;

  function new(mailbox gen2driv);
this.gen2driv = gen2driv;
endfunction

task run();
t = new();
forever begin
@(vif.drv_cb);
gen2driv.get(t);
vif.data_input = t.data_input;
  vif.wr_en=t.wr_en;
vif.address = t.address;
  $display("-----------------------------------------------");
  t.display("driver");
@(vif.drv_cb);
end
endtask
endclass