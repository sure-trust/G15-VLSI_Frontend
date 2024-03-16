class transaction;
  rand bit rd,wr;
  rand bit [7:0] din;
  
  bit full,empty;
  bit [7:0] dout;
  bit [3:0] fifo_cnt;
  bit [7:0] fifo_mem[7:0];
  bit [2:0] wr_ptr,rd_ptr;
  
  function void display(string name);
    $display("Display from %s ",name);
    $display("din: %0d  dout: %0d  rd: %0d  wr: %0d   full: %0d   empty: %0d   count: %0d",din,dout,rd,wr,full,empty,fifo_cnt);
  endfunction
endclass
