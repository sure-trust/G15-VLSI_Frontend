// Code your testbench here
// or browse Examples
class coverage extends uvm_component;
  transaction req;
  
  `uvm_component_utils(coverage)
  uvm_tlm_analysis_fifo#(transaction)cov_tlm;
  
  covergroup cov;
    c1:coverpoint req.tx_start{bins a[]={0,1};}
    c2:coverpoint req.rx_start{bins b[]={0,1};}
    c3:coverpoint req.parity_en{bins c={0,1};}
    c4:coverpoint req.tx_done{bins d[]={0,1};}
    c5:coverpoint req.rx_done{bins d[]={0,1};}
    c4:coverpoint req.tx_err{bins d[]={0};}
    c4:coverpoint req.rx_err{bins d[]={0};}

  endgroup
  
  function new(string name="coverage",uvm_component parent);
    super.new(name,parent);
    cov=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req=transaction::type_id::create("req");
    cov_tlm=new("cov_tlm",this);
  endfunction
  

  virtual task run_phase(uvm_phase phase);
    forever begin
      cov_tlm.get(req);
      cov.sample();
      $display("coverage=%.2f",cov.get_coverage());
    end
  endtask
endclass