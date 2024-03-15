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
      gen2drv.get(tx);
      
      vif.enb=tx.enb;
      vif.wr=tx.wr;
      vif.rd=tx.rd;
      vif.w_addr[4:0]=tx.w_addr[4:0];
      vif.r_addr[4:0]=tx.r_addr[4:0];
      vif.w_data[7:0]=tx.w_data[7:0];
      
      #1;
      
      tx.display("DRIVER with output");
    end
    endtask
endclass

      
    