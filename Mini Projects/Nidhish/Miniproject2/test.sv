class test;
  environment env; 
  virtual intf vif;
  
  function new(virtual intf vif); 
    this.vif=vif;
    env = new(vif);   
  endfunction
  
  task main();
    $display("display from test");
    
  endtask
endclass