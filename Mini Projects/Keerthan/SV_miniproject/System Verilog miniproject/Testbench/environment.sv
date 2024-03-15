class environment;
generator gen;
driver drv;
monitor mon;
scoreboard sco;

virtual counter_intf vif;

mailbox gen2driv;
mailbox mon2sco;


  function new(mailbox gen2driv, mailbox mon2sco);
this.gen2driv = gen2driv;
this.mon2sco = mon2sco;
    gen = new(gen2driv);
    drv = new(gen2driv);
    mon = new(mon2sco);
    sco = new(mon2sco);
endfunction

task run();
drv.vif = vif;
mon.vif = vif;

fork
gen.run();
drv.run();
mon.run();
sco.run();
join_any

endtask

endclass
