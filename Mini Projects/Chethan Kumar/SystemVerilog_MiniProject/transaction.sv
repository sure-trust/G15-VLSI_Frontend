class transaction;
   //input and output port declaration
  rand bit rd_en;
  rand bit wr_en;
  rand bit [7:0] din;
  
  bit full,empty;
  bit [7:0] dout;
  bit [3:0] count;
  bit [7:0] fifo_mem[7:0];
  bit [2:0] wr_ptr;
  bit [2:0] rd_ptr;
  
  function void display(string name);
    $display("Display from %s ",name);
    $display("din: %0d | dout: %0d | rd_en: %0d | wr_en: %0d | full: %0d | empty: %0d | count: %0d |rd_ptr: %0d | wr_ptr: %0d",din,dout,rd_en,wr_en,full,empty,count,rd_ptr,wr_ptr);
  endfunction
endclass
