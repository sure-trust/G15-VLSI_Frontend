class transaction;
  rand bit[7:0]d_in;
  rand bit state;
  bit done;
  bit ss;
  bit mosi;
  constraint c1{state==1;}
  function void display(string name);
    $display("display from %s",name);
    $display("d_in=%0b,done=%0b,ss=%0b,mosi=%0b",d_in,done,ss,mosi);
endfunction
 
endclass