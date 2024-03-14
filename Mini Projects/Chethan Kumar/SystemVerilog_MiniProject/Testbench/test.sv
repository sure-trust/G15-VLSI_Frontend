class test;
  environment env_h; //creating handle for env
  virtual intf vif;
  
  function new(virtual intf vif);  //defining of constructor
    this.vif=vif;
    env_h = new(vif);   //calling the new method of env
  endfunction
  
  task main();
    $display("Display from test");
    env_h.main();
  endtask
endclass