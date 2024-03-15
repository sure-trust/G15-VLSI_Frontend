class transaction;
  rand bit in;
  bit [7:0]out;
  function void display(string name);
    $display("--------%s----------",name);
    $display("in=%0b,out=%0b",in,out);
  endfunction
endclass