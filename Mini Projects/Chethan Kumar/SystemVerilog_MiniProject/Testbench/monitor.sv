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
      //@(vif.mon_cb);
      trans=new();
      trans.rd_en=vif.rd_en;
      trans.wr_en=vif.wr_en;
      trans.din=vif.din;
      trans.full=vif.full;
      trans.empty=vif.empty;
      trans.dout=vif.dout;
      trans.count=vif.count;
      trans.fifo_mem=vif.fifo_mem;
      trans.wr_ptr=vif.wr_ptr;
      trans.rd_ptr=vif.rd_ptr;
      mon2sco.put(trans);
      mon2cov.put(trans);
      trans.display("[ Monitor ]");
      //@(vif.mon_cb);
    end
  endtask
endclass