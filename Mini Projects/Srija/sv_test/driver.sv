class driver;
  transaction tx;
  mailbox gen2driv;
  
  virtual intf vif;
  function new(mailbox gen2driv, virtual intf vif);
    this.gen2driv=gen2driv;
    this.vif=vif;
  endfunction
  
  task get_msg();
    forever begin
      @(vif.driv_cb);
      gen2driv.get(tx);
      vif.in=tx.in;
      @(vif.driv_cb);
    end
  endtask
endclass
      