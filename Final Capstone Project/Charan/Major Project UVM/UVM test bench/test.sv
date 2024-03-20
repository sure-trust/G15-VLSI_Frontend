class test extends uvm_test;
`uvm_component_utils(test)
  
  mem_env env;
  write_data wdata; 
  read_data rdata;
  reset_dut rst_dut;

  function new(input string name = "test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env  = mem_env::type_id::create("env",this);
    wdata  = write_data::type_id::create("wdata");
    rdata  = read_data::type_id::create("rdata");
    rst_dut = reset_dut::type_id::create("rst_dut");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    rst_dut.start(env.agen.seqr);
    wdata.start(env.agen.seqr);
    rdata.start(env.agen.seqr);
    phase.drop_objection(this);
  endtask
endclass