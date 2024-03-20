class environment;
  mailbox gen2driv;
  mailbox mon2sco;
  mailbox mon2cov;
  
  generator gen_h;
  driver driv_h;
  monitor mon_h;
  scoreboard sco_h;
  coverage ch;
  
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif=vif;
    gen2driv=new();
    mon2sco=new();
    mon2cov=new();
    gen_h=new(gen2driv);
    driv_h=new(gen2driv,vif);
    mon_h=new(mon2sco,vif,mon2cov);
    sco_h=new(mon2sco);
    ch=new(mon2cov);
  endfunction
  
  task main();
    $display("Display from [ Environment ]");
    fork
      gen_h.put_msg();
      driv_h.get_msg();
      mon_h.put_msg();
      sco_h.get_msg();
      ch.cov_run();
    join
  endtask
endclass
    