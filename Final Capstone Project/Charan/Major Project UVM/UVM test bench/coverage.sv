class coverage extends uvm_component;
  transaction tr;
  
  `uvm_component_utils(coverage)
  uvm_tlm_analysis_fifo#(transaction,coverage) cov_tlm;
  
  covergroup cov;
    c1:coverpoint tr.wr{bins a[]={0,1};}
    c2:coverpoint tr.rst{bins b[]={0,1};}
    c3:coverpoint tr.addr{bins c={[6:0]};}
    c4:coverpoint tr.din{bins d[]={[7:0]};}
  endgroup
  
  function new(string name="coverage",uvm_component parent);
    super.new(name,parent);
    cov=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr=transaction::type_id::create("tr");
    cov_tlm=new("cov_tlm",this);
  endfunction
  

  virtual task run_phase(uvm_phase phase);
    forever begin
      cov_tlm.get(tr);
      cov.sample();
      $display("coverage=%.2f",cov.get_coverage());
    end
  endtask
endclass 