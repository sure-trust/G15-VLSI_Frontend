class monitor;
mailbox mon2sco;
transaction trans;
virtual intf vif;
function new(mailbox mon2sco ,virtual intf vif);
this.mon2sco=mon2sco;
this.vif=vif;
endfunction
task put_msg;
trans=new();
forever begin
@(vif.mon_cb);
@(vif.mon_cb);
trans.we=vif.we;
trans.strb=vif.strb;
trans.addr=vif.addr;
trans.wdata=vif.wdata;
trans.rdata=vif.rdata;
trans.ack=vif.ack;
mon2sco.put(trans);
trans.display("monitor");
end
endtask
endclass