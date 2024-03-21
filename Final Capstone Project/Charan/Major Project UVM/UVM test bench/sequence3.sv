class reset_dut extends uvm_sequence#(transaction);
  `uvm_object_utils(reset_dut)
  
  transaction tr;

  function new(string name = "reset_dut");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        tr.randomize;
        tr.op = rstdut;
       `uvm_info("SEQ", "MODE : RESET", UVM_NONE);
        finish_item(tr);
      end
  endtask
endclass