class monitor;
  transaction tx;
  mailbox mon2scb;
  
  virtual intf vif; 
  
  function new(mailbox mon2scb, virtual intf vif);
    this.mon2scb=mon2scb;
    this.vif=vif;
    endfunction
  
  task run();
    tx=new();
    #1;
    repeat(1)begin
       @(vif.mon_cb);
       @(vif.mon_cb);
        #1;
      tx.wr_en = vif.wr_en;
      tx.rd_en=vif.rd_en;
      tx.addr[1:0] = vif.addr[1:0];
      tx.wdata[7:0] = vif.wdata[7:0];
      tx. rdata[7:0]=vif. rdata[7:0];
     
      #1;
      tx.display("COLLECTED IN MONITOR");
      mon2scb.put(tx);
    end
  endtask
   
  
endclass