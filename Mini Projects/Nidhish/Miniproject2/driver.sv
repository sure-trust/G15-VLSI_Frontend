class driver;
  transaction tx;
  mailbox gen2drv;
  
  virtual intf vif;
  
  function new(mailbox gen2drv, virtual intf vif);
    this.gen2drv=gen2drv;
    this.vif=vif;
    endfunction
  
  task run();
    repeat(1) begin
      @(vif.driv_cb);
      gen2drv.get(tx);
      vif.wr_en=tx.wr_en;
      vif.rd_en=tx.rd_en;
      vif.addr[1:0]=tx.addr[1:0];
      vif.wdata[7:0]=tx.wdata[7:0];
      vif.rdata[7:0]=tx.rdata[7:0];
      #1;
      
      tx.display("DRIVER WITH OUTPUT");
      @(vif.driv_cb);
    end
  endtask
   
  
endclass