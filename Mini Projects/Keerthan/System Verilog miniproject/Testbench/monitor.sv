class monitor;
mailbox mon2sco;
virtual counter_intf vif;
transaction t;

  function new(mailbox mon2sco);
this.mon2sco = mon2sco;
endfunction

task run();
t = new();
forever begin
  @(vif.mon_cb);
   @(vif.mon_cb);
t.data_input = vif.data_input;
t.address = vif.address;
t.data_out = vif.data_out;
t.wr_en = vif.wr_en;
mon2sco.put(t);
t.display("monitor");
end
endtask
endclass