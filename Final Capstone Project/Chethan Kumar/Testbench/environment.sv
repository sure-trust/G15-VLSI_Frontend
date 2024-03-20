class env extends uvm_env;
`uvm_component_utils(env)

function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction

agent a;
sco s;
coverage cov;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  a = agent::type_id::create("a",this);
  s = sco::type_id::create("s", this);
  cov=coverage::type_id::create("cov",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  a.m.send.connect(s.recv);
  agen.mon.collect_port.connect(cov.cov_tlm.analysis_export);
  `uvm_info("id","-----------environment---------",UVM_MEDIUM)
endfunction

endclass
