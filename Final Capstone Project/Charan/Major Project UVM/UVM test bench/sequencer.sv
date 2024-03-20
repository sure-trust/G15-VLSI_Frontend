class mem_sequencer extends uvm_sequencer#(transaction);
  `uvm_component_utils(mem_sequencer)
  
  function new(string name="mem_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass