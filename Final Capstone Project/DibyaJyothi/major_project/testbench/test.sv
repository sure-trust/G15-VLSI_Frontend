class test;
environment env_h;
virtual intf vif;
function new(virtual intf vif);
this.vif=vif;
env_h=new(vif);
endfunction
task main();
$display("display from test");
env_h.main();
endtask
endclass