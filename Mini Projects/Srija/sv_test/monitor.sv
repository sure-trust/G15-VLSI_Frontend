class monitor;
  mailbox mon2sco;
  mailbox mon2cov;
  transaction trans;
  virtual intf vif;
  
  function new(mailbox mon2sco,virtual intf vif,mailbox mon2cov);
    this.mon2sco=mon2sco;
    this.mon2cov=mon2cov;
    this.vif=vif;
  endfunction
  
  task put_msg;
    forever begin
      @(vif.mon_cb);
      @(vif.mon_cb);
      trans=new();
      trans.in=vif.in;
      trans.out=vif.out;
      mon2sco.put(trans);
      mon2cov.put(trans);
      trans.display("monitor");
     end
  endtask
endclass