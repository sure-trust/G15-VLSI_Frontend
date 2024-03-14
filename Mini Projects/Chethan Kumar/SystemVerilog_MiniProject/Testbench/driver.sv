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
      //how to give delay
      @(vif.driv_cb); //take a delay
      //@(vif.driv_cb);
      gen2driv.get(trans);
      //converting packet level to pin level data
      
      vif.din=trans.din;
      vif.rd_en=trans.rd_en;
      vif.wr_en=trans.wr_en;
     
      $display("from [ Driver ]");
      //@(vif.driv_cb);
      //@(vif.driv_cb);
    end
  endtask
endclass
    