class mem_monitor extends uvm_monitor;
  `uvm_component_utils(mem_monitor)
  
  uvm_analysis_port#(transaction) send;
  transaction tr;
  virtual intf vif;
  logic [15:0] din;
  logic [7:0] dout;

  
  function new(input string name = "mem_monitor", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    send = new("send", this);
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))
      `uvm_error("MON","Unable to access Interface");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(vif.mon_cb);
      if(vif.rst)
        begin
          tr.op = rstdut; 
          `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
          send.write(tr);
        end
      
      else begin
        if(vif.wr)
          begin
            tr.op = writed;
            tr.addr <= vif.mon_cb.addr;
            tr.wr   = 1;
            tr.din  = vif.mon_cb.din;
            @(posedge vif.done);
            `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d",tr.addr,tr.din), UVM_NONE); 
            send.write(tr);
          end
        
        else if (!vif.wr)
          begin
            tr.op = readd; 
            tr.addr = vif.addr;
            tr.wr   = 0;
            tr.din  = vif.din;
            @(posedge vif.done);  
            tr.datard = vif.datard;
            `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d ",tr.addr,tr.datard), UVM_NONE); 
            send.write(tr);
          end      
      end
    end
  endtask 

endclass