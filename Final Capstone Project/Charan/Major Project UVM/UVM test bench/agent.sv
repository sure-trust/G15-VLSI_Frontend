class mem_agent extends uvm_agent;
  `uvm_component_utils(mem_agent)
  
  function new(input string name = "mem_agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  mem_driver driv;
  mem_sequencer seqr;
  mem_monitor mon; 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    mon = mem_monitor::type_id::create("mon",this);
    driv = mem_driver::type_id::create("driv",this);
    seqr = mem_sequencer::type_id::create("seqr", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass