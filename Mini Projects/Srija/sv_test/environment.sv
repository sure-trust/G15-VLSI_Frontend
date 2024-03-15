class environment;
  mailbox gen2driv;
  mailbox mon2sco;
  
  generator gen;
  driver driv;
  monitor mon;
  scoreboard sco;
   virtual intf vif;
  function new(virtual intf vif);
    this.vif=vif;
    gen2driv=new();
    mon2sco=new();
    gen=new(gen2driv);
    driv=new(gen2driv,vif);
    mon=new(mon2sco,vif);
    sco=new(mon2sco);
  endfunction
  
  task main();
    $display("display the environment");
    fork
      gen.put_msg();
      driv.get_msg();
      mon.put_msg();
      sco.get_msg();
    join
  endtask
endclass

  
  