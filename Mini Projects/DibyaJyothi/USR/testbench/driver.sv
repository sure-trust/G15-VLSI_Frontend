class driver;
mailbox gen2driv;
transaction trans;
virtual intf vif;
function new(mailbox gen2driv ,virtual intf vif);
this.gen2driv=gen2driv;
this.vif=vif;
endfunction
task get_msg;
forever begin
@(vif.driv_cb);
gen2driv.get(trans);
vif.d=trans.d;
vif.ctrl=trans.ctrl;
trans.display("driver");
@(vif.driv_cb);
end
endtask
endclass
