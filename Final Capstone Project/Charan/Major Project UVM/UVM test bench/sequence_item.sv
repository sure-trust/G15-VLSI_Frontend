typedef enum bit [1:0]   {readd = 0, writed = 1, rstdut = 2} oper_mode;

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
  oper_mode op;
  logic wr,rst;
  randc logic [6:0] addr;
  rand logic [7:0] din;
  logic [7:0] datard;
  logic done;
         
  constraint addr_c { addr <= 10;}

  function new(string name = "transaction");
    super.new(name);
  endfunction

endclass