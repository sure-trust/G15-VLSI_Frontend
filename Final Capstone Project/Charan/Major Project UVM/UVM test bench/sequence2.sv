class read_data extends uvm_sequence#(transaction);
  `uvm_object_utils(read_data)
  
  transaction tr;

  function new(string name = "read_data");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
         tr.op = readd;
        `uvm_info("SEQ", $sformatf("MODE : READ ADDR : %0d ", tr.addr), UVM_NONE);
        finish_item(tr);
      end
  endtask
endclass
  