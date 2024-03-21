class environment;
mailbox gen2driv;
mailbox mon2sco;
generator gen_h;
driver driv_h;
monitor mon_h;
scoreboard sco_h;
virtual intf vif;
function new(virtual intf vif);
this.vif=vif;
gen2driv=new();
mon2sco=new();
gen_h=new(gen2driv);
driv_h=new(gen2driv,vif);
mon_h=new(mon2sco,vif);
sco_h=new(mon2sco);
endfunction
task main();
$display("display from environment");
fork
gen_h.put_msg();
driv_h.get_msg();
mon_h.put_msg();
sco_h.get_msg();
join
endtask
endclass