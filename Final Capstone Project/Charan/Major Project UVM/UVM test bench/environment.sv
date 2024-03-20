class mem_env extends uvm_env;
  `uvm_component_utils(mem_env)

  function new(input string inst = "mem_env", uvm_component c);
    super.new(inst,c);
  endfunction
  
  mem_agent agen;
  mem_scoreboard sco;
  coverage cov;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agen = mem_agent::type_id::create("agen",this);
    sco = mem_scoreboard::type_id::create("sco", this);
    cov = coverage::type_id::create("cov", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agen.mon.send.connect(sco.recv);
    agen.mon.send.connect(cov.cov_tlm.analysis_export);
    `uvm_info("id","-----------environment---------",UVM_MEDIUM)
  endfunction

endclass