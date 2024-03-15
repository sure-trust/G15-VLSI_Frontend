class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  mailbox gen2drv=new();
  mailbox mon2scb=new();
  
  virtual intf vif;
  function new(virtual intf vif);
    this.vif=vif;
    gen=new(gen2drv);
    drv=new(gen2drv, vif);
    mon=new(mon2scb, vif);
    scb=new(mon2scb);
  endfunction
  
  task run();
    fork
      gen.write();
      drv.run();
      mon.run();
      scb.run();
    join
    
    #50 fork
      gen.read();
      drv.run();
      mon.run();
      scb.run();
       join
    #50 fork
      gen.read_write();
      drv.run();
      mon.run();
      scb.run();
   
      
     #10drv.run(); 
     #20mon.run();
     #20scb.run();
      join
    
  endtask
  
endclass
    
    