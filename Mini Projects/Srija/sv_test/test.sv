class test;
  environment env_h;//creating environment inside the test with handle env_h
  virtual intf vif;//to connect with internal test virtual interface
  function new(virtual intf vif); ///defining the constructor
    this.vif=vif;
    env_h=new(vif);
  endfunction
  
  task main();
    $display("display the test");
    env_h.main();
  endtask
endclass