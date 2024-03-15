class monitor;
  mailbox mon2sco;
  transaction trans;
  virtual intf vif;
  
  function new(mailbox mon2sco,virtual intf vif);
    this.mon2sco=mon2sco;
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
     end
  endtask
endclass