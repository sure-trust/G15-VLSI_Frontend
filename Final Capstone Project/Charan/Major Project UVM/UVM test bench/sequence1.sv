class write_data extends uvm_sequence#(transaction);
  `uvm_object_utils(write_data)
  
  transaction tr;

  function new(string name = "write_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
        tr.op = writed;
        `uvm_info("SEQ", $sformatf("MODE : WRITE DIN : %0d ADDR : %0d ", tr.din, tr.addr), UVM_NONE);
        finish_item(tr);
      end
  endtask
endclass