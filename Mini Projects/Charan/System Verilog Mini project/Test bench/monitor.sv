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
      trans=new();
      trans.rd=vif.rd;
      trans.wr=vif.wr;
      trans.din=vif.din;
      trans.full=vif.full;
      trans.empty=vif.empty;
      trans.dout=vif.dout;
      trans.fifo_cnt=vif.fifo_cnt;
      trans.fifo_mem=vif.fifo_mem;
      trans.wr_ptr=vif.wr_ptr;
      trans.rd_ptr=vif.rd_ptr;
      mon2sco.put(trans);
      trans.display("monitor");
      
    end
  endtask
endclass