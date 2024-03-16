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
trans.d=vif.d;
trans.ctrl=vif.ctrl;
trans.q=vif.q;
mon2sco.put(trans);
trans.display("monitor");
end
endtask
endclass