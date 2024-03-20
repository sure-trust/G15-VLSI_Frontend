class driver;
  mailbox gen2driv;
  transaction trans;
  virtual intf vif;
  
  function new(mailbox gen2driv,virtual intf vif);
    this.gen2driv=gen2driv;
    this.vif=vif;
  endfunction
  
  task get_msg;
    forever begin
      @(vif.driv_cb); 
      gen2driv.get(trans);
     
      
      vif.din=trans.din;
      vif.rd=trans.rd;
      vif.wr=trans.wr;
     
      $display("from [ Driver ]");
      
    end
  endtask
endclass
    